//
//  TestSettingViewController.m
//  LearnMath
//
//  Created by 基 on 2025/9/11.
//

#import "TestSettingViewController.h"

@interface TestSettingViewController ()<UICollectionViewDelegateFlowLayout,UICollectionViewDataSource,EachMathNavigationBarViewDelegate,TestSettingSingleCellDelegate>
@property (nonatomic, strong)TestSettingModels *model;
@property (nonatomic, strong) UIButton *selectedSingleButton;
@property (nonatomic, strong) UIButton *selectedMultiButton;
@property (nonatomic, copy) NSString *expandedIdentifier;
@property (nonatomic, strong)ExpandButtonModels *expandModel;
@property (nonatomic, strong) NSIndexPath *selectedIndexPath;
@property (nonatomic, strong) NSMutableArray<NSString *> *selectedTestScopeSkillNames;
@property (nonatomic, strong) NSMutableArray<NSString *> *selectedTestScopeCategoriesNames;
@property (nonatomic, strong) NSArray<NSString *> *testSkills;
@property (nonatomic, strong) NSArray<NSString *> *testCategoires;
@end

@implementation TestSettingViewController

static NSString * const singleButtonId = @"SingleCell";
static NSString * const multiButtonId = @"MultiCell";
static NSString * const headerId = @"header";
static NSString * const footerId = @"footer";


- (void)viewDidLoad {
    [super viewDidLoad];
    TestSettingViewModel *viewModel = [[TestSettingViewModel alloc] init];
    NSArray *digits = [viewModel loadDigitsData];
    NSArray *TestScope = [viewModel loadTestScopeData];
    self.model = [TestSettingModels modelWithCalculateNum:digits andTestScope:TestScope];
    
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
    
    UIColor *navColor = [EachMathNavigationBarView colorForCategoryID:self.categoryID];
    self.view.backgroundColor = navColor;
    
    self.collectionView.dataSource = self;
    self.collectionView.delegate = self;
    
    [self.collectionView registerClass:[TestSettingViewSingleButtonCell class] forCellWithReuseIdentifier:singleButtonId];
    [self.collectionView registerClass:[TestSettingViewMultiButtonCell class] forCellWithReuseIdentifier:multiButtonId];
    [self.collectionView registerClass:[TestSettingHeaderView class] forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:headerId];
    [self.collectionView registerClass:[TestSettingFooterView class] forSupplementaryViewOfKind:UICollectionElementKindSectionFooter withReuseIdentifier:footerId];
    

}


#pragma mark - UICollectionViewDataSource
- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView
{
    return 2;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    if (section == 0) {
        return self.model.testScope.count;
    } else {
        return 1;
    }
}

- (__kindof UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section == 0) {
        TestSettingViewSingleButtonCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:singleButtonId forIndexPath:indexPath];
        NSString *btnID = self.model.testScope[indexPath.row][@"ButtonID"];
        cell.titleLabel.text = self.model.testScope[indexPath.row][@"Text"];
        cell.settingScopeButton.accessibilityIdentifier = btnID;
        
        [cell.settingScopeButton addTarget:self action:@selector(didSingleButton:) forControlEvents:UIControlEventTouchUpInside];
        cell.delegate = self;
        return cell;
    } else {
        TestSettingViewMultiButtonCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:multiButtonId forIndexPath:indexPath];
        [cell configureWithCalculateNums:self.model.calculateNum];
        for (UIButton *btn in cell.settingNumButtonArr) {
            [btn addTarget:self action:@selector(didMultiButton:) forControlEvents:UIControlEventTouchUpInside];
        }
        return cell;
    }
}

- (UICollectionReusableView *)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath
{
    if ([kind isEqualToString:UICollectionElementKindSectionHeader]) {
        TestSettingHeaderView *header = [collectionView dequeueReusableSupplementaryViewOfKind:kind withReuseIdentifier:headerId forIndexPath:indexPath];
        if (indexPath.section == 0) {
            [header configureWithTitle:@"Select test scope"];
        } else {
            [header configureWithTitle:@"Calculated number:"];
        }
        return header;
    } else if ([kind isEqualToString:UICollectionElementKindSectionFooter]){
        TestSettingFooterView *footer = [collectionView dequeueReusableSupplementaryViewOfKind:kind withReuseIdentifier:footerId forIndexPath:indexPath];
        if (indexPath.section == 1) {
            [footer configureWithButtonTitle:@"Next"];
            [footer.button addTarget:self action:@selector(didFooterViewButton:) forControlEvents:UIControlEventTouchUpInside];
            return footer;
        }
    }
    return [UICollectionReusableView new];
}

#pragma mark - UICollectionViewDelegateFlowLayout
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout referenceSizeForHeaderInSection:(NSInteger)section
{
    return CGSizeMake(collectionView.bounds.size.width, LearnMathScale(44.0));
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout referenceSizeForFooterInSection:(NSInteger)section
{
    if (section == 1) {
        return CGSizeMake(collectionView.bounds.size.width, LearnMathScale(76.0));
    } else {
        return CGSizeZero;
    }
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{
    CGFloat width = SCREEN_WIDTH - LearnMathScale(24.0) * 2;
    if (indexPath.section == 0) {
        NSString *btnID = self.model.testScope[indexPath.row][@"ButtonID"];
        if ([self.expandedIdentifier isEqualToString:btnID]) {
            if ([btnID isEqualToString:@"2"]) {
                return CGSizeMake(width, LearnMathScale(194.0));
            } else if ([btnID isEqualToString:@"3"]) {
                return CGSizeMake(width,LearnMathScale(725));
            } else {
                return CGSizeMake(width, LearnMathScale(46.0));
            }
        }
        return CGSizeMake(width, LearnMathScale(46.0));
    } else {
        return CGSizeMake(width, LearnMathScale(46.0));
    }
}
#pragma  mark - 按钮点击方法
- (void)didSingleButton:(UIButton *)sender
{
    NSString *btnID = sender.accessibilityIdentifier;

    if ([self.expandedIdentifier isEqualToString:btnID]) {
        [self animateBorderColor:sender toColor:[UIColor colorForSet:ColorSetSkillBorder]];

        self.expandedIdentifier = nil;
        self.expandModel = nil;

        TestSettingViewSingleButtonCell *cell = (TestSettingViewSingleButtonCell *)[self.collectionView cellForItemAtIndexPath:self.selectedIndexPath];
        [cell configureWithExpandModel:nil identifier:btnID expanded:NO];

        [UIView animateWithDuration:0.25 animations:^{
            [self.collectionView performBatchUpdates:nil completion:nil];
        }];
        self.selectedSingleButton = nil;
        self.selectedIndexPath = nil;
        return;
    }

    
    if (self.selectedSingleButton) {
        [self animateBorderColor:self.selectedSingleButton toColor:[UIColor colorForSet:ColorSetSkillBorder]];
    }
    
    if (self.selectedIndexPath && ![self.expandedIdentifier isEqualToString:btnID]) {
        TestSettingViewSingleButtonCell *oldCell = (TestSettingViewSingleButtonCell *)[self.collectionView cellForItemAtIndexPath:self.selectedIndexPath];
        [oldCell.selectedIndexPaths removeAllObjects];
        [oldCell.collectionView reloadData];
    }

    TestSettingViewModel *viewModel = [[TestSettingViewModel alloc] init];
    self.expandModel = [viewModel loadExpandModelWithButtonID:btnID];
    self.expandedIdentifier = btnID;

    [self animateBorderColor:sender toColor:[UIColor colorForSet:ColorSetPurple]];
    self.selectedSingleButton = sender;


    NSIndexPath *indexPath = [self indexPathForButton:sender];
    TestSettingViewSingleButtonCell *cell = (TestSettingViewSingleButtonCell *)[self.collectionView cellForItemAtIndexPath:indexPath];
    [cell configureWithExpandModel:self.expandModel identifier:btnID expanded:YES];

    self.selectedIndexPath = indexPath;

    [UIView animateWithDuration:0.25 animations:^{
        [self.collectionView performBatchUpdates:nil completion:nil];
    }];
}

- (void)didMultiButton:(UIButton *)sender
{
    if (self.selectedMultiButton && [sender.accessibilityIdentifier isEqualToString:self.selectedMultiButton.accessibilityIdentifier]) {
        return;
    }
    
    [self animateBorderColor:self.selectedMultiButton toColor:[UIColor colorForSet:ColorSetSkillBorder]];
    [self animateBorderColor:sender toColor:[UIColor colorForSet:ColorSetPurple]];
    
    self.selectedMultiButton = sender;
}

- (void)didFooterViewButton:(UIButton *)sender
{
    NSString *digitID = self.selectedMultiButton.accessibilityIdentifier;
    NSString *testRangeID = self.selectedSingleButton.accessibilityIdentifier;
    
    MathWorkSelectedTestOptions *testOptions = [[MathWorkSelectedTestOptions alloc] init];
    testOptions.testSkills = self.testSkills;
    testOptions.testCategoires = self.testCategoires;
    testOptions.testDigitKey = digitID;
    testOptions.testRangeKey = testRangeID;
    
    ModesSelectedViewController *vc = [[ModesSelectedViewController alloc] init];
    vc.categoryID = self.categoryID;
    vc.testOptions = testOptions;
    [self.navigationController pushViewController:vc animated:YES];
}

- (void)testSettingCell:(TestSettingViewSingleButtonCell *)cell didUpdateSelectedCategoriesNames:(nonnull NSArray<NSString *> *)selectedCategoriesNames skillCategoryPairs:(nonnull NSArray<NSDictionary *> *)skillCategoryPairs identifier:(nonnull NSString *)identifier
{
    if ([identifier isEqualToString:@"2"]) {
        self.testCategoires = [TestSettingViewModel loadCategoryIDsWithCategoryName:selectedCategoriesNames];
        self.testSkills = [TestSettingViewModel loadSkillIDsWithCategoryID:self.testCategoires];
    }

    if ([identifier isEqualToString:@"3"]) {
        self.testSkills = [TestSettingViewModel loadSkillIDWithDict:skillCategoryPairs];
        
    }

}
#pragma mark - 变色方法
- (void)updateButtonBorderAnimation:(UIButton *)sender {
    if (self.selectedSingleButton && self.selectedSingleButton != sender) {
        [self animateBorderColor:self.selectedSingleButton toColor:[UIColor colorForSet:ColorSetSkillBorder]];
    }
    [self animateBorderColor:sender toColor:[UIColor colorForSet:ColorSetPurple]];
}

- (void)animateBorderColor:(UIButton *)btn toColor:(UIColor *)toColor {
    CABasicAnimation *animation = [CABasicAnimation animationWithKeyPath:@"borderColor"];
    animation.fromValue = (__bridge id)btn.layer.borderColor;
    animation.toValue = (__bridge id)toColor.CGColor;
    animation.duration = 0.25;
    [btn.layer addAnimation:animation forKey:@"borderColor"];
    btn.layer.borderColor = toColor.CGColor;
}

- (NSIndexPath *)indexPathForButton:(UIButton *)sender {
    CGPoint point = [sender convertPoint:CGPointZero toView:self.collectionView];
    return [self.collectionView indexPathForItemAtPoint:point];
}

- (void)eachMathNavigationBarViewDidClickBack:(EachMathNavigationBarView *)navBar {
    [self.navigationController popViewControllerAnimated:YES];
}
@end
