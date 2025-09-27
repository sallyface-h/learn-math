//
//  TestSettingViewController.m
//  LearnMath
//
//  Created by 基 on 2025/9/11.
//

#import "TestSettingViewController.h"

@interface TestSettingViewController ()<UICollectionViewDelegateFlowLayout,UICollectionViewDataSource>
@property (nonatomic, strong)TestSettingModels *model;
@property (nonatomic, strong) UIButton *selectedSingleButton;
@property (nonatomic, strong) UIButton *selectedMultiButton;
@property (nonatomic, copy) NSString *expandedIdentifier;
@property (nonatomic, strong)ExpandButtonModels *expandModel;
@end

@implementation TestSettingViewController

static NSString * const singleButtonId = @"SingleCell";
static NSString * const multiButtonId = @"MultiCell";
static NSString * const headerId = @"header";
static NSString * const footerId = @"footer";

- (void)viewWillAppear:(BOOL)animated
{
    [self.navigationController setNavigationBarHidden:NO animated:YES];
    [TestSettingNavigationBar configureNavigationViewController:self withMathCategoryID:self.categoryID];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    TestSettingViewModel *viewModel = [[TestSettingViewModel alloc] init];
    NSArray *digits = [viewModel loadDigitsDate];
    NSArray *TestScope = [viewModel loadTestScopeDate];
    self.model = [TestSettingModels modelWithCalculateNum:digits andTestScope:TestScope];
    
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
        make.top.equalTo(self.view.mas_safeAreaLayoutGuideTop);
        make.bottom.leading.trailing.equalTo(self.view);
    }];
    
    UIColor *navColor = [TestSettingNavigationBar configureNavigationViewController:self withMathCategoryID:self.categoryID];
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
        BOOL expanded = [self.expandedIdentifier isEqualToString:btnID];
        [cell configureWithExpandModel:self.expandModel identifier:btnID expanded:expanded];
        [cell.settingScopeButton addTarget:self action:@selector(didSingleButton:) forControlEvents:UIControlEventTouchUpInside];
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
        if ([btnID isEqualToString:@"2"] && [self.expandedIdentifier isEqualToString:btnID]) {
            CGFloat height = LearnMathScale(45.0) + self.expandModel.title.count * (LearnMathScale(18.0) + LearnMathScale(12.0)) +LearnMathScale(20.0);
            return CGSizeMake(width, height);
        } else if ([btnID isEqualToString:@"3"] && [self.expandedIdentifier isEqualToString:btnID]){
            NSInteger totalCount = 0;
            for (NSArray *subArray in self.expandModel.skill) {
                totalCount += subArray.count;
            }
            CGFloat height = LearnMathScale(65.0) + totalCount * (LearnMathScale(18.0) + LearnMathScale(12.0)) + (LearnMathScale(16.0) + LearnMathScale(20.0)) * self.expandModel.title.count;
            return CGSizeMake(width, height);
        } else {
            return CGSizeMake(width, LearnMathScale(46.0));
        }
    } else {
        return CGSizeMake(width, LearnMathScale(46.0));
    }
}
#pragma  mark - 按钮点击方法
- (void)didSingleButton:(UIButton *)sender
{
    NSIndexPath *indexPath = [self indexPathForButton:sender];
    if (!indexPath) return;
    
    if ([sender.accessibilityIdentifier isEqualToString:self.expandedIdentifier]) {
        self.expandedIdentifier = nil;
        [self updateButtonBorderAnimation:sender];
        self.selectedSingleButton = nil;
        [self.collectionView performBatchUpdates:^{
            if (indexPath) {
                [self.collectionView reloadItemsAtIndexPaths:@[indexPath]];
            }
        } completion:nil];
        return;
    }
    
    self.expandedIdentifier = sender.accessibilityIdentifier;
    
    if (!self.expandModel) {
        TestSettingViewModel *viewModel = [[TestSettingViewModel alloc] init];
        NSArray *categoryName = [viewModel loadCategoryNames];
        NSArray *skillName = [viewModel loadSkillName];
        self.expandModel = [ExpandButtonModels modelWithTitle:categoryName andSkill:skillName];
    }
    
    [self updateButtonBorderAnimation:sender];
    
    self.selectedSingleButton = sender;
    
    [self.collectionView performBatchUpdates:^{
           [self.collectionView reloadItemsAtIndexPaths:@[indexPath]];
       } completion:nil];
}

- (void)didMultiButton:(UIButton *)sender
{
    if (self.selectedMultiButton && [sender.accessibilityIdentifier isEqualToString:self.selectedMultiButton.accessibilityIdentifier]) {
        return;
    }
    [self updateButtonBorderAnimation:sender];
    self.selectedSingleButton = sender;
}

- (void)didFooterViewButton:(UIButton *)sender
{
    ModesSelectedViewController *vc = [[ModesSelectedViewController alloc] init];
    vc.categoryID = self.categoryID;
    [self.navigationController pushViewController:vc animated:YES];
}

#pragma mark - 变色方法
- (void)updateButtonBorderAnimation:(UIButton *)sender {
    if (self.selectedSingleButton && self.selectedSingleButton != sender) {
        [self animateBorderColor:self.selectedSingleButton toColor:[UIColor colorForSet:ColorSetSkillBorder]];
    }
    [self animateBorderColor:sender toColor:[UIColor colorForSet:ColorSetPurple]];
}

- (void)animateBorderColor:(UIButton *)btn toColor:(UIColor *)toColor {
    if (!btn) return;
    CABasicAnimation *animation = [CABasicAnimation animationWithKeyPath:@"borderColor"];
    animation.fromValue = (__bridge id)btn.layer.borderColor;
    animation.toValue = (__bridge id)toColor.CGColor;
    animation.duration = 0.25;
    btn.layer.borderColor = toColor.CGColor;
    [btn.layer addAnimation:animation forKey:@"borderColor"];
}

- (NSIndexPath *)indexPathForButton:(UIButton *)sender {
    UIView *view = sender;
    while (view && ![view isKindOfClass:[UICollectionViewCell class]]) {
        view = view.superview;
    }
    if (view) {
        return [self.collectionView indexPathForCell:(UICollectionViewCell *)view];
    }
    return nil;
}

@end
