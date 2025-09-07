//
//  MathCategoryViewController.m
//  LearnMath
//
//  Created by 基 on 2025/9/5.
//

#import "MathCategoryViewController.h"

@interface MathCategoryViewController ()<UICollectionViewDelegate,UICollectionViewDataSource>
@property (nonatomic,strong)MathCategoryModels *model;

@end

@implementation MathCategoryViewController
static NSString * const reuseIdentifier = @"Cell";
-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [self.navigationController setNavigationBarHidden:NO animated:animated];
    [EachMathNavigationBar configureNavigationViewController:self withMathCategory:self.category];
}
- (void)viewDidLoad
{
    [super viewDidLoad];
    
    
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
    UIColor *navColor = [EachMathNavigationBar configureNavigationViewController:self withMathCategory:self.category];
    self.view.backgroundColor = navColor;
    
    [self.categoryCollectionView registerClass:[MathCateGoryViewCell class] forCellWithReuseIdentifier:reuseIdentifier];
    
    self.model = [MathCategoryModels skillsModelWithCategory:self.category];

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
        return cell;
}

@end
