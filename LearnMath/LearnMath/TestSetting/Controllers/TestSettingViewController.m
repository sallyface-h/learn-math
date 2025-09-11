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
@end

@implementation TestSettingViewController

static NSString * const singleButtonId = @"SingleCell";
static NSString * const multiButtonId = @"MultiCell";
static NSString * const headerId = @"header";
static NSString * const footerId = @"footer";

- (void)viewWillAppear:(BOOL)animated
{
    [self.navigationController setNavigationBarHidden:NO animated:YES];
    [TestSettingNavigationBar configureNavigationViewController:self withMathCategory:self.category];
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
    self.view.backgroundColor = self.navColor;
    [self.view addSubview:self.collectionView];
    [self.collectionView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.view.mas_safeAreaLayoutGuideTop);
        make.bottom.leading.trailing.equalTo(self.view);
    }];
    
    UIColor *navColor = [TestSettingNavigationBar configureNavigationViewController:self withMathCategory:self.category];
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
            [footer configureWithButtonTitle:@"Start!"];
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

#pragma  mark - 按钮点击方法
- (void)didSingleButton:(UIButton *)sender
{
    NSIndexPath *newIndexPath = [self.collectionView indexPathForCell:(TestSettingViewSingleButtonCell *)sender.superview.superview];
    if ([newIndexPath isEqual:self.singleBtnSelectedIndexPath]) {
        return;
    }
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

@end
