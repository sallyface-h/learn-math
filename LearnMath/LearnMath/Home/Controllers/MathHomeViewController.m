//
//  MathHomeViewController.m
//  LearnMath
//
//  Created by 基 on 2025/9/4.
//

#import "MathHomeViewController.h"

@interface MathHomeViewController ()<UICollectionViewDataSource,UICollectionViewDelegate,MathHomeViewSingleButtonCellDelegate,MathHomeViewMultiButtonCellDelegate>
@property (nonatomic, strong) HomeButtonViewModel *viewModel;
@property (nonatomic, strong) NSArray<HomeMultiButtonModel *> *multiButtonModels;
@property (nonatomic, strong) HomeSingleButtonModel *singleButtonModels;
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
    self.viewModel = [[HomeButtonViewModel alloc] init];
    [self.viewModel loadCategoryDate];
    
    self.singleButtonModels = self.viewModel.singleButtonModels;
    self.multiButtonModels = self.viewModel.multiButtonModels;
    
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
    [self.collectionView reloadData];
    
    [self.collectionView registerClass:[MathHomeViewSingleButtonCell class] forCellWithReuseIdentifier:singleCellId];
    [self.collectionView registerClass:[MathHomeViewMultiButtonCell class] forCellWithReuseIdentifier:multiCellId];
    
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
        [self jumpToViewWithMathCategoryID:cell.categoryID];
    }
}

#pragma mark - MathHomeViewMultiButtonCellDelegate
/*- (void)mathHomeViewMultiButtonCell:(MathHomeViewMultiButtonCell *)cell andDidTapButtonAtIndex:(NSInteger)index
{
    NSIndexPath *indexPath = [self.collectionView indexPathForCell:cell];
    if (indexPath.row >= self.singleButtonModels.title.count) {
        HomeMultiButtonModel *model = self.multiButtonModels[indexPath.row - self.singleButtonModels.title.count];
        MathCategory category = [model categoryAtIndex:index];
        switch (category) {
                case MathCategoryTest:
                    [self jumpToViewWithTest:category];
                    break;
                case MathCategoryHelp:
                    [self jumpToViewWithHelp:category];
                default:
                    break;
                }
            }
    }*/


#pragma mark - 跳转方法
- (void)jumpToViewWithMathCategoryID:(NSString *)categoryID
{
    MathCategoryViewController *vc = [[MathCategoryViewController alloc] init];
    NSLog(@"Tapped cell categoryID = %@", categoryID);
    vc.categoryID = categoryID;
    [self.navigationController pushViewController:vc animated:YES];
}

- (void)jumpToViewWithTest:(NSString *)categoryID
{
    TestSettingViewController *vc = [[TestSettingViewController alloc] init];
    vc.categoryID = categoryID;
    vc.titleName = self.singleButtonModels.title;
    [self.navigationController pushViewController:vc animated:YES];
}

- (void)jumpToViewWithHelp:(MathCategory)category
{
    HelpViewController *vc = [[HelpViewController alloc] init];
    vc.modalPresentationStyle = UIModalPresentationFullScreen;
    vc.modalTransitionStyle = UIModalTransitionStyleCoverVertical;
    [self presentViewController:vc animated:YES completion:nil];
}

@end
