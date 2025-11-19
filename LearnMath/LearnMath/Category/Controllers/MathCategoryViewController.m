//
//  MathCategoryViewController.m
//  LearnMath
//
//  Created by 基 on 2025/9/5.
//

#import "MathCategoryViewController.h"

@interface MathCategoryViewController ()<UICollectionViewDelegate,UICollectionViewDataSource,MathTrainsHomeCellDelegate,EachMathNavigationBarViewDelegate>
@property (nonatomic, strong) MathCategoryModels *model;
@property (nonatomic, strong) MathCategoryViewModel *viewModel;
@property (nonatomic, weak) ArithmeticPlayer *player;
@end

@implementation MathCategoryViewController

static NSString * const reuseIdentifier = @"Cell";

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.viewModel = [[MathCategoryViewModel alloc] init];
    [self.viewModel loadDate:self.categoryID];
    self.model = self.viewModel.model;
    
    EachMathNavigationBarView *navView = [[EachMathNavigationBarView alloc] initWithCategoryID:self.categoryID];
    navView.delegate = self;
    [self.view addSubview:navView];
    
    [navView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.view.mas_top);
        make.leading.equalTo(self.view.mas_leading);
        make.trailing.equalTo(self.view.mas_trailing);
        make.height.mas_equalTo(LearnMathScale(64.0) + LearnMathScale(59.0));
    }];
    
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
        make.top.equalTo(navView.mas_bottom);
    }];
    self.categoryCollectionView.delegate = self;
    self.categoryCollectionView.dataSource = self;
    
    [self.categoryCollectionView reloadData];
    
    UIColor *navColor = [EachMathNavigationBarView colorForCategoryID:self.categoryID];
    self.view.backgroundColor = navColor;
    
    [self.categoryCollectionView registerClass:[MathCateGoryViewCell class] forCellWithReuseIdentifier:reuseIdentifier];
    
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(onTrainProgressUpdated)
                                                 name:@"TrainProgressDidUpdate"
                                               object:nil];
}

- (void)onTrainProgressUpdated {

    [self.viewModel loadDate:self.categoryID];
    self.model = self.viewModel.model;

    [self.categoryCollectionView reloadData];
}

- (void)dealloc {
    [[NSNotificationCenter defaultCenter] removeObserver:self];
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
    cell.scaleButton.accessibilityIdentifier = self.categoryID;
    cell.titleLabel.text = self.model.skill[indexPath.row];
    cell.skillID = self.model.skillID[indexPath.row];
    
    MathSkills *skill = [[ArithmeticDbService sharedService] fetchSkillWithSkillID:cell.skillID];
    [cell configureWithSkill:skill maxTrainCount:20];
    cell.delegate = self;
    return cell;
}

#pragma mark - MathTrainsHomeCellDelegate
- (void)mathTrainsHomeCell:(MathCateGoryViewCell *)cell didClickedTutorialButton:(ScaleableButton *)tutorialButton
{
    NSIndexPath *indexPath = [self.categoryCollectionView indexPathForCell:cell];
    if (!indexPath || indexPath.row >= self.model.skill.count) return;
    
    NSString *skillName = self.model.skill[indexPath.row];
    NSString *videoURL = self.model.tutorialVideoURLs[indexPath.row];
    if (!skillName || !videoURL) return;
   
    [self.player hidePlayer];

    ArithmeticPlayer *player = [[ArithmeticPlayer alloc] initWithFrame:CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, [UIScreen mainScreen].bounds.size.height)];
    self.player = player;
    
    UIWindow *keyWindow = [UIApplication sharedApplication].windows.firstObject;
    [keyWindow addSubview:player];
   
    [player showWithCompletion:^{
        [player playVideo:videoURL title:skillName];
    }];
    
}

- (void)mathTrainsHomeCell:(MathCateGoryViewCell *)cell didClickedBgButton:(ScaleableButton *)bgButton
{
    TrainingSettingViewController *vc = [[TrainingSettingViewController alloc] init];
    vc.categoryID = bgButton.accessibilityIdentifier;
    vc.skillID = cell.skillID;
    vc.navColor = self.view.backgroundColor;
    [self.navigationController pushViewController:vc animated:YES];
}

- (void)eachMathNavigationBarViewDidClickBack:(EachMathNavigationBarView *)navBar {
    [self.navigationController popViewControllerAnimated:YES];
}
@end
