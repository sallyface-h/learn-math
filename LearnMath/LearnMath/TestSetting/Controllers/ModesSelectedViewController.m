//
//  ModesSelectedViewController.m
//  LearnMath
//
//  Created by 基 on 2025/9/17.
//

#import "ModesSelectedViewController.h"

@interface ModesSelectedViewController ()<UICollectionViewDataSource,UICollectionViewDelegateFlowLayout>
@property (nonatomic, strong) UICollectionView *collectionView;
@property (nonatomic ,strong) ModesSelectedModels *models;
@end

@implementation ModesSelectedViewController
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
    
    self.models = [ModesSelectedModels modelWithImgName:@[
        @"TestSetting_option_1",
        @"TestSetting_option_1",
        @"TestSetting_option_1",
        @"TestSetting_option_2",
        @"TestSetting_option_2",
        @"TestSetting_option_2",
        @"TestSetting_option_3"
    ] andTitleText:@[
        @"10 Questions (Unlimited time)",
        @"25 Questions (Unlimited time)",
        @"50 Questions (Unlimited time)",
        @"1 Min (Unlimited question)",
        @"5 Min (Unlimited question)",
        @"15 Min (Unlimited question)",
        @"Survive (3 times error will end)"
    ]];
    
    [self.collectionView registerClass:[ModesSelectedViewCell class] forCellWithReuseIdentifier:@"cell"];
    
    
}

#pragma mark - UICollectionViewDataSource
 - (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView
{
    return 1;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return self.models.titleText.count;
}

- (__kindof UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    ModesSelectedViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"cell" forIndexPath:indexPath];
    cell.titleLabel.text = self.models.titleText[indexPath.row];
    NSString *imgName = self.models.imgName[indexPath.row];
    cell.modeImg.image = [UIImage imageNamed:imgName];
    return cell;
}
@end
