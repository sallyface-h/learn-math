//
//  ViewController.m
//  LearnMath
//
//  Created by 基 on 2025/8/29.
//

#import "ViewController.h"
#define SCREEN_HEIGHT [UIScreen mainScreen].bounds.size.height/812
#define SCREEN_WIDTH [UIScreen mainScreen].bounds.size.width/375
@interface ViewController ()

@end

@implementation ViewController
-(void)creatTopView{
    UIView *topView = [[UIView alloc]init];
    CGFloat topViewW = 375 * SCREEN_WIDTH;
    CGFloat topViewH = 210 * SCREEN_HEIGHT;
    topView.frame = CGRectMake(0, 0, topViewW, topViewH);
    [self.view addSubview:topView];
    
    UIImageView *home_smile = [[UIImageView alloc]init];
    CGFloat smileImgX = 102 * SCREEN_WIDTH;
    CGFloat smileImgY = 110 * SCREEN_HEIGHT;
    CGFloat smileImgW = 170 * SCREEN_WIDTH;
    CGFloat smileImgH = 130 * SCREEN_HEIGHT;
    home_smile.frame = CGRectMake(smileImgX, smileImgY, smileImgW, smileImgH);
    [topView addSubview:home_smile];
    home_smile.image = [UIImage imageNamed:@"home_smile"];
    
    UIImageView *learnmath_logo = [[UIImageView alloc]init];
    CGFloat logoImgX = 48 * SCREEN_WIDTH;
    CGFloat logoImgY = 48 * SCREEN_HEIGHT;
    CGFloat logoImgW = 280 * SCREEN_WIDTH;
    CGFloat logoImgH = 60 * SCREEN_HEIGHT;
    learnmath_logo.frame = CGRectMake(logoImgX, logoImgY, logoImgW, logoImgH);
    [topView addSubview:learnmath_logo];
    learnmath_logo.image = [UIImage imageNamed:@"learnmath_logo"];
}

-(void)creatBottomView{
    UIView *bottomView = [[UIView alloc]init];
    CGFloat bottomViewX = 24 * SCREEN_WIDTH;
    CGFloat bottomViewY = 240 * SCREEN_HEIGHT;
    CGFloat bottomViewW = [UIScreen mainScreen].bounds.size.width - 2 * (24 * SCREEN_WIDTH);
    CGFloat bottomViewH = 504 * SCREEN_HEIGHT;
    bottomView.frame = CGRectMake(bottomViewX, bottomViewY, bottomViewW, bottomViewH);
    [self.view addSubview:bottomView];
    
    NSMutableArray *arrayAccessButton = [NSMutableArray array];
    for (int i=0; i<5; i++) {
        UIButton *access_button = [[UIButton alloc]init];
        CGFloat accessButtonX = 0;
        CGFloat accessButtonY = i * ((68 + 18)* SCREEN_HEIGHT);
        CGFloat accessButtonW;
        if (i == 4) {
            accessButtonW = 242 * SCREEN_WIDTH;
        }else{
            accessButtonW = bottomViewW;
        }
    
        CGFloat accessButtonH = 68 * SCREEN_HEIGHT;
        access_button.frame = CGRectMake(accessButtonX, accessButtonY, accessButtonW, accessButtonH);
        [bottomView addSubview:access_button];
        NSString *imgName = [NSString stringWithFormat:@"access_%d",i];
        [access_button setImage:[UIImage imageNamed:imgName] forState:UIControlStateNormal];
        [arrayAccessButton addObject:access_button];
    }
    UIButton *lastAccessButton = arrayAccessButton[4];
    UIButton *list_Button = [[UIButton alloc]init];
    CGFloat listButtonX = lastAccessButton.frame.origin.x + lastAccessButton.frame.size.width + (13 * SCREEN_WIDTH);
    CGFloat listButtonY = lastAccessButton.frame.origin.y;
    CGFloat listButtonW = 72 * SCREEN_WIDTH;
    CGFloat listButtonH = 68 * SCREEN_HEIGHT;
    list_Button.frame = CGRectMake(listButtonX, listButtonY, listButtonW, listButtonH);
    [bottomView addSubview: list_Button];
    [list_Button setImage:[UIImage imageNamed:@"list"] forState:UIControlStateNormal];
    
    NSMutableArray *arrayFunctionButton = [NSMutableArray array];
    for (int i=0; i<4; i++) {
        UIButton *function_Button = [[UIButton alloc]init];
        CGFloat functionButtonX = i * ((13 + 72) * SCREEN_WIDTH);
        CGFloat functionButtonY = listButtonY + ((24 + 68) * SCREEN_HEIGHT);
        CGFloat functionButtonW = listButtonW;
        CGFloat functionButtonH = listButtonH;
        function_Button.frame = CGRectMake(functionButtonX, functionButtonY, functionButtonW, functionButtonH);
        [bottomView addSubview:function_Button];
        NSString *imgName = [NSString stringWithFormat:@"function_%d",i];
        [function_Button setImage:[UIImage imageNamed:imgName] forState:UIControlStateNormal];
        [arrayFunctionButton addObject:function_Button];
        
        
    }
}
- (void)viewDidLoad {
    [super viewDidLoad];
    [self creatTopView];
    [self creatBottomView];
    // Do any additional setup after loading the view.
}


@end
