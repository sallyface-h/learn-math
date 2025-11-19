//
//  TrainingSettingViewController.m
//  LearnMath
//
//  Created by 基 on 2025/9/8.
//

#import "TrainingSettingViewController.h"

@interface TrainingSettingViewController ()<UICollectionViewDataSource,UICollectionViewDelegateFlowLayout,EachMathNavigationBarViewDelegate>
@property (nonatomic, strong)TrainingSettingModels *model;
@property (nonatomic, strong) UIButton *selectedSingleButton;
@property (nonatomic, strong) UIButton *selectedMultiButton;
@property (nonatomic, strong) UIColor *bgColor;
@end

@implementation TrainingSettingViewController

static NSString * const singleButtonId = @"SingleCell";
static NSString * const multiButtonId = @"MultiCell";
static NSString * const headerId = @"header";
static NSString * const footerId = @"footer";

- (void)viewDidLoad {
    [super viewDidLoad];
    TrainSettingViewModel *viewModel = [[TrainSettingViewModel alloc] init];
    NSArray *digits = [viewModel loadDigitsData];
    NSArray *countDown = [viewModel loadCountDownData];
    self.model = [TrainingSettingModels modelWithCalculateNum:digits andCountDownOfQuestion:countDown];
    
    EachMathNavigationBarView *navView = [[EachMathNavigationBarView alloc] initWithCategoryID:self.categoryID];
    navView.delegate = self;
    [self.view addSubview:navView];

    [navView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.view.mas_top);
        make.leading.equalTo(self.view.mas_leading);
        make.trailing.equalTo(self.view.mas_trailing);
        make.height.mas_equalTo(LearnMathScale(64.0) + LearnMathScale(59.0));
    }];
    _bgColor = [EachMathNavigationBarView colorForCategoryID:self.categoryID];
    
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
        make.top.equalTo(navView.mas_bottom);
        make.bottom.leading.trailing.equalTo(self.view);
    }];
    
    self.collectionView.dataSource = self;
    self.collectionView.delegate = self;
    
    [self.collectionView registerClass:[TrainingSettingViewSingleButtonCell class] forCellWithReuseIdentifier:singleButtonId];
    [self.collectionView registerClass:[TrainingSettingViewMultiButtonCell class] forCellWithReuseIdentifier:multiButtonId];
    [self.collectionView registerClass:[TrainingSettingHeaderView class] forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:headerId];
    [self.collectionView registerClass:[TrainingSettingFooterView class] forSupplementaryViewOfKind:UICollectionElementKindSectionFooter withReuseIdentifier:footerId];
    
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
        [cell configureWithCalculateNums:self.model.calculateNum];
        for (UIButton *btn in cell.settingNumButtonArr) {
            [btn addTarget:self action:@selector(didMultiButton:) forControlEvents:UIControlEventTouchUpInside];
        }
        return cell;
    } else {
        TrainingSettingViewSingleButtonCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:singleButtonId forIndexPath:indexPath];
        NSString *btnID = self.model.countDownOfQuestion[indexPath.row][@"ButtonID"];
        cell.titleLabel.text = self.model.countDownOfQuestion[indexPath.row][@"Text"];
        cell.settingTimeButton.accessibilityIdentifier = btnID;
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
            [footer.button addTarget:self action:@selector(didClickStartButton:) forControlEvents:UIControlEventTouchUpInside];
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
    if (self.selectedSingleButton &&
        [sender.accessibilityIdentifier isEqualToString:self.selectedSingleButton.accessibilityIdentifier]) {
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
    
    animateBorderColor(self.selectedSingleButton,[UIColor colorForSet:ColorSetSkillBorder]);
    animateBorderColor(sender,[UIColor colorForSet:ColorSetPurple]);
    
    self.selectedSingleButton = sender;
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

- (void)didClickStartButton:(UIButton *)sender
{
    if (!self.selectedSingleButton || !self.selectedMultiButton) {
            return;
        }

    NSString *digitID = self.selectedMultiButton.accessibilityIdentifier;
    NSString *countdownID = self.selectedSingleButton.accessibilityIdentifier;
    
    MathWorkSelectedTrainOptions *trainOptions = [[MathWorkSelectedTrainOptions alloc] init];
    trainOptions.trainDigitKey = digitID;
    trainOptions.trainCountdownKey = countdownID;
    trainOptions.skillID = self.skillID;
    
    NSDictionary *params = @{
            @"bgColor": self.bgColor,
            @"trainOptions": trainOptions,
        };
    MathAnswerSheetViewController *vc = [[MathAnswerSheetViewController alloc] initWithParams:params];
    [self.navigationController pushViewController:vc animated:YES];
}

- (void)eachMathNavigationBarViewDidClickBack:(EachMathNavigationBarView *)navBar {
    [self.navigationController popViewControllerAnimated:YES];
}
@end
