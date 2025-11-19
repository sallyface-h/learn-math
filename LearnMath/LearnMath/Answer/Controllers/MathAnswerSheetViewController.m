//
//  MathAnswerSheetViewController.m
//  LearnMath
//
//  Created by 基 on 2025/10/21.
//

#import "MathAnswerSheetViewController.h"
#import "ArithmeticConstant.h"
#import "UIColor+UIColor_Appearance.h"
#import "MathAnswerSheetNavView.h"
#import "MathAnswerSheetContentView.h"
#import "MathAnswerSheetInputView.h"
#import "MathAnswerSheetPreviewView.h"
#import "MathQuestionsGenerator.h"
#import "ArithmeticDbService.h"
#import "MathAnswerSheetEntry.h"
#import "MathAnswerSheetMode.h"
#import "MathAnswerSheetPreviewView.h"
#import "AppStoreKit.h"
#import "MathSkills.h"
#import "MathWorkSelectedTrainOptions.h"
#import "MathWorkSelectedTestOptions.h"
#import "MathQuestionAnswer.h"
#import "MathQuestions.h"
#import "MathAnswerSheetViewModel.h"
@interface MathAnswerSheetViewController () <MathAnswerSheetNavViewDelegate, MathAnswerSheetInputViewDelegate, MathAnswerSheetPreviewViewDelegate>

@property (nonatomic, strong) MathAnswerSheetNavView *navView;
@property (nonatomic, strong) MathAnswerSheetContentView *contentView;
@property (nonatomic, strong) MathAnswerSheetInputView *answerInputView;
@property (nonatomic, weak) MathAnswerSheetPreviewView *previewView;
@property (nonatomic, strong) ArithmeticDbService *dbService;
@property (nonatomic, assign) BOOL isViewDidAppear;
@property (nonatomic, assign) BOOL shouldShowPreview;
@property (nonatomic, strong) UIColor *bgColor;
@property (nonatomic, strong) MathQuestionsGenerator *questionsGenerator;
@property (nonatomic, strong) MathAnswerSheetEntry *entry;
@end

@implementation MathAnswerSheetViewController
- (instancetype)initWithParams:(NSDictionary *)params {
    if (self = [super init]) {
        _bgColor = params[@"bgColor"];
        MathWorkSelectedTrainOptions *trainOptions = params[@"trainOptions"];
        MathWorkSelectedTestOptions *testOptions = params[@"testOptions"];
        
        if (trainOptions) {
            _entry = [MathAnswerSheetEntry trainWithOptions:trainOptions];
            self.entry.mode = [MathAnswerSheetViewModel modeForEntry:self.entry];
        } else if (testOptions) {
            _entry = [MathAnswerSheetEntry testWithOptions:testOptions];
            self.entry.mode = [MathAnswerSheetViewModel modeForEntry:self.entry];
        }
        
        self.isBackGestureEnable = NO;
    }
    return self;
}

+ (CGFloat)maxWidth {
    return 800.0;
}

+ (CGFloat)leftAndRightSpacing {
    CGFloat screenW = SCREEN_WIDTH;
    CGFloat baseSpacing = LearnMathScale(24.0);
    CGFloat spacing = (screenW - baseSpacing * 2.0) > [self maxWidth]
        ? (screenW - [self maxWidth]) * 0.5
        : baseSpacing;
    return spacing;
}

+ (CGFloat)finalWidth {
    CGFloat screenW = SCREEN_WIDTH;
    CGFloat spacing = [self leftAndRightSpacing];
    return floor(screenW - spacing * 2.0);
}

+ (CGFloat)inputViewHeight {
    return LearnMathScale(303.0);
}

+ (CGFloat)contentViewBottomSpacing {
    return LearnMathScale(36.0);
}

+ (CGFloat)contentViewHW {
    return LearnMathScale(335.0);
}

+ (CGFloat)contentViewLeftAndRightSpacing {
    return LearnMathScale(20.0);
}


- (void)loadView {
    UIView *v = [[UIView alloc] initWithFrame:[UIScreen mainScreen].bounds];
    self.view = v;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self setupSubViews];
    
    [self.previewView removeFromSuperview];
    self.previewView = nil;
    
    if (self.entry.type == MathAnswerSheetEntryTypeTrain) {
        MathWorkSelectedTrainOptions *operation = self.entry.trainOptions;
        BOOL hadShow = [AppStoreKit skillPreviewIsShow:operation.skillID];
        self.shouldShowPreview = !hadShow;
        
        if (self.shouldShowPreview) {
            MathAnswerSheetPreviewView *preview = [[MathAnswerSheetPreviewView alloc] initWithTrainSkillId:operation.skillID navBarView:self.navView];
            preview.delegate = self;
            [self.view addSubview:preview];
            [preview mas_makeConstraints:^(MASConstraintMaker *make) {
                make.edges.equalTo(self.view);
            }];
            self.previewView = preview;
        }
    }
}

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    
    if (!self.isViewDidAppear) {
        self.isViewDidAppear = YES;
        if (!self.shouldShowPreview) {
            [self generateQuestions];
        }
    }
}

- (void)setupSubViews
{
    self.navHide = YES;
    self.view.backgroundColor = [UIColor colorForSet:ColorSetPurple];
    
    self.navView = [[MathAnswerSheetNavView alloc] initWithEntry:self.entry];
    self.navView.delegate = self;
    [self.view addSubview:self.navView];
    [self.navView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.view.mas_safeAreaLayoutGuideTop);
        make.leading.equalTo(self.view.mas_leading);
        make.trailing.equalTo(self.view.mas_trailing);
        make.height.mas_equalTo(LearnMathScale(64.0));
    }];
    
    self.answerInputView = [[MathAnswerSheetInputView alloc] init];
    self.answerInputView.delegate = self;
    [self.view addSubview:self.answerInputView];
    [self.answerInputView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(self.view);
        make.centerX.equalTo(self.view);
        make.width.mas_equalTo([MathAnswerSheetViewController finalWidth]);
        make.height.mas_equalTo([MathAnswerSheetViewController inputViewHeight]);
    }];
    
    self.contentView = [[MathAnswerSheetContentView alloc] initWithBgColor:self.bgColor frame:CGRectMake(0, 0, [MathAnswerSheetViewController contentViewHW], [MathAnswerSheetViewController contentViewHW])];
    [self.view addSubview:self.contentView];
    [self.contentView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(self.answerInputView.mas_top).offset(-LearnMathScale(36.0));
        make.centerX.equalTo(self.view);
        make.width.height.mas_equalTo([MathAnswerSheetViewController contentViewHW]);
    }];
}

- (void)generateQuestions {
    [self.questionsGenerator stopTimer];
    self.questionsGenerator = nil;
    
    __weak typeof(self) weakSelf = self;
    self.questionsGenerator = [[MathQuestionsGenerator alloc] initWithEntry:self.entry nextTaskAction:^(MathQuestionsTask *task) {

        __strong typeof(weakSelf) strongSelf = weakSelf;
        if (!strongSelf) return;
        
        [strongSelf.navView updateTask:task];
        
        [strongSelf.contentView updateTask:task bgColor:self.bgColor isShowAnswer:NO];
        
    } completedAction:^(MathQuestionsTask * _Nullable task) {
        __strong typeof(weakSelf)strongSelf = weakSelf;
        
        [strongSelf.questionsGenerator stopTimer];
        strongSelf.questionsGenerator = nil;
        [[NSNotificationCenter defaultCenter] postNotificationName:@"TrainProgressDidUpdate" object:nil];
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1.25 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            if (!strongSelf) return;
            [strongSelf.navigationController popViewControllerAnimated:YES];
        });
       
    }];

    [self.questionsGenerator start];
}

- (void)mathAnswerSheetNavView:(MathAnswerSheetNavView *)mathAnswerSheetNavView didClickedBackAction:(BaseBackButton *)sender
{
    [self.questionsGenerator finishByUser];
    [[NSNotificationCenter defaultCenter] postNotificationName:@"TrainProgressDidUpdate" object:nil];
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)mathAnswerSheetPreviewView:(MathAnswerSheetPreviewView *)mathAnswerSheetPreviewView didClickedBackAction:(BaseBackButton *)sender
{
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)mathAnswerSheetPreviewView:(MathAnswerSheetPreviewView *)finishedMathAnswerSheetPreviewView skillID:(NSString *)skillID
{
    self.shouldShowPreview = NO;
    [AppStoreKit setSkillPreviewIsShow:YES skillId:skillID];

    [self generateQuestions];
}

- (void)mathAnswerSheetInputView:(MathAnswerSheetInputView *)mathAnswerSheetInputView
           didClickedOperationButton:(ScaleableButton *)btn
                                 item:(MathAnswerSheetInputItem *)item
{
    [self.contentView receiveInputItem:item];
}
@end
