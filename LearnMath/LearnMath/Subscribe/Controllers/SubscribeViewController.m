//
//  SubscribeViewController.m
//  LearnMath
//
//  Created by 基 on 2025/9/28.
//

#import "SubscribeViewController.h"

@interface SubscribeViewController ()<UICollectionViewDataSource,UICollectionViewDelegateFlowLayout>
@property (nonatomic, strong) UICollectionView *collectionView;
@property (nonatomic, strong) UIView *subscribeView;
@property (nonatomic, strong) UIView *bottomView;
@property (nonatomic, strong) SubscribeModel *models;
@end

@implementation SubscribeViewController
- (void)viewDidLoad {
    [super viewDidLoad];
    
    UIView *subscribeView = [[UIView alloc] init];
    self.subscribeView = subscribeView;
    self.subscribeView.layer.masksToBounds = YES;
    self.subscribeView.layer.cornerRadius = LearnMathScale(30.0);
    self.subscribeView.layer.maskedCorners = kCALayerMinXMinYCorner | kCALayerMaxXMinYCorner;
    self.subscribeView.backgroundColor = [UIColor colorForSet:ColorSetWhite];
    [self.view addSubview:self.subscribeView];
    [self.subscribeView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(LearnMathScale(123.0));
        make.bottom.leading.trailing.equalTo(self.view);
    }];
    
    UIColor *color1 = [UIColor colorForSet:ColorSetGradient1];
    UIColor *color2 = [UIColor colorForSet:ColorSetGradient2];
    UIColor *color3 = [UIColor colorForSet:ColorSetGradient3];

    [self.view applyGradientWithColors:@[color1, color2, color3] direction:GradientDirectionTopLeftToBottomRight];
    
    UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc] init];
    layout.minimumLineSpacing = LearnMathScale(14.0);
    layout.sectionInset = UIEdgeInsetsMake(LearnMathScale(20.0), 0.0, 0.0, 0.0);
    layout.itemSize = CGSizeMake(SCREEN_WIDTH - LearnMathScale(20.0) * 2, LearnMathScale(46.0));
    
    UICollectionView *collectionView = [[UICollectionView alloc] initWithFrame:CGRectZero collectionViewLayout:layout];
    self.collectionView = collectionView;
    self.collectionView.backgroundColor = [UIColor colorForSet:ColorSetLightYellow];
    [self.subscribeView addSubview:self.collectionView];
    [self.collectionView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.leading.mas_equalTo(LearnMathScale(24.0));
        make.trailing.mas_equalTo(-LearnMathScale(24.0));
        make.height.mas_equalTo(LearnMathScale(414.0));
    }];
    
    UIImageView *smileImage = [[UIImageView alloc] init];
    smileImage.image = [UIImage imageNamed:@"subscription_icon"];
    [self.view addSubview:smileImage];
    [smileImage mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(LearnMathScale(170.0), LearnMathScale(130.0)));
        make.leading.mas_equalTo(LearnMathScale(103.0));
        make.bottom.mas_equalTo(-LearnMathScale(642.0));
    }];
    
    SubscribeBottomView *bottomView= [[SubscribeBottomView alloc] init];
    self.bottomView = bottomView;
    [self.subscribeView addSubview:bottomView];
    [self.bottomView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.collectionView.mas_bottom).offset(LearnMathScale(20.0));
        make.width.mas_equalTo(SCREEN_WIDTH - LearnMathScale(24.0) * 2);
        make.centerX.equalTo(self.view);
    }];
    
    UIButton *backButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [backButton setImage:[UIImage imageNamed:@"back"] forState:UIControlStateNormal];
    [backButton addTarget:self action:@selector(backAction:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:backButton];
    [backButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(LearnMathScale(28.0), LearnMathScale(28.0)));
        make.top.mas_equalTo(LearnMathScale(62.0));
        make.leading.mas_equalTo(24.0);
    }];
    
    self.collectionView.delegate = self;
    self.collectionView.dataSource = self;
    
    [self.collectionView registerClass:[SubscribeViewCell class] forCellWithReuseIdentifier:@"cell"];
    [self.collectionView registerClass:[SubscribeHeaderView class] forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"headerView"];
    [self.collectionView registerClass:[SubscribeBottomView class] forSupplementaryViewOfKind:UICollectionElementKindSectionFooter withReuseIdentifier:@"footerView"];
    
    self.models = [SubscribeModel modelWithPriceText:@[
        @"$9.9",
        @"$29.9",
        @"$79.9"
    ] andtimeText:@[
        @"Weekly",
        @"Monthly",
        @"Yearly"
    ] andoriginalPriceText:@[
        @"$19.9",
        @"$49.9",
        @"$99.9"
    ]];
    
}

#pragma mark - UICollectionViewDataSource
- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView
{
    return 1;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return self.models.priceText.count;
}

- (__kindof UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    SubscribeViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"cell" forIndexPath:indexPath];
    cell.priceLabel.text = self.models.priceText[indexPath.row];
    cell.originalPriceLabel.text = self.models.originalPriceText[indexPath.row];
    cell.timeLabel.text = self.models.timeText[indexPath.row];
    return cell;
}

- (UICollectionReusableView *)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath
{
    if ([kind isEqualToString:UICollectionElementKindSectionHeader]) {
        SubscribeHeaderView *header = [collectionView dequeueReusableSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"headerView" forIndexPath:indexPath];
        return header;
    }
    return [UICollectionReusableView new];
}

#pragma mark - UICollectionViewDelegateFlowLayout
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout referenceSizeForHeaderInSection:(NSInteger)section
{
    return CGSizeMake(collectionView.bounds.size.width, LearnMathScale(204.0));
}

#pragma mark - 返回按钮
- (void)backAction:(UIButton *)sender
{
    [self.navigationController popViewControllerAnimated:YES];
}
@end
