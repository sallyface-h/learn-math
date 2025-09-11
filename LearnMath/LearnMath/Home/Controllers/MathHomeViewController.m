//
//  MathHomeViewController.m
//  LearnMath
//
//  Created by 基 on 2025/9/4.
//

#import "MathHomeViewController.h"

@interface MathHomeViewController ()<UICollectionViewDataSource,UICollectionViewDelegate,MathHomeViewSingleButtonCellDelegate,MathHomeViewMultiButtonCellDelegate>
@property (nonatomic, strong) HomeSingleButtonModel *singleButtonModels;
@property (nonatomic, strong) NSArray <HomeMultiButtonModel *> *multiButtonModels;


@end

@implementation MathHomeViewController

static NSString * const singleCellId = @"SingleCell";
static NSString * const multiCellId  = @"MultiCell";

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [self.navigationController setNavigationBarHidden:YES animated:animated];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    MathHomeHeaderView *headerView = [[MathHomeHeaderView alloc] init];
    self.view.backgroundColor = [UIColor colorForSet:ColorSetDeepBlue];
    [self.view addSubview:headerView];
    [headerView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.leading.trailing.equalTo(self.view);
        make.height.mas_equalTo(LearnMathScale(210.0));
    }];
    
    UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc] init];
    layout.itemSize = CGSizeMake(SCREEN_WIDTH - LearnMathScale(24.0) * 2, LearnMathScale(68.0));
    layout.minimumLineSpacing = LearnMathScale(18.0);
    layout.sectionInset = UIEdgeInsetsMake(LearnMathScale(30.0), 0.0, 0.0, 0.0);
    
    UICollectionView *collectionView = [[UICollectionView alloc] initWithFrame:CGRectZero collectionViewLayout:layout];
    self.collectionView = collectionView;
    self.collectionView.backgroundColor = [UIColor colorForSet:ColorSetWhite];
    [self.view addSubview:collectionView];
    [self.collectionView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(headerView.mas_bottom);
        make.leading.trailing.and.bottom.equalTo(self.view);
    }];
    self.collectionView.layer.cornerRadius = LearnMathScale(30.0);
    self.collectionView.layer.masksToBounds = YES;
    self.collectionView.layer.maskedCorners = kCALayerMinXMinYCorner | kCALayerMaxXMinYCorner;
    
    self.collectionView.delegate = self;
    self.collectionView.dataSource = self;
    
    [self.collectionView registerClass:[MathHomeViewSingleButtonCell class] forCellWithReuseIdentifier:singleCellId];
    [self.collectionView registerClass:[MathHomeViewMultiButtonCell class] forCellWithReuseIdentifier:multiCellId];
 
    self.singleButtonModels = [HomeSingleButtonModel modelWithSingleButtonTitle:@[
        @"Addition",
        @"Subteaction",
        @"Multiplication",
        @"Division"
    ]
    andImage:@[
        @"home_add",
        @"home_sub",
        @"home_mul",
        @"home_div"
    ]
    andColor:@[
        [UIColor colorForSet:ColorSetDeepOrange],
        [UIColor colorForSet:ColorSetOrange],
        [UIColor colorForSet:ColorSetBlue],
        [UIColor colorForSet:ColorSetGreen]
    ]
    andCategory:@[
        @(MathCategoryAddition),
        @(MathCategorySubtraction),
        @(MathCategoryMultiplication),
        @(MathCategoryDivision)
    ]];
    
    HomeMultiButtonModel *firstCell = [HomeMultiButtonModel modelWithMultiButtonImgName:@[
        @"nil",
        @"home_history"
    ]
    andTitle:@[
        @"Do a Test!",
        @"nil"
    ]
    andColor:[UIColor colorForSet:ColorSetPink]
    andCategory:@[
        @(MathCategoryTest),
        @(MathCategoryHistory)
    ]];

    HomeMultiButtonModel *secondCell = [HomeMultiButtonModel modelWithMultiButtonImgName:@[
        @"home_date",
        @"home_help",
        @"home_setting",
        @"home_subscription"
    ]
    andTitle:@[
        @"nil",
        @"nil",
        @"nil",
        @"nil"
    ]
    andColor:[UIColor colorForSet:ColorSetPurple]
   andCategory:@[
        @(MathCategoryDate),
        @(MathCategoryHelp),
        @(MathCategorySetting),
        @(MathCategorySubscription)
    ]];
    
    self.multiButtonModels = @[firstCell, secondCell];
}


#pragma mark - UICollectionViewDataSource
- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView
{
    return 1;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return self.singleButtonModels.title.count + self.multiButtonModels.count;
}

- (__kindof UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.row < self.singleButtonModels.title.count) {
        MathHomeViewSingleButtonCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"SingleCell" forIndexPath:indexPath];
        cell.delegate = self;
        [cell configureWithModel:self.singleButtonModels atIndex:indexPath.row];
        return cell;
    }else {
        MathHomeViewMultiButtonCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"MultiCell" forIndexPath:indexPath];
        cell.delegate = self;
        [cell configureWithModel:self.multiButtonModels[indexPath.row - self.singleButtonModels.title.count]];
        return cell;
    }
}

#pragma mark - MathHomeViewSingleButtonCellDelegate
- (void)mathHomeViewSingleButtonCellDidTapButton:(MathHomeViewSingleButtonCell *)cell
{
    NSIndexPath *indexPath = [self.collectionView indexPathForCell:cell];
    if (indexPath.row < self.singleButtonModels.title.count) {
        [self jumpToCollectionViewWithMathCategory:[self.singleButtonModels.category[indexPath.row] integerValue]];
    }
}

#pragma mark - MathHomeViewMultiButtonCellDelegate
- (void)mathHomeViewMultiButtonCell:(MathHomeViewMultiButtonCell *)cell andDidTapButtonAtIndex:(NSInteger)index
{
    NSIndexPath *indexPath = [self.collectionView indexPathForCell:cell];
    if (indexPath.row >= self.singleButtonModels.title.count) {
        HomeMultiButtonModel *model = self.multiButtonModels[indexPath.row - self.singleButtonModels.title.count];
        MathCategory category = [model categoryAtIndex:index];
        [self jumpToCollectionViewWithTest:category];
    }
}

#pragma mark - 跳转方法
- (void)jumpToCollectionViewWithMathCategory:(MathCategory)category
{
    MathCategoryViewController *vc = [[MathCategoryViewController alloc] init];
    vc.category = category;
    [self.navigationController pushViewController:vc animated:YES];
}

- (void)jumpToCollectionViewWithTest:(MathCategory)category
{
    TestSettingViewController *vc = [[TestSettingViewController alloc] init];
    vc.category = category;
    [self.navigationController pushViewController:vc animated:YES];
}

@end
