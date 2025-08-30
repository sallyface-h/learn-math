//
//  ViewController.m
//  LearnMath
//
//  Created by 基 on 2025/8/29.
//

#import "HomeViewController.h"
#import "ArithmeticConstant.h"
@interface HomeViewController ()

@end

@implementation HomeViewController
-(void)creatTopView
{
    UIView *topView = [[UIView alloc] init];
    CGFloat topViewW = LearnMathScale(375.0);
    CGFloat topViewH = LearnMathScale(210.0);
    topView.frame = CGRectMake(0, 0, topViewW, topViewH);
    [self.view addSubview:topView];
    
    UIImageView *home_smile = [[UIImageView alloc] init];
    CGFloat smileImgX = LearnMathScale(102.0);
    CGFloat smileImgY = LearnMathScale(110.0);
    CGFloat smileImgW = LearnMathScale(170.0);
    CGFloat smileImgH = LearnMathScale(130.0);
    home_smile.frame = CGRectMake(smileImgX, smileImgY, smileImgW, smileImgH);
    [topView addSubview:home_smile];
    home_smile.image = [UIImage imageNamed:@"home_smile"];
    
    UIImageView *learnmath_logo = [[UIImageView alloc] init];
    CGFloat logoImgX = LearnMathScale(48.0);
    CGFloat logoImgY = LearnMathScale(48.0);
    CGFloat logoImgW = LearnMathScale(280.0);
    CGFloat logoImgH = LearnMathScale(60.0);
    learnmath_logo.frame = CGRectMake(logoImgX, logoImgY, logoImgW, logoImgH);
    [topView addSubview:learnmath_logo];
    learnmath_logo.image = [UIImage imageNamed:@"learnmath_logo"];
}

-(void)creatBottomView
{
    UIView *bottomView = [[UIView alloc] init];
    CGFloat bottomViewX = LearnMathScale(24.0);
    CGFloat bottomViewY = LearnMathScale(240.0);
    CGFloat bottomViewW = [UIScreen mainScreen].bounds.size.width - 2 * (LearnMathScale(24.0));
    CGFloat bottomViewH = LearnMathScale(540.0);
    bottomView.frame = CGRectMake(bottomViewX, bottomViewY, bottomViewW, bottomViewH);
    [self.view addSubview:bottomView];
    
    NSMutableArray *arrayAccessButton = [NSMutableArray array];
    for (int i=0; i<5; i++)
    {
        UIButton *access_button = [[UIButton alloc] init];
        CGFloat accessButtonX = 0;
        CGFloat accessButtonY = i * (LearnMathScale(68.0 + 18.0));
        CGFloat accessButtonW;
        if (i == 4)
        {
            accessButtonW = LearnMathScale(242.0);
        }else
        {
            accessButtonW = bottomViewW;
        }
    
        CGFloat accessButtonH = LearnMathScale(68.0);
        access_button.frame = CGRectMake(accessButtonX, accessButtonY, accessButtonW, accessButtonH);
        [bottomView addSubview:access_button];
        NSString *imgName = [NSString stringWithFormat:@"access_%d",i];
        [access_button setImage:[UIImage imageNamed:imgName] forState:UIControlStateNormal];
        [arrayAccessButton addObject:access_button];
    }
    UIButton *lastAccessButton = arrayAccessButton[4];
    UIButton *list_Button = [[UIButton alloc] init];
    CGFloat listButtonX = lastAccessButton.frame.origin.x + lastAccessButton.frame.size.width + (LearnMathScale(13.0));
    CGFloat listButtonY = lastAccessButton.frame.origin.y;
    CGFloat listButtonW = LearnMathScale(72.0);
    CGFloat listButtonH = LearnMathScale(68.0);
    list_Button.frame = CGRectMake(listButtonX, listButtonY, listButtonW, listButtonH);
    [bottomView addSubview: list_Button];
    [list_Button setImage:[UIImage imageNamed:@"list"] forState:UIControlStateNormal];
    
    NSMutableArray *arrayFunctionButton = [NSMutableArray array];
    for (int i=0; i<4; i++)
    {
        UIButton *function_Button = [[UIButton alloc] init];
        CGFloat functionButtonX = i * (LearnMathScale(13.0 + 72.0));
        CGFloat functionButtonY = listButtonY + (LearnMathScale(24.0 + 68.0));
        CGFloat functionButtonW = listButtonW;
        CGFloat functionButtonH = listButtonH;
        function_Button.frame = CGRectMake(functionButtonX, functionButtonY, functionButtonW, functionButtonH);
        [bottomView addSubview:function_Button];
        NSString *imgName = [NSString stringWithFormat:@"function_%d",i];
        [function_Button setImage:[UIImage imageNamed:imgName] forState:UIControlStateNormal];
        [arrayFunctionButton addObject:function_Button];
    }
    
    UIImageView *pro_image = [[UIImageView alloc] init];
    CGFloat proX = LearnMathScale(295.0);
    CGFloat proY = LearnMathScale(426.0);
    CGFloat proW = LearnMathScale(42.0);
    CGFloat proH = LearnMathScale(26.0);
    pro_image.frame = CGRectMake(proX, proY, proW, proH);
    [bottomView addSubview:pro_image];
    pro_image.image = [UIImage imageNamed:@"pro"];
}
- (void)viewDidLoad
{
    [super viewDidLoad];
    [self creatTopView];
    [self creatBottomView];
    // Do any additional setup after loading the view.
}


@end
