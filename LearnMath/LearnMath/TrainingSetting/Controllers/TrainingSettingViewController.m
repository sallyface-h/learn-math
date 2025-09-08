//
//  TrainingSettingViewController.m
//  LearnMath
//
//  Created by 基 on 2025/9/8.
//

#import "TrainingSettingViewController.h"

@interface TrainingSettingViewController ()<UICollectionViewDataSource,UICollectionViewDelegate>
@property (nonatomic, strong)TrainingSettingModels *model;
@end

@implementation TrainingSettingViewController

static NSString * const singleButtonId = @"SingleCell";
static NSString * const multiButtonId = @"MultiCell";

- (void)viewWillAppear:(BOOL)animated
{
    [TrainingSettingNavigationBar configureNavigationViewController:self withMathCategory:self.category];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc] init];
    layout.minimumLineSpacing = LearnMathScale(14.0);
    layout.itemSize = CGSizeMake(SCREEN_WIDTH - LearnMathScale(24.0) * 2, LearnMathScale(46.0));
    layout.sectionInset = UIEdgeInsetsMake(LearnMathScale(24.0), 0.0, 0.0, 0.0);
    
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
    
    self.model = [TrainingSettingModels trainingSettingModelMake];
    
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
        return cell;
    } else {
        TrainingSettingViewSingleButtonCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:singleButtonId forIndexPath:indexPath];
        cell.titleLabel.text = self.model.countDownOfQuestion[indexPath.row];
        return cell;
    }
}

#pragma mark - UICollectionViewDelegate

@end
