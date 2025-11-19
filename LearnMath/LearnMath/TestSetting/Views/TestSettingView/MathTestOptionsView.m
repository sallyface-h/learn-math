//
//  MathTestOptionsView.m
//  LearnMath
//
//  Created by 基 on 2025/11/14.
//

#import "MathTestOptionsView.h"
/*
@interface MathTestOptionsView ()<UICollectionViewDataSource,UICollectionViewDelegateFlowLayout,TestSettingSingleCellDelegate>
@property (nonatomic, strong)TestSettingModels *model;
@property (nonatomic, strong) UIButton *selectedSingleButton;
@property (nonatomic, strong) UIButton *selectedMultiButton;
@property (nonatomic, copy) NSString *expandedIdentifier;
@property (nonatomic, strong)ExpandButtonModels *expandModel;
@property (nonatomic, strong) NSIndexPath *selectedIndexPath;
@property (nonatomic, strong) UICollectionView *collectionView;
@property (nonatomic, strong) ExpandButtonModels *selectedScopeOptions;
@end

@implementation MathTestOptionsView

- (instancetype)initWithFrame:(CGRect)frame
{
    if (self == [super initWithFrame:frame]) {
        [self setupSubviews];
    }
    return self;
}

- (void)setupSubviews
{
    TestSettingViewModel *viewModel = [[TestSettingViewModel alloc] init];
    NSArray *digits = [viewModel loadDigitsData];
    NSArray *TestScope = [viewModel loadTestScopeData];
    self.model = [TestSettingModels modelWithCalculateNum:digits andTestScope:TestScope];
    
    UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc] init];
    layout.minimumLineSpacing = LearnMathScale(14.0);
    layout.itemSize = CGSizeMake(SCREEN_WIDTH - LearnMathScale(24.0) * 2, LearnMathScale(46.0));
    layout.sectionInset = UIEdgeInsetsMake(LearnMathScale(14.0), 0.0, 0.0, 0.0);
    
    UICollectionView *collectionView = [[UICollectionView alloc] initWithFrame:CGRectZero collectionViewLayout:layout];
    self.collectionView = collectionView;
    self.collectionView.backgroundColor = [UIColor whiteColor];
    self.collectionView.layer.masksToBounds = YES;
    self.collectionView.layer.cornerRadius = LearnMathScale(30.0);
    self.collectionView.layer.maskedCorners = kCALayerMinXMinYCorner | kCALayerMaxXMinYCorner;
    self.collectionView.dataSource = self;
    self.collectionView.delegate = self;
    [self.collectionView registerClass:[TestSettingViewSingleButtonCell class] forCellWithReuseIdentifier:@"SingleCell"];
    [self.collectionView registerClass:[TestSettingViewMultiButtonCell class] forCellWithReuseIdentifier:@"MultiCell"];
    [self.collectionView registerClass:[TestSettingHeaderView class] forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"header"];
    [self.collectionView registerClass:[TestSettingFooterView class] forSupplementaryViewOfKind:UICollectionElementKindSectionFooter withReuseIdentifier:@"footer"];
    [self addSubview:self.collectionView];
    
    [self.collectionView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.leading.trailing.equalTo(self);
    }];

    [self.collectionView addObserver:self forKeyPath:@"contentSize" options:NSKeyValueObservingOptionNew context:nil];
    }

- (void)dealloc {
    [_collectionView removeObserver:self forKeyPath:@"contentSize"];
}

- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary *)change context:(void *)context {
    if ([keyPath isEqualToString:@"contentSize"]) {
        CGSize newSize = [change[NSKeyValueChangeNewKey] CGSizeValue];
        if ([self.delegate respondsToSelector:@selector(mathTestsOptionsView:updateContentSize:)]) {
            [self.delegate mathTestsOptionsView:self updateContentSize:newSize];
        }
    }
}


- (void)nextButtonAction:(ScaleableButton *)sender {
    if ([self.delegate respondsToSelector:@selector(mathTestsOptionsView:didClickeNextButtonAction:selectedDigitOptions:selectedScopeOptions:)]) {
        [self.delegate mathTestsOptionsView:self didClickeNextButtonAction:sender selectedDigitOptions:self.selectedDigitOptions selectedScopeOptions:self.selectedScopeOptions];
    }
}

- (void)didMultiButton:(UIButton *)sender
{
    if (self.selectedMultiButton && [sender.accessibilityIdentifier isEqualToString:self.selectedMultiButton.accessibilityIdentifier]) {
        return;
    }
    
    void(^animateBorderColor)(UIButton *,UIColor *) = ^(UIButton *btn,UIColor *toColor){
        CABasicAnimation *animation = [CABasicAnimation animationWithKeyPath:@"borderColor"];
        animation.fromValue = (__bridge id)btn.layer.borderColor;
        animation.toValue = (__bridge id)toColor.CGColor;
        animation.duration = 0.3;
        btn.layer.borderColor = toColor.CGColor;
        [btn.layer addAnimation:animation forKey:@"borderColor"];
    };
    
    animateBorderColor(self.selectedMultiButton,[UIColor colorForSet:ColorSetSkillBorder]);
    animateBorderColor(sender,[UIColor colorForSet:ColorSetPurple]);
    
    self.selectedMultiButton = sender;
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
        TestSettingViewSingleButtonCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"SingleCell" forIndexPath:indexPath];
        NSString *btnID = self.model.testScope[indexPath.row][@"ButtonID"];
        cell.titleLabel.text = self.model.testScope[indexPath.row][@"Text"];
        cell.settingScopeButton.accessibilityIdentifier = btnID;
        BOOL expanded = [self.expandedIdentifier isEqualToString:btnID];

        [cell configureWithExpandModel:self.expandModel identifier:btnID expanded:expanded];
        [cell.settingScopeButton addTarget:self action:@selector(didSingleButton:) forControlEvents:UIControlEventTouchUpInside];
        return cell;
    } else {
        TestSettingViewMultiButtonCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"MultiCell" forIndexPath:indexPath];
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
        TestSettingHeaderView *header = [collectionView dequeueReusableSupplementaryViewOfKind:kind withReuseIdentifier:@"header" forIndexPath:indexPath];
        if (indexPath.section == 0) {
            [header configureWithTitle:@"Select test scope"];
        } else {
            [header configureWithTitle:@"Calculated number:"];
        }
        return header;
    } else if ([kind isEqualToString:UICollectionElementKindSectionFooter]){
        TestSettingFooterView *footer = [collectionView dequeueReusableSupplementaryViewOfKind:kind withReuseIdentifier:@"footer" forIndexPath:indexPath];
        if (indexPath.section == 1) {
            [footer configureWithButtonTitle:@"Next"];
            [footer.button addTarget:self action:@selector(nextButtonAction:) forControlEvents:UIControlEventTouchUpInside];
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
            
            // ⚡ 修改：展开项高度计算优化
            if ([self.expandedIdentifier isEqualToString:btnID]) {
                if (!self.expandModel) self.expandModel = [[TestSettingViewModel new] loadExpandModelWithButtonID:btnID];
                
                if ([btnID isEqualToString:@"2"]) {
                    CGFloat height = LearnMathScale(45.0) + self.expandModel.title.count * (LearnMathScale(18.0)+LearnMathScale(12.0)) + LearnMathScale(20.0);
                    return CGSizeMake(width, height);
                } else if ([btnID isEqualToString:@"3"]) {
                    NSInteger totalCount = 0;
                    for (NSArray *arr in self.expandModel.skill) totalCount += arr.count;
                    CGFloat height = LearnMathScale(65.0) + totalCount*(LearnMathScale(18.0)+LearnMathScale(12.0)) + (LearnMathScale(16.0)+LearnMathScale(20.0))*self.expandModel.title.count;
                    return CGSizeMake(width, height);
                }
            }
            return CGSizeMake(width, LearnMathScale(46.0));
        }
        
        return CGSizeMake(width, LearnMathScale(46.0));
}



#pragma mark - 变色方法
- (void)updateButtonBorderAnimation:(UIButton *)sender {
    if (self.selectedSingleButton && self.selectedSingleButton != sender)
    {
        [self animateBorderColor:self.selectedSingleButton toColor:[UIColor colorForSet:ColorSetSkillBorder]];
    }
    [self animateBorderColor:sender toColor:[UIColor colorForSet:ColorSetPurple]];
}

- (void)animateBorderColor:(UIButton *)btn toColor:(UIColor *)toColor
{
    CABasicAnimation *animation = [CABasicAnimation animationWithKeyPath:@"borderColor"];
    animation.fromValue = (__bridge id)btn.layer.borderColor;
    animation.toValue = (__bridge id)toColor.CGColor;
    animation.duration = 0.25;
    [btn.layer addAnimation:animation forKey:@"borderColor"];
    btn.layer.borderColor = toColor.CGColor;
}

- (NSIndexPath *)indexPathForButton:(UIButton *)sender
{
    CGPoint point = [sender convertPoint:CGPointZero toView:self.collectionView];
    return [self.collectionView indexPathForItemAtPoint:point];
}

- (void)TestSettingSingleCell:(TestSettingViewSingleButtonCell *)cell didClickedButton:(ScaleableButton *)sender {
    NSIndexPath *indexPath = [self.collectionView indexPathForCell:cell];
    if (!indexPath) return;
    
     if (cell.settingScopeButton.accessibilityIdentifier) {
        cell.isSelected = !cell.isSelected;
    }
    
    [self.collectionView reloadItemsAtIndexPaths:@[indexPath]];
}
@end
*/
