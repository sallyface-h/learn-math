//
//  ModesSelectedViewController.m
//  LearnMath
//
//  Created by 基 on 2025/9/17.
//

#import "ModesSelectedViewController.h"

@interface ModesSelectedViewController ()<UICollectionViewDataSource,UICollectionViewDelegateFlowLayout,EachMathNavigationBarViewDelegate>
@property (nonatomic, strong) UICollectionView *collectionView;
@property (nonatomic ,strong) ModesSelectedModels *models;
@property (nonatomic, strong) UIButton *selectedButton;
@property (nonatomic, strong) UIColor *bgColor;
@end

@implementation ModesSelectedViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    TestSettingViewModel *viewModel = [[TestSettingViewModel alloc] init];
    NSArray *mode = [viewModel loadTestMode];
    NSArray *imgName = [viewModel loadImgName];
    self.models = [ModesSelectedModels modelWithImgName:imgName andTitleText:mode];
    
    EachMathNavigationBarView *navView = [[EachMathNavigationBarView alloc] initWithCategoryID:self.categoryID];
    navView.delegate = self;
    [self.view addSubview:navView];

    [navView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.view.mas_top);
        make.leading.equalTo(self.view.mas_leading);
        make.trailing.equalTo(self.view.mas_trailing);
        make.height.mas_equalTo(LearnMathScale(64.0) + LearnMathScale(59.0));
    }];
    
    UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc] init];
    layout.minimumLineSpacing = LearnMathScale(14.0);
    layout.itemSize = CGSizeMake(SCREEN_WIDTH - LearnMathScale(24.0) * 2, LearnMathScale(46.0));
    layout.sectionInset = UIEdgeInsetsMake(LearnMathScale(14.0), 0.0, 0.0, 0.0);
    
    UICollectionView *collectionView = [[UICollectionView alloc] initWithFrame:CGRectZero collectionViewLayout:layout];
    self.collectionView = collectionView;
    self.collectionView.layer.masksToBounds = YES;
    self.collectionView.layer.cornerRadius = LearnMathScale(30.0);
    self.collectionView.layer.maskedCorners = kCALayerMinXMinYCorner | kCALayerMaxXMinYCorner;
    [self.view addSubview:self.collectionView];
    [self.collectionView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(navView.mas_bottom);
        make.bottom.leading.trailing.equalTo(self.view);
    }];
    
    self.bgColor = [EachMathNavigationBarView colorForCategoryID:self.categoryID];
    self.view.backgroundColor = self.bgColor;
    
    self.collectionView.dataSource = self;
    self.collectionView.delegate = self;

    [self.collectionView registerClass:[ModesSelectedViewCell class] forCellWithReuseIdentifier:@"cell"];
    [self.collectionView registerClass:[ModesSelectedHeaderView class] forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"headerView"];
    [self.collectionView registerClass:[ModesSelectedFooterView class] forSupplementaryViewOfKind:UICollectionElementKindSectionFooter withReuseIdentifier:@"footerView"];
    
}

#pragma mark - UICollectionViewDataSource
 - (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView
{
    return 1;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return self.models.titleText.count;
}

- (__kindof UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    ModesSelectedViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"cell" forIndexPath:indexPath];
    cell.titleLabel.text = self.models.titleText[indexPath.row][@"Text"];
    NSString *imgName = self.models.imgName[indexPath.row];
    cell.modeImg.image = [UIImage imageNamed:imgName];
    NSString *btnID = self.models.titleText[indexPath.row][@"ButtonID"];
    cell.modeButton.accessibilityIdentifier = btnID;
    [cell.modeButton addTarget:self action:@selector(didButton:) forControlEvents:UIControlEventTouchUpInside];
    return cell;
}

- (UICollectionReusableView *)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath
{
    if ([kind isEqualToString:UICollectionElementKindSectionHeader]) {
        ModesSelectedHeaderView *header = [collectionView dequeueReusableSupplementaryViewOfKind:kind withReuseIdentifier:@"headerView" forIndexPath:indexPath];
            [header configureWithTitle:@"Select test mode"];
        return header;
    } else if ([kind isEqualToString:UICollectionElementKindSectionFooter]){
        ModesSelectedFooterView *footer = [collectionView dequeueReusableSupplementaryViewOfKind:kind withReuseIdentifier:@"footerView" forIndexPath:indexPath];
        [footer configureWithButtonTitle:@"Next"];
        [footer.button addTarget:self action:@selector(nextButtonDidClick:) forControlEvents:UIControlEventTouchUpInside];
    
        return footer;
    }
    return [UICollectionReusableView new];
}

#pragma  mark - UICollectionViewDelegateFlowLayout
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout referenceSizeForHeaderInSection:(NSInteger)section
{
    return CGSizeMake(collectionView.bounds.size.width, LearnMathScale(44.0));
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout referenceSizeForFooterInSection:(NSInteger)section
{
    return CGSizeMake(collectionView.bounds.size.width, LearnMathScale(76.0));
}

#pragma mark - 按钮点击方法
- (void)didButton:(UIButton *)sender
{
    if (self.selectedButton &&
        [sender.accessibilityIdentifier isEqualToString:self.selectedButton.accessibilityIdentifier]) {
        return;
    }
    
    self.testOptions.testModeKey = sender.accessibilityIdentifier;
    void(^animateBorderColor)(UIButton *,UIColor *) = ^(UIButton *btn,UIColor *toColor){
        CABasicAnimation *animation = [CABasicAnimation animationWithKeyPath:@"borderColor"];
        animation.fromValue = (__bridge id)btn.layer.borderColor;
        animation.toValue = (__bridge id)toColor.CGColor;
        animation.duration = 0.3;
        btn.layer.borderColor = toColor.CGColor;
        [btn.layer addAnimation:animation forKey:@"borderColor"];
    };
    
    animateBorderColor(self.selectedButton,[UIColor colorForSet:ColorSetSkillBorder]);
    animateBorderColor(sender,[UIColor colorForSet:ColorSetPurple]);

    self.selectedButton = sender;
}

- (void)nextButtonDidClick:(ScaleableButton *)sender
{
    NSLog(@"mode = %@",self.testOptions.testModeKey);
    NSDictionary *params = @{
            @"bgColor": self.bgColor,
            @"testOptions": self.testOptions,
        };
    
    MathAnswerSheetViewController *vc = [[MathAnswerSheetViewController alloc] initWithParams:params];
    vc.selectedTestOptions = self.testOptions;
    
    [self.navigationController pushViewController:vc animated:YES];
    
}

- (void)eachMathNavigationBarViewDidClickBack:(EachMathNavigationBarView *)navBar {
    [self.navigationController popViewControllerAnimated:YES];
}
@end
