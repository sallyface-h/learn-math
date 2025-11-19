//
//  MathAnswerSheetPreviewView.m
//  LearnMath
//
//  Created by 基 on 2025/10/21.
//

#import "MathAnswerSheetPreviewView.h"
@interface MathAnswerSheetPreviewView ()

@property (nonatomic, weak) UIView *navBarView;
@property (nonatomic, strong) BaseBackButton *backButton;
@property (nonatomic, strong) UIImageView *previewImageView;
@property (nonatomic, strong) UIImageView *topLogoImageView;
@property (nonatomic, strong) UIImageView *bottomLogoImageView;
@property (nonatomic, strong) UIImageView *tipsImageView;
@property (nonatomic, strong) UIView *tipsContentView;
@property (nonatomic, strong) UILabel *tipsLabel;
@property (nonatomic, strong) UIStackView *buttonStackVIew;
@property (nonatomic, strong) ScaleableButton *previousButton;
@property (nonatomic, strong) ScaleableButton *nextButton;
@property (nonatomic, strong) NSString *skillID;
@property (nonatomic, assign) NSInteger imageIndex;

@property (nonatomic, strong)MathAnswerSheetPreviewViewModel *viewModel;
@property (nonatomic, strong)MathAnswerSheetPreviewImages *model;
@end

@implementation MathAnswerSheetPreviewView
- (instancetype)initWithTrainSkillId:(NSString *)trainSkillId navBarView:(UIView * _Nullable)navBarView
{
    if (self == [super initWithFrame:CGRectZero]) {
        _navBarView = navBarView;
        _imageIndex = 0;
        _skillID = trainSkillId;
        [self setUpSubviews];
    }
    return self;
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    
    if (self.navBarView && !CGRectEqualToRect(self.navBarView.frame, CGRectZero)) {
        [self.backButton mas_makeConstraints:^(MASConstraintMaker *make) {
            make.width.mas_equalTo(LearnMathScale(76.0));
            make.height.mas_equalTo(self.navBarView);
            make.centerY.equalTo(self.navBarView);
            make.leading.equalTo(self);
        }];
    }
}

- (void)setUpSubviews
{
    self.viewModel = [[MathAnswerSheetPreviewViewModel alloc] init];
    [self.viewModel loadPreviewData:self.skillID];
    self.model = self.viewModel.model;
    
    self.backgroundColor = [UIColor colorForSet:ColorSetPurple];
    
    self.backButton = [BaseBackButton buttonWithType:UIButtonTypeCustom];
    [self.backButton setImage:[UIImage imageNamed:@"mathanswersheet_back"] forState:UIControlStateNormal];
    [self.backButton addTarget:self action:@selector(backAction:) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:self.backButton];
    
    
    self.previewImageView = [[UIImageView alloc] init];
    [self showImages];
    [self addSubview:self.previewImageView];
    [self.previewImageView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerX.equalTo(self);
            make.size.mas_equalTo(LearnMathScale(335.0));
            make.top.mas_equalTo(LearnMathScale(138.0));
        }];

    
    self.topLogoImageView = [[UIImageView alloc] init];
    self.topLogoImageView.image = [UIImage imageNamed:@"mathanswersheet_preview_log"];
    [self addSubview:self.topLogoImageView];
    [self.topLogoImageView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.trailing.equalTo(self.previewImageView);
            make.top.equalTo(self.previewImageView).offset(-LearnMathScale(68.0));
            make.size.mas_equalTo(CGSizeMake(LearnMathScale(127.0),LearnMathScale(97.0)));
        }];
    
    self.bottomLogoImageView = [[UIImageView alloc] init];
    self.bottomLogoImageView.image = [UIImage imageNamed:@"mathanswersheet_preview_log"];
    [self addSubview:self.bottomLogoImageView];
    [self.bottomLogoImageView mas_makeConstraints:^(MASConstraintMaker *make) {
           make.trailing.equalTo(self.previewImageView).offset(-LearnMathScale(17.0));
           make.top.equalTo(self.previewImageView.mas_bottom).offset(LearnMathScale(82.0));
           make.size.mas_equalTo(CGSizeMake(LearnMathScale(170.0),LearnMathScale(130.0)));
       }];
    
    self.tipsImageView = [[UIImageView alloc] init];
    self.tipsImageView.image = [UIImage imageNamed:@"mathanswersheet_preview_tips"];
    [self addSubview:self.tipsImageView];
    [self.tipsImageView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.trailing.equalTo(self.previewImageView).offset(-LearnMathScale(92.0));
            make.top.equalTo(self.previewImageView.mas_bottom).offset(LearnMathScale(30.0));
            make.size.mas_equalTo(CGSizeMake(LearnMathScale(241.0),LearnMathScale(62.0)));
        }];
    
    self.buttonStackVIew = [[UIStackView alloc] init];
    self.buttonStackVIew.distribution = UIStackViewDistributionFill;
    self.buttonStackVIew.axis = UILayoutConstraintAxisHorizontal;
    self.buttonStackVIew.alignment = UIStackViewAlignmentFill;
    self.buttonStackVIew.spacing = LearnMathScale(10.0);
    [self addSubview:self.buttonStackVIew];
    [self.buttonStackVIew mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self);
        make.bottom.mas_equalTo(-LearnMathScale(41.0));
    }];
    
    self.previousButton = [ScaleableButton buttonWithType:UIButtonTypeCustom];

    [self.previousButton setTitleColor:[UIColor colorForSet:ColorSetPurple] forState:UIControlStateNormal];
    self.previousButton.titleLabel.font = [UIFont ap_baloo:20.0 weight:UIFontWeightBold];
    [self.previousButton setTitle:@"Previous" forState:UIControlStateNormal];
    self.previousButton.backgroundColor = [UIColor colorForSet:ColorSetWhite];
    self.previousButton.hidden = YES;
    self.previousButton.layer.cornerRadius = LearnMathScale(10.0);
    self.previousButton.layer.masksToBounds = NO;
    self.previousButton.layer.shadowColor = [UIColor colorForSet:ColorSetBorderShadow].CGColor;
    self.previousButton.layer.shadowOpacity = 1.0;
    self.previousButton.layer.shadowOffset = CGSizeMake(0.0, LearnMathScale(6.0));
    self.previousButton.layer.shadowRadius = 0;
    self.previousButton.layer.borderColor = [UIColor colorForSet:ColorSetPurple].CGColor;
    self.previousButton.layer.borderWidth = LearnMathScale(2.0);
    [self.previousButton addTarget:self action:@selector(previousButtonAction:) forControlEvents:UIControlEventTouchUpInside];
    [self.buttonStackVIew addArrangedSubview:self.previousButton];
    [self.previousButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.mas_equalTo(LearnMathScale(158.0));
        make.height.mas_equalTo(LearnMathScale(50.0));
    }];
    
    self.nextButton = [ScaleableButton buttonWithType:UIButtonTypeCustom];
    [self.nextButton setTitleColor:[UIColor colorForSet:ColorSetWhite] forState:UIControlStateNormal];
    self.nextButton.titleLabel.font = [UIFont ap_baloo:20.0 weight:UIFontWeightBold];
    [self.nextButton setTitle:@"Next" forState:UIControlStateNormal];
    self.nextButton.backgroundColor = [UIColor colorForSet:ColorSetOrange];
    self.nextButton.layer.cornerRadius = LearnMathScale(10.0);
    self.nextButton.layer.masksToBounds = NO;
    self.nextButton.layer.shadowColor = [UIColor colorForSet:ColorSetBorderShadow].CGColor;
    self.nextButton.layer.shadowOpacity = 1.0;
    self.nextButton.layer.shadowOffset = CGSizeMake(0.0,LearnMathScale(6.0));
    self.nextButton.layer.shadowRadius = 0;
    self.nextButton.layer.borderColor = [UIColor colorForSet:ColorSetPurple].CGColor;
    self.nextButton.layer.borderWidth = LearnMathScale(2.0);
    [self.buttonStackVIew addArrangedSubview:self.nextButton];
    [self.nextButton addTarget:self action:@selector(nextButtonAction:) forControlEvents:UIControlEventTouchUpInside];
    [self.nextButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.mas_equalTo(LearnMathScale(158.8));
        make.height.mas_equalTo(LearnMathScale(50.0));
    }];
    
    self.tipsContentView = [[UIView alloc] init];
    self.tipsContentView.backgroundColor = [UIColor colorForSet:ColorSetWhite];
    self.tipsContentView.layer.cornerRadius = LearnMathScale(5.0);
    self.tipsContentView.hidden = YES;
    [self addSubview:self.tipsContentView];
    [self.tipsContentView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.previewImageView.mas_bottom).offset(LearnMathScale(30.0));
        make.leading.equalTo(self.previewImageView).offset(LearnMathScale(2.0));
        make.trailing.equalTo(self.previewImageView).offset(-LearnMathScale(2.0));
        make.bottom.equalTo(self.buttonStackVIew.mas_top).offset(-LearnMathScale(30.0));
    }];
    
    self.tipsLabel = [[UILabel alloc] init];
    self.tipsLabel.numberOfLines = 0;
    [self.tipsContentView addSubview:self.tipsLabel];
    [self.tipsLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.center.equalTo(self.tipsContentView);
    }];
}

- (void)showImages {
    NSString *imgName = self.model.imgName[self.imageIndex];
    if (imgName.length > 0) {
        self.previewImageView.image = [UIImage imageNamed:imgName];
    }
}

- (void)changeStyle {
    if (self.previousButton.hidden) {
        self.topLogoImageView.hidden = YES;
        self.tipsImageView.hidden = NO;
        self.bottomLogoImageView.hidden = NO;
        self.tipsContentView.hidden = YES;
    } else {
        self.topLogoImageView.hidden = NO;
        self.tipsImageView.hidden = YES;
        self.bottomLogoImageView.hidden = YES;
        self.tipsContentView.hidden = NO;
    }
}

- (void)setTipContent:(NSString *)content rangeLocation:(NSInteger)rangeLocation rangeLength:(NSInteger)rangeLength
{
    NSRange range = NSMakeRange(rangeLocation, rangeLength);
    NSValue *rangeValue = [NSValue valueWithRange:range];
    NSMutableParagraphStyle *style = [[NSMutableParagraphStyle alloc] init];
    style.alignment = NSTextAlignmentCenter;
    style.lineSpacing = LearnMathScale(2.0);
    NSMutableAttributedString *attr = [[NSMutableAttributedString alloc] initWithString:content attributes:@{
        NSFontAttributeName : [UIFont ap_baloo:20.0 weight:UIFontWeightRegular],
        NSForegroundColorAttributeName : [UIColor colorForSet:ColorSetPurple],
        NSParagraphStyleAttributeName : style
    }];
    if (rangeValue) {
        [attr addAttributes:@{
            NSFontAttributeName : [UIFont ap_baloo:20.0 weight:UIFontWeightRegular],
            NSForegroundColorAttributeName : [UIColor colorForSet:ColorSetLightPink],
            NSParagraphStyleAttributeName: style
        } range:range];
    }
    self.tipsLabel.attributedText = attr;
}

- (void)previousButtonAction:(id)sender {
    self.imageIndex--;
    [self showImages];
    self.previousButton.hidden = self.imageIndex <= 0;

    if (self.imageIndex != 0) {
        NSString *content = self.model.content[self.imageIndex - 1];
        NSInteger rangeLocation = [self.model.rangeLocation[self.imageIndex - 1] integerValue];
        NSInteger rangeLength   = [self.model.rangeLength[self.imageIndex - 1] integerValue];
        [self setTipContent:content rangeLocation:rangeLocation rangeLength:rangeLength];
    }
    NSArray *images = self.model.imgName;
    if (self.imageIndex >= images.count - 1) {
        [self.nextButton setTitle:@"Try it!" forState:UIControlStateNormal];
    } else {
        [self.nextButton setTitle:@"Next" forState:UIControlStateNormal];
    }
    
    [self changeStyle];
}

- (void)nextButtonAction:(id)sender {
    NSArray *images = self.model.imgName;
    if (self.imageIndex == images.count - 1) {
        [self finish];
    } else {
        self.imageIndex++;
        [self showImages];
        if (self.imageIndex >= images.count - 1) {
            [self.nextButton setTitle:@"Try it!" forState:UIControlStateNormal];
        } else {
            [self.nextButton setTitle:@"Next" forState:UIControlStateNormal];
        }
        self.previousButton.hidden = !(self.imageIndex > 0);
        NSString *content = self.model.content[self.imageIndex - 1];
        NSInteger rangeLocation = [self.model.rangeLocation[self.imageIndex - 1] integerValue];
        NSInteger rangeLength   = [self.model.rangeLength[self.imageIndex - 1] integerValue];
        [self setTipContent:content rangeLocation:rangeLocation rangeLength:rangeLength];
    }
    [self changeStyle];
    
}

- (void)finish {
    if ([self.delegate respondsToSelector:@selector(mathAnswerSheetPreviewView:skillID:)]) {
           [self.delegate mathAnswerSheetPreviewView:self skillID:self.skillID];
       }
    
    [UIView animateWithDuration:0.25 animations:^{
        self.alpha = 0.0;
    } completion:^(BOOL finished) {
        [self removeFromSuperview];
    }];
}

- (void)backAction:(BaseBackButton *)sender {
    if ([self.delegate respondsToSelector:@selector(mathAnswerSheetPreviewView:didClickedBackAction:)]) {
        [self.delegate mathAnswerSheetPreviewView:self didClickedBackAction:sender];
    }
}
@end
