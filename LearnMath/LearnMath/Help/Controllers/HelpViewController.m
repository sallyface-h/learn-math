//
//  HelpViewController.m
//  LearnMath
//
//  Created by 基 on 2025/9/16.
//

#import "HelpViewController.h"

@interface HelpViewController ()<UICollectionViewDataSource,UICollectionViewDelegateFlowLayout>
@property (nonatomic, strong) UICollectionView *collectionview;
@property (nonatomic, strong) UIImageView *smileImage;
@property (nonatomic, strong) UIImageView *bubbleImage;
@property (nonatomic, strong) HelpModels *models;

@end

@implementation HelpViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor colorForSet:ColorSetPurple];
    
    _bubbleImage = [[UIImageView alloc] init];
    _bubbleImage.image = [UIImage imageNamed:@"help_bubble"];
    [self.view addSubview: _bubbleImage];
    [self.bubbleImage mas_makeConstraints:^(MASConstraintMaker *make) {
        make.leading.mas_equalTo(LearnMathScale(30.0));
        make.top.mas_equalTo(LearnMathScale(65.0));
        make.size.mas_equalTo(CGSizeMake(LearnMathScale(200.0), LearnMathScale(80.0)));
    }];
    
    UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc] init];
    layout.itemSize = CGSizeMake(SCREEN_WIDTH - LearnMathScale(24.0) * 2, LearnMathScale(70.0));
    layout.minimumLineSpacing = LearnMathScale(12.0);
    layout.sectionInset = UIEdgeInsetsMake(LearnMathScale(40.0), 0.0, 0.0, 0.0);
    
    UICollectionView *collectionview = [[UICollectionView alloc] initWithFrame:CGRectZero collectionViewLayout:layout];
    self.collectionview = collectionview;
    self.collectionview.backgroundColor = [UIColor colorForSet:ColorSetWhite];
    self.collectionview.layer.cornerRadius = LearnMathScale(30.0);
    self.collectionview.layer.masksToBounds = YES;
    self.collectionview.layer.maskedCorners = kCALayerMaxXMinYCorner | kCALayerMinXMinYCorner;
    
    self.collectionview.delegate = self;
    self.collectionview.dataSource = self;
    
    [self.view addSubview:self.collectionview];
    [self.collectionview mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.leading.trailing.equalTo(self.view);
        make.top.mas_equalTo(LearnMathScale(170.0));
    }];
    
    _smileImage = [[UIImageView alloc] init];
    _smileImage.image = [UIImage imageNamed:@"help_smile"];
    [self.view addSubview:self.smileImage];
    [self.smileImage mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(LearnMathScale(170.0), LearnMathScale(130.0)));
        make.top.mas_equalTo(LearnMathScale(88.0));
        make.trailing.mas_equalTo(-LearnMathScale(17.0));
    }];
    
    self.models = [HelpModels modelWithTitleText:@[
        @"Begin your journey",
        @"Complete training progress",
        @"Do a test",
        @"Set up learning plan",
        @"Periodic review"
    ] andDetailText:@[
        @"Watch and learn math trick tutorials",
        @"Try to finish all the practices for each math trick",
        @"know better about your skill analysis by doing tests at any time",
        @"Follow the suggestions in the test result and try to set up learning plan",
        @"Regularly review your progress by comparing test histories and adjust your learning plan as needed"
    ] andNumImage:@[
        @"help_numimg1",
        @"help_numimg2",
        @"help_numimg3",
        @"help_numimg4",
        @"help_numimg5"
    ]];
    
    [self.collectionview registerClass:[HelpViewCell class] forCellWithReuseIdentifier:@"cell"];
    [self.collectionview registerClass:[HelpFooterView class] forSupplementaryViewOfKind:UICollectionElementKindSectionFooter withReuseIdentifier:@"footer"];
}

#pragma mark - UICollectionViewDataSource
- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView
{
    return 1;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return self.models.numImage.count;
}

- (__kindof UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    HelpViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"cell" forIndexPath:indexPath];
    cell.titleLabel.text = self.models.titleText[indexPath.row];
    cell.detailLabel.text = self.models.detailText[indexPath.row];
    NSString *imgName = self.models.numImage[indexPath.row];
    cell.numImgView.image = [UIImage imageNamed:imgName];
    return cell;
}

- (UICollectionReusableView *)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath
{
    if ([kind isEqualToString:UICollectionElementKindSectionFooter]) {
        HelpFooterView *footer = [collectionView dequeueReusableSupplementaryViewOfKind:UICollectionElementKindSectionFooter withReuseIdentifier:@"footer" forIndexPath:indexPath];
        [footer configureWithButtonTitle:@"OK"];
        [footer.button addTarget:self action:@selector(didButton:) forControlEvents:UIControlEventTouchUpInside];
        return footer;
    }
    return [UICollectionReusableView new];
}

#pragma mark - UICollectionViewDelegateFlowLayout
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout referenceSizeForFooterInSection:(NSInteger)section
{
    return CGSizeMake(collectionView.bounds.size.width, LearnMathScale(100.0));
}

#pragma mark - 按钮点击事件
- (void)didButton:(UIButton *)sender
{
    [self dismissViewControllerAnimated:YES completion:nil];
}
@end
