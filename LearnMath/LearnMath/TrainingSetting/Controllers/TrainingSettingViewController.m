//
//  TrainingSettingViewController.m
//  LearnMath
//
//  Created by 基 on 2025/9/8.
//

#import "TrainingSettingViewController.h"

@interface TrainingSettingViewController ()<UICollectionViewDataSource,UICollectionViewDelegateFlowLayout>
@property (nonatomic, strong)TrainingSettingModels *model;
@property (nonatomic, strong)NSIndexPath *singleBtnSelectedIndexPath;
@property (nonatomic, assign)NSInteger multiBtnSelectedIndex;
@end

@implementation TrainingSettingViewController

static NSString * const singleButtonId = @"SingleCell";
static NSString * const multiButtonId = @"MultiCell";
static NSString * const headerId = @"header";
static NSString * const footerId = @"footer";

- (void)viewWillAppear:(BOOL)animated
{
    [TrainingSettingNavigationBar configureNavigationViewController:self withMathCategoryID:self.categoryID];
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
    
    self.collectionView.dataSource = self;
    self.collectionView.delegate = self;
    
    [self.collectionView registerClass:[TrainingSettingViewSingleButtonCell class] forCellWithReuseIdentifier:singleButtonId];
    [self.collectionView registerClass:[TrainingSettingViewMultiButtonCell class] forCellWithReuseIdentifier:multiButtonId];
    [self.collectionView registerClass:[TrainingSettingHeaderView class] forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:headerId];
    [self.collectionView registerClass:[TrainingSettingFooterView class] forSupplementaryViewOfKind:UICollectionElementKindSectionFooter withReuseIdentifier:footerId];
    
    self.model = [TrainingSettingModels modelWithCalculateNum:@[@"<10",@"<100"] andCountDownOfQuestion:@[@"No",@"10 Sec",@"20 Sec",@"30 Sec"]];
    
    self.singleBtnSelectedIndexPath = [NSIndexPath indexPathForItem:0 inSection:1];
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
        return 1;
    } else {
        return self.model.countDownOfQuestion.count;
    }
}

- (__kindof UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
   
    if (indexPath.section == 0) {
        TrainingSettingViewMultiButtonCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:multiButtonId forIndexPath:indexPath];
        [cell configureWithCalculateNums:self.model.calculateNum andSelectedIndex:self.multiBtnSelectedIndex];
        for (UIButton *btn in cell.settingNumButtonArr) {
            [btn addTarget:self action:@selector(didMultiButton:) forControlEvents:UIControlEventTouchUpInside];
        }
        return cell;
    } else {
        TrainingSettingViewSingleButtonCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:singleButtonId forIndexPath:indexPath];
        cell.titleLabel.text = self.model.countDownOfQuestion[indexPath.row];
        if ([indexPath isEqual:self.singleBtnSelectedIndexPath]) {
            cell.settingTimeButton.layer.borderColor = [UIColor colorForSet:ColorSetPurple].CGColor;
        } else {
            cell.settingTimeButton.layer.borderColor = [UIColor colorForSet:ColorSetSkillBorder].CGColor;
        }
        [cell.settingTimeButton addTarget:self action:@selector(didSingleButton:) forControlEvents:UIControlEventTouchUpInside];
        return cell;
    }
}

- (UICollectionReusableView *)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath
{
    if ([kind isEqualToString:UICollectionElementKindSectionHeader]) {
        TrainingSettingHeaderView *header = [collectionView dequeueReusableSupplementaryViewOfKind:kind withReuseIdentifier:headerId forIndexPath:indexPath];
        if (indexPath.section == 0) {
            [header configureWithTitle:@"Calculated number:"];
        } else {
            [header configureWithTitle:@"Countdown for each question"];
        }
        return header;
    } else if ([kind isEqualToString:UICollectionElementKindSectionFooter]){
        TrainingSettingFooterView *footer = [collectionView dequeueReusableSupplementaryViewOfKind:kind withReuseIdentifier:footerId forIndexPath:indexPath];
        if (indexPath.section == 1) {
            [footer.button setTitle:@"Start!" forState:UIControlStateNormal];
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
    NSIndexPath *newIndexPath = [self.collectionView indexPathForCell:(TrainingSettingViewSingleButtonCell *)sender.superview.superview];
    if ([newIndexPath isEqual:self.singleBtnSelectedIndexPath]) {
        return;
    }
    NSIndexPath *oldIndexPath = self.singleBtnSelectedIndexPath;
    self.singleBtnSelectedIndexPath = newIndexPath;
    
    TrainingSettingViewSingleButtonCell *oldCell = [self.collectionView cellForItemAtIndexPath:oldIndexPath];
    TrainingSettingViewSingleButtonCell *newCell = [self.collectionView cellForItemAtIndexPath:newIndexPath];
    
    void(^animateBorderColor)(UIButton *,UIColor *) = ^(UIButton *btn,UIColor *toColor){
        CABasicAnimation *animation = [CABasicAnimation animationWithKeyPath:@"borderColor"];
        animation.fromValue = (__bridge id)sender.layer.borderColor;
        animation.toValue = (__bridge id)toColor.CGColor;
        animation.duration = 0.3;
        btn.layer.borderColor = toColor.CGColor;
        [btn.layer addAnimation:animation forKey:@"borderColor"];
    };
    
    animateBorderColor(oldCell.settingTimeButton,[UIColor colorForSet:ColorSetSkillBorder]);
    animateBorderColor(newCell.settingTimeButton,[UIColor colorForSet:ColorSetPurple]);
}

- (void)didMultiButton:(UIButton *)sender
{
    TrainingSettingViewMultiButtonCell *cell = [self.collectionView cellForItemAtIndexPath:[NSIndexPath indexPathForRow:0 inSection:0]];
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
