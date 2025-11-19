//
//  MathAnswerSheetNavView.m
//  LearnMath
//
//  Created by 基 on 2025/10/29.
//

#import "MathAnswerSheetNavView.h"
#import "MathAnswerSheetTimeView.h"
#import "MathAnswerSheetEntry.h"
#import "MathQuestionsTask.h"
#import "MathAnswerSheetCountdownView.h"
#import "MathAnswerSheetMode.h"
#import "MathAnswerSheetViewController.h"
#import "MathQuestions.h"
@interface MathAnswerSheetNavView ()

@property (nonatomic, strong) BaseBackButton *backButton;
@property (nonatomic, strong) UIStackView *stackView;
@property (nonatomic, strong) UILabel *currentLabel;
@property (nonatomic, strong) UILabel *bigCurrentLabel;
@property (nonatomic, strong) MathAnswerSheetCountdownView *countdownView;
@property (nonatomic, strong) ScaleableButton *tutorialButton;
@property (nonatomic, strong) MathAnswerSheetTimeView *timeView;

@property (nonatomic, strong) MathAnswerSheetEntry *entry;
@property (nonatomic, strong) MathQuestionsTask *task;

@property (nonatomic, weak) NSTimer *alertTimer;
@property (nonatomic, assign) int64_t alertTime;

@end
@implementation MathAnswerSheetNavView
- (instancetype)initWithEntry:(MathAnswerSheetEntry *)entry{
    self = [super initWithFrame:CGRectZero];
    if (self) {
        _entry = entry;
        [self setupSubViews];
        [self configureWithEntry:entry];
    }
    return self;
}

- (void)dealloc {
    [self stopAlertTimer];
}

#pragma mark - Public

- (void)updateTask:(MathQuestionsTask *)task {
    if ([task.workBook.style isEqualToString:@"train"]) {
        [self stopAlertTimer];
    }
    self.task = task;
    
    __weak typeof(self) weakSelf = self;
    task.progressCompletion = ^(CGFloat progress) {
        weakSelf.countdownView.progress = progress;
    };
    
    if ([task.workBook.style isEqualToString:@"train"]) {
        task.failureCompletion = ^{
            [weakSelf stopAlertTimer];
        };
    }
    
    self.currentLabel.text = [NSString stringWithFormat:@"%ld/%ld", (long)task.taskIndex, (long)weakSelf.entry.mode.total];
    self.bigCurrentLabel.text = [NSString stringWithFormat:@"%ld/%ld", (long)task.taskIndex, (long)weakSelf.entry.mode.total];
    
    UIColor *color = [MathAnswerSheetViewController getColorWithCategoryId:task.question.categoryID];
    [self.countdownView updateBgColor:color];
    [self.timeView updateTask:task];
    
    if ([task.workBook.style isEqualToString:@"train"]) {
        [self startAlertTimer];
    }
}

- (void)hitContentView {
    self.alertTime = 0;
}

#pragma mark - Private Setup

- (void)setupSubViews {
    self.backButton = [BaseBackButton buttonWithType:UIButtonTypeCustom];
    [self.backButton setImage:[UIImage imageNamed:@"mathanswersheet_back"] forState:UIControlStateNormal];
    [self.backButton addTarget:self action:@selector(backAction:) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:self.backButton];
    [self.backButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.mas_equalTo(LearnMathScale(76.0));
        make.height.equalTo(self);
        make.leading.equalTo(self);
        make.centerY.equalTo(self);
    }];
    
    self.stackView = [[UIStackView alloc] init];
    self.stackView.axis = UILayoutConstraintAxisHorizontal;
    self.stackView.alignment = UIStackViewAlignmentCenter;
    self.stackView.distribution = UIStackViewDistributionEqualSpacing;
    [self addSubview:self.stackView];
    [self.stackView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.leading.equalTo(@(LearnMathScale(54.0)));
        make.centerY.equalTo(self);
        make.trailing.equalTo(@(-LearnMathScale(24.0)));
    }];
    
    self.currentLabel = [[UILabel alloc] init];
    self.currentLabel.textAlignment = NSTextAlignmentCenter;
    self.currentLabel.font = [UIFont ap_baloo:LearnMathScale(28.0) weight:UIFontWeightRegular];
    self.currentLabel.textColor = [UIColor colorForSet:ColorSetWhite];
    self.currentLabel.hidden = YES;
    [self.stackView addArrangedSubview:self.currentLabel];
    
    self.countdownView = [[MathAnswerSheetCountdownView alloc] init];
    self.countdownView.hidden = YES;
    [self.stackView addArrangedSubview:self.countdownView];
    [self.countdownView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(MathAnswerSheetCountdownView.width,
                                         MathAnswerSheetCountdownView.height));
    }];
    
    self.tutorialButton = [ScaleableButton buttonWithType:UIButtonTypeCustom];
    [self.tutorialButton setBackgroundImage:[UIImage imageNamed:@"mathanswersheet_tutorial"] forState:UIControlStateNormal];
    [self.tutorialButton addTarget:self action:@selector(tutorialViewAction:) forControlEvents:UIControlEventTouchUpInside];
    self.tutorialButton.hidden = YES;
    [self.stackView addArrangedSubview:self.tutorialButton];
    [self.tutorialButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(LearnMathScale(48.0), LearnMathScale(38.0)));
    }];
    
    self.timeView = [[MathAnswerSheetTimeView alloc] init];
    self.timeView.hidden = YES;
    [self.stackView addArrangedSubview:self.timeView];
    
    self.bigCurrentLabel = [[UILabel alloc] init];
    self.bigCurrentLabel.textAlignment = NSTextAlignmentCenter;
    self.bigCurrentLabel.font = [UIFont ap_baloo:LearnMathScale(30.0) weight:UIFontWeightRegular];
    self.bigCurrentLabel.textColor = [UIColor colorForSet:ColorSetWhite];
    self.bigCurrentLabel.hidden = YES;
    [self addSubview:self.bigCurrentLabel];
    [self.bigCurrentLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.center.equalTo(self);
    }];
}

- (void)configureWithEntry:(MathAnswerSheetEntry *)entry {
    self.currentLabel.hidden = NO;
    self.currentLabel.alpha = 0.0;
    self.bigCurrentLabel.hidden = YES;
    self.countdownView.hidden = YES;
    self.tutorialButton.hidden = YES;
    self.timeView.hidden = YES;
    
    if (entry.type == MathAnswerSheetEntryTypeTrain) {
        self.tutorialButton.hidden = NO;
        if (entry.mode.type == MathAnswerSheetModeTypeTimeLimit) {
            self.countdownView.hidden = NO;
            self.currentLabel.alpha = 1.0;
        } else {
            self.bigCurrentLabel.hidden = NO;
        }
    } else if (entry.type == MathAnswerSheetEntryTypeTest) {
        if (entry.mode.type == MathAnswerSheetModeTypeQuestionsLimit) {
            self.bigCurrentLabel.hidden = NO;
        } else if (entry.mode.type == MathAnswerSheetModeTypeTimeLimit) {
            self.countdownView.hidden = NO;
        } else if (entry.mode.type == MathAnswerSheetModeTypeSurvive) {
            self.timeView.hidden = NO;
        }
    }
}

#pragma mark - Timer Control

- (void)startAlertTimer {
    [self stopAlertTimer];
    __weak typeof(self) weakSelf = self;
    NSTimer *timer = [NSTimer scheduledTimerWithTimeInterval:1.0 repeats:YES block:^(NSTimer * _Nonnull t) {
        __strong typeof(weakSelf) self = weakSelf;
        if (!self) {
            [t invalidate];
            return;
        }
        self.alertTime += 1;
        if (self.alertTime % 5 == 0) {
            [self shakeWithDuration:1.0];
        }
    }];
    [[NSRunLoop currentRunLoop] addTimer:timer forMode:NSRunLoopCommonModes];
    self.alertTimer = timer;
}

- (void)stopAlertTimer {
    [self.tutorialButton.layer removeAnimationForKey:@"shakeIt"];
    [self.alertTimer invalidate];
    _alertTimer = nil;
    _alertTime = 0;
}

- (void)shakeWithDuration:(CFTimeInterval)duration {
    [self.tutorialButton.layer removeAnimationForKey:@"shakeIt"];
    
    CAKeyframeAnimation *translation = [CAKeyframeAnimation animationWithKeyPath:@"transform.translation.x"];
    translation.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionLinear];
    translation.values = @[@(-5), @(5), @(-5), @(5), @(-3), @(3), @(-2), @(2), @(0)];
    
    NSMutableArray *rotationValues = [NSMutableArray array];
    for (NSNumber *deg in translation.values) {
        double radians = M_PI * deg.doubleValue / 180.0;
        [rotationValues addObject:@(radians)];
    }
    CAKeyframeAnimation *rotation = [CAKeyframeAnimation animationWithKeyPath:@"transform.rotation.z"];
    rotation.values = rotationValues;
    
    CAAnimationGroup *group = [CAAnimationGroup animation];
    group.repeatCount = 2;
    group.animations = @[translation, rotation];
    group.duration = duration;
    
    [self.tutorialButton.layer addAnimation:group forKey:@"shakeIt"];
}

#pragma mark - Actions

- (void)backAction:(BaseBackButton *)sender {
    if ([self.delegate respondsToSelector:@selector(mathAnswerSheetNavView:didClickedBackAction:)]) {
        [self.delegate mathAnswerSheetNavView:self didClickedBackAction:sender];
    }
}

- (void)tutorialViewAction:(UIView *)sender {
    if ([self.delegate respondsToSelector:@selector(mathAnswerSheetNavView:didClickedTutorialViewAction:task:)]) {
        [self.delegate mathAnswerSheetNavView:self didClickedTutorialViewAction:sender task:self.task];
    }
}
@end
