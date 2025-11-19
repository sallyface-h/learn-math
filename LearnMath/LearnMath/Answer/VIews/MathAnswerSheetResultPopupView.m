//
//  MathAnswerSheetResultPopupView.m
//  LearnMath
//
//  Created by 基 on 2025/10/20.
//

#import "MathAnswerSheetResultPopupView.h"
@interface MathAnswerSheetResultPopupView ()

@property (nonatomic, strong) UIView *contentView;
@property (nonatomic, strong) UIImageView *resultImageView;
@property (nonatomic, assign) MathAnswerSheetResult result;

@end

@implementation MathAnswerSheetResultPopupView
- (instancetype)initWithResult:(MathAnswerSheetResult)result frame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        _result = result;
        [self setUpSubviews];
    }
    return self;
}
 
- (void)setUpSubviews
{
    //让这个弹窗可以响应触摸事件
    self.userInteractionEnabled = YES;
    
    self.contentView = [[UIView alloc] init];
    self.contentView.alpha = 0.0;
    self.contentView.transform = CGAffineTransformMakeScale(0.5, 0.5);
    [self addSubview:self.contentView];
    
    [self.contentView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.center.equalTo(self);
        make.size.mas_equalTo(CGSizeMake(280.0, 288.0));
    }];
    
    NSString *imageName = (self.result == MathAnswerSheetResultCorrect) ? @"mathanswersheet_correct" : @"mathanswersheet_wrong";
    self.resultImageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:imageName]];
    [self.contentView addSubview:self.resultImageView];
    
    [self.resultImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self.contentView);
    }];
}

- (void)show {
    self.contentView.alpha = 0.0;
    self.contentView.transform = CGAffineTransformMakeScale(0.5, 0.5);
    //UIViewAnimationOptionCurveEaseOut 先快后慢，看起来更自然
    [UIView animateWithDuration:0.25 delay:0 options:UIViewAnimationOptionCurveEaseOut animations:^{
            self.contentView.alpha = 1.0;
        //CGAffineTransformIdentity 恢复原始大小
            self.contentView.transform = CGAffineTransformIdentity;
        } completion:^(BOOL finished) {
            dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                [self hide];
            });
        }];
}

- (void)hide {
    [UIView animateWithDuration:0.25 delay:0 options:UIViewAnimationOptionCurveEaseInOut animations:^{
        self.contentView.alpha = 0.0;
        self.contentView.transform = CGAffineTransformMakeScale(0.5, 0.5);
    } completion:^(BOOL finished) {
        [self removeFromSuperview];
    }];
}
@end
