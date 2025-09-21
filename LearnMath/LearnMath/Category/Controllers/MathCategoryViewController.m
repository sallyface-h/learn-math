//
//  MathCategoryViewController.m
//  LearnMath
//
//  Created by 基 on 2025/9/5.
//

#import "MathCategoryViewController.h"

@interface MathCategoryViewController ()<UICollectionViewDelegate,UICollectionViewDataSource>
@property (nonatomic, strong)MathCategoryModels *model;
@property (nonatomic, strong)MathCategoryViewModel *viewModel;
@end

@implementation MathCategoryViewController

static NSString * const reuseIdentifier = @"Cell";

-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [self.navigationController setNavigationBarHidden:NO animated:animated];
    [EachMathNavigationBar configureNavigationViewController:self withMathCategoryID:self.categoryID];
}
- (void)viewDidLoad
{
    [super viewDidLoad];
    self.viewModel = [[MathCategoryViewModel alloc] init];
    [self.viewModel loadDate:self.categoryID];
    [self.categoryCollectionView reloadData];
    self.model = self.viewModel.model;
    
    UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc] init];
    layout.itemSize = CGSizeMake(SCREEN_WIDTH - LearnMathScale(24.0) * 2, LearnMathScale(72.0));
    layout.minimumLineSpacing = LearnMathScale(18.0);
    layout.sectionInset = UIEdgeInsetsMake(LearnMathScale(24.0),LearnMathScale(24.0), 0.0, LearnMathScale(24.0));
    
    UICollectionView *categoryCollectionView = [[UICollectionView alloc] initWithFrame:CGRectZero collectionViewLayout:layout];
    self.categoryCollectionView = categoryCollectionView;
    self.categoryCollectionView.layer.cornerRadius = LearnMathScale(30.0);
    self.categoryCollectionView.layer.masksToBounds = YES;
    self.categoryCollectionView.layer.maskedCorners = kCALayerMinXMinYCorner | kCALayerMaxXMinYCorner;
    [self.view addSubview:self.categoryCollectionView];
    [self.categoryCollectionView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.leading.bottom.trailing.equalTo(self.view);
        make.top.equalTo(self.view.mas_safeAreaLayoutGuideTop);
    }];
    self.categoryCollectionView.delegate = self;
    self.categoryCollectionView.dataSource = self;
    
    [self.categoryCollectionView reloadData];
    
    UIColor *navColor = [EachMathNavigationBar configureNavigationViewController:self withMathCategoryID:self.categoryID];
    self.view.backgroundColor = navColor;
    
    [self.categoryCollectionView registerClass:[MathCateGoryViewCell class] forCellWithReuseIdentifier:reuseIdentifier];
    NSLog(@"categoryID = %@", self.categoryID);
    NSLog(@"self.model.skill = %@", self.model.skill);
}

#pragma mark - UICollectionViewDataSource
- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView
{
    return 1;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return self.model.skill.count;
}

- (__kindof UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    
    MathCateGoryViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:reuseIdentifier forIndexPath:indexPath];
    cell.titleLabel.text = self.model.skill[indexPath.row];
    [cell.scaleButton addTarget:self action:@selector(jumpToTrainingSettingView:) forControlEvents:UIControlEventTouchUpInside];
    return cell;
}

#pragma mark - 跳转方法
-(void)jumpToTrainingSettingView:(NSString *)categoryID
{
    TrainingSettingViewController *vc = [[TrainingSettingViewController alloc] init];
    vc.categoryID = categoryID;
    vc.navColor = self.view.backgroundColor;
    [self.navigationController pushViewController:vc animated:YES];
}

@end
