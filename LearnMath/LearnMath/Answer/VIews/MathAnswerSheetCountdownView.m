//
//  MathAnswerSheetCountdownView.m
//  LearnMath
//
//  Created by 基 on 2025/10/23.
//

#import "MathAnswerSheetCountdownView.h"
@interface MathAnswerSheetCountdownView ()

@property (nonatomic, strong) UIView *progressBgView;
@property (nonatomic, strong) UIView *progressInnverBgView;
@property (nonatomic, strong) UIView *progressContentView;
@property (nonatomic, strong) UIView *progressView;
@property (nonatomic, strong) UIView *clockView;
@property (nonatomic, strong) UIView *clockInnerView;
@property (nonatomic, strong) UIImageView *clockIconImageView;

@property (nonatomic, strong) UIColor *bcColor;

@end

@implementation MathAnswerSheetCountdownView

+ (CGFloat)width {
    return LearnMathScale(118.0);
}

+ (CGFloat)height {
    return LearnMathScale(34.0);
}

- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        [self setupSubViews];
    }
    return self;
}

- (void)setProgress:(CGFloat)progress {
    _progress = progress;
    [CATransaction begin];
    [CATransaction setDisableActions:YES];
    CGRect progressFrame = self.progressView.frame;
    progressFrame.origin.x = -(self.progressView.frame.size.width * progress);
    self.progressView.frame = progressFrame;
    [CATransaction commit];
}

- (void)setBcColor:(UIColor *)bcColor {
    _bcColor = bcColor;
    self.clockInnerView.backgroundColor = bcColor;
}

- (void)updateBgColor:(UIColor *)bgColor {
    self.bcColor = bgColor;
    self.progressView.backgroundColor = self.bcColor;
}

- (void)setupSubViews {
    CGFloat progressBgViewH = LearnMathScale(22.0);
   self.progressBgView = [[UIView alloc] init];
   self.progressBgView.backgroundColor = [UIColor colorForSet:ColorSetWhite];
   self.progressBgView.layer.cornerRadius = progressBgViewH * 0.5;
   [self addSubview:self.progressBgView];
   
   [self.progressBgView mas_makeConstraints:^(MASConstraintMaker *make) {
       make.centerY.equalTo(self);
       make.leading.trailing.equalTo(self);
       make.height.mas_equalTo(progressBgViewH);
   }];
   
   // 2. progressInnverBgView
   CGFloat progressViewH = progressBgViewH - LearnMathScale(8.0);
   self.progressInnverBgView = [[UIView alloc] init];
   self.progressInnverBgView.backgroundColor = [UIColor colorForSet:ColorSetProgressBg];
   self.progressInnverBgView.layer.cornerRadius = progressViewH * 0.5;
   [self.progressBgView addSubview:self.progressInnverBgView];
   
   [self.progressInnverBgView mas_makeConstraints:^(MASConstraintMaker *make) {
       make.centerY.equalTo(self.progressBgView);
       make.leading.equalTo(@(LearnMathScale(4.0)));
       make.trailing.equalTo(@(-LearnMathScale(4.0)));
       make.height.mas_equalTo(progressViewH);
   }];
   
   // 3. progressContentView (手动frame，因为后面要直接操作frame)
   CGFloat progressViewX = MathAnswerSheetCountdownView.height - LearnMathScale(8.0);
   CGFloat progressViewW = MathAnswerSheetCountdownView.width - LearnMathScale(4.0) - progressViewX;
   CGRect progressFrame = CGRectMake(progressViewX, (progressBgViewH - progressViewH) * 0.5, progressViewW, progressViewH);
   self.progressContentView = [[UIView alloc] initWithFrame:progressFrame];
   self.progressContentView.clipsToBounds = YES;
   [self.progressBgView addSubview:self.progressContentView];
   
   // 4. progressView
   self.progressView = [[UIView alloc] initWithFrame:self.progressContentView.bounds];
   [self.progressView roundCorners:(UIRectCornerTopRight | UIRectCornerBottomRight) radius:progressViewH * 0.5];
   [self.progressContentView addSubview:self.progressView];
   
   // 5. clockView
   self.clockView = [[UIView alloc] init];
   self.clockView.backgroundColor = [UIColor colorForSet:ColorSetWhite];
   self.clockView.layer.cornerRadius = MathAnswerSheetCountdownView.height * 0.5;
   [self addSubview:self.clockView];
   
   [self.clockView mas_makeConstraints:^(MASConstraintMaker *make) {
       make.leading.top.bottom.equalTo(self);
       make.width.equalTo(self.clockView.mas_height);
   }];
   
   // 6. clockInnerView
   self.clockInnerView = [[UIView alloc] init];
   self.clockInnerView.layer.cornerRadius = (MathAnswerSheetCountdownView.height - LearnMathScale(8.0)) * 0.5;
   [self.clockView addSubview:self.clockInnerView];
   
   [self.clockInnerView mas_makeConstraints:^(MASConstraintMaker *make) {
       make.leading.top.equalTo(@(LearnMathScale(4.0)));
       make.bottom.equalTo(@(-LearnMathScale(4.0)));
       make.width.equalTo(self.clockInnerView.mas_height);
   }];
   
   // 7. clockIconImageView
   self.clockIconImageView = [[UIImageView alloc] init];
    self.clockIconImageView.image = [UIImage imageNamed:@"mathanswersheet_clock"];
   [self.clockView addSubview:self.clockIconImageView];
   
   [self.clockIconImageView mas_makeConstraints:^(MASConstraintMaker *make) {
       make.leading.equalTo(@(LearnMathScale(13.52)));
       make.top.equalTo(@(LearnMathScale(9.23)));
       make.size.mas_equalTo(CGSizeMake(LearnMathScale(11.5), LearnMathScale(11.0)));
   }];
}

@end
