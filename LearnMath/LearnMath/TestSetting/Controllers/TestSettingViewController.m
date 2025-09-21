//
//  TestSettingViewController.m
//  LearnMath
//
//  Created by 基 on 2025/9/11.
//

#import "TestSettingViewController.h"

@interface TestSettingViewController ()<UICollectionViewDelegateFlowLayout,UICollectionViewDataSource>
@property (nonatomic, strong)TestSettingModels *model;
@property (nonatomic, strong)NSIndexPath *singleBtnSelectedIndexPath;
@property (nonatomic, assign)NSInteger multiBtnSelectedIndex;
@property (nonatomic, strong) NSIndexPath *expandedIndexPath;

@end

@implementation TestSettingViewController
/*
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
    
    self.model = [TestSettingModels modelWithCalculateNum:@[@"<10",@"<100"] andTestScope:@[@"All you've learn",@"Choose by operations",@"Choose by skills"]];
    
    self.singleBtnSelectedIndexPath = [NSIndexPath indexPathForItem:0 inSection:0];
    self.multiBtnSelectedIndex = 0;
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
        cell.titleLabel.text = self.model.testScope[indexPath.row];
        if ([indexPath isEqual:self.singleBtnSelectedIndexPath]) {
            cell.settingScopeButton.layer.borderColor = [UIColor colorForSet:ColorSetPurple].CGColor;
        } else {
            cell.settingScopeButton.layer.borderColor = [UIColor colorForSet:ColorSetSkillBorder].CGColor;
        }
        if (indexPath.row == 1) {
            cell.buttonType = ExpandButtonTypeOperations;
        } else if (indexPath.row == 2) {
            cell.buttonType = ExpandButtonTypeSkills;
        }
        DateManagerModels *manager = [[DateManagerModels alloc] init];
        ExpandButtonModels *expandModel = [[ExpandButtonModels alloc] initWithSingleButtonModel:manager];
        [cell configureWithExpandModel:expandModel];
        
        [cell.settingScopeButton addTarget:self action:@selector(didSingleButton:) forControlEvents:UIControlEventTouchUpInside];
        return cell;
    } else {
        TestSettingViewMultiButtonCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:multiButtonId forIndexPath:indexPath];
        [cell configureWithCalculateNums:self.model.calculateNum andSelectedIndex:self.multiBtnSelectedIndex];
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
        if (self.expandedIndexPath && [self.expandedIndexPath isEqual:indexPath]) {
            if (indexPath.row == 1) {
                DateManagerModels *manager = [[DateManagerModels alloc] init];
                ExpandButtonModels *model = [[ExpandButtonModels alloc] initWithSingleButtonModel:manager];
                CGFloat height = LearnMathScale(45.0) + model.title.count * (LearnMathScale(18.0) + LearnMathScale(12.0)) +LearnMathScale(20.0);
                return CGSizeMake(width, height);
            } else {
                DateManagerModels *manager = [[DateManagerModels alloc] init];
                ExpandButtonModels *model = [[ExpandButtonModels alloc] initWithSingleButtonModel:manager];
                NSInteger totalCount = 0;
                for (NSArray *subArray in model.skill) {
                    totalCount += subArray.count;
                }
                CGFloat height = LearnMathScale(65.0) + totalCount * (LearnMathScale(18.0) + LearnMathScale(12.0)) + (LearnMathScale(16.0) + LearnMathScale(20.0)) * model.title.count;
                return CGSizeMake(width, height);
            }
        } else {
            return CGSizeMake(width, LearnMathScale(46.0));
    }
}
#pragma  mark - 按钮点击方法
- (void)didSingleButton:(UIButton *)sender
{
    NSIndexPath *newIndexPath = [self.collectionView indexPathForCell:(TestSettingViewSingleButtonCell *)sender.superview.superview];
    
    NSIndexPath *oldIndexPath = self.singleBtnSelectedIndexPath;
    self.singleBtnSelectedIndexPath = newIndexPath;
    
    TestSettingViewSingleButtonCell *oldCell = [self.collectionView cellForItemAtIndexPath:oldIndexPath];
    TestSettingViewSingleButtonCell *newCell = [self.collectionView cellForItemAtIndexPath:newIndexPath];
    
    void(^animateBorderColor)(UIButton *,UIColor *) = ^(UIButton *btn,UIColor *toColor){
        CABasicAnimation *animation = [CABasicAnimation animationWithKeyPath:@"borderColor"];
        animation.fromValue = (__bridge id)sender.layer.borderColor;
        animation.toValue = (__bridge id)toColor.CGColor;
        animation.duration = 0.3;
        btn.layer.borderColor = toColor.CGColor;
        [btn.layer addAnimation:animation forKey:@"borderColor"];
    };
    
    animateBorderColor(oldCell.settingScopeButton,[UIColor colorForSet:ColorSetSkillBorder]);
    animateBorderColor(newCell.settingScopeButton,[UIColor colorForSet:ColorSetPurple]);
    
    if (newIndexPath.row == 1 || newIndexPath.row == 2) {
        NSMutableArray *reloadIndexPaths = [NSMutableArray array];
        if (self.expandedIndexPath) {
            if ([self.expandedIndexPath isEqual:newIndexPath]) {
                [reloadIndexPaths addObject:newIndexPath];
                self.expandedIndexPath = nil;
            } else {
                self.expandedIndexPath = newIndexPath;
                [reloadIndexPaths addObject:newIndexPath];
            }
        } else {
            self.expandedIndexPath = newIndexPath;
            [reloadIndexPaths addObject:newIndexPath];
        }
        [self.collectionView reloadItemsAtIndexPaths:reloadIndexPaths];
    }
}

- (void)didMultiButton:(UIButton *)sender
{
    TestSettingViewMultiButtonCell *cell = [self.collectionView cellForItemAtIndexPath:[NSIndexPath indexPathForRow:0 inSection:1]];
    NSInteger newIndex = sender.tag;
    if (newIndex == self.multiBtnSelectedIndex) {
        return;
    }
    NSInteger oldIndex = self.multiBtnSelectedIndex;
    self.multiBtnSelectedIndex = newIndex;
    void(^animateBorderColor)(UIButton *,UIColor *) = ^(UIButton *btn,UIColor *toColor){
        CABasicAnimation *animation = [CABasicAnimation animationWithKeyPath:@"borderColor"];
        animation.fromValue = (__bridge id)sender.layer.borderColor;
        animation.toValue = (__bridge id)toColor.CGColor;
        animation.duration = 0.3;
        btn.layer.borderColor = toColor.CGColor;
        [btn.layer addAnimation:animation forKey:@"borderColor"];
    };
    
    animateBorderColor(cell.settingNumButtonArr[oldIndex],[UIColor colorForSet:ColorSetSkillBorder]);
    animateBorderColor(cell.settingNumButtonArr[newIndex],[UIColor colorForSet:ColorSetPurple]);
}

- (void)didFooterViewButton:(UIButton *)sender
{
    ModesSelectedViewController *vc = [[ModesSelectedViewController alloc] init];
    vc.categoryID = self.categoryID;
    [self.navigationController pushViewController:vc animated:YES];
}*/
@end
