//
//  MathHomeViewController.m
//  LearnMath
//
//  Created by 基 on 2025/9/4.
//

#import "MathHomeViewController.h"

@interface MathHomeViewController ()<UICollectionViewDataSource,UICollectionViewDelegate,MathHomeViewSingleButtonCellDelegate>

@end

@implementation MathHomeViewController

static NSString * const singleCellId = @"SingleCell";
static NSString * const multiCellId  = @"MultiCell";

- (void)viewDidLoad
{
    [super viewDidLoad];
    MathHomeHeaderView *headerView = [[MathHomeHeaderView alloc] init];
    self.view.backgroundColor = [UIColor colorForSet:ColorSetDeepBlue];
    [self.view addSubview:headerView];
    [headerView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.and.left.and.right.equalTo(self.view);
        make.height.mas_equalTo(LearnMathScale(210.0));
    }];
    
    UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc] init];
    layout.itemSize = CGSizeMake(LearnMathScale(327.0), LearnMathScale(68.0));
    layout.minimumLineSpacing = LearnMathScale(18.0);
    layout.sectionInset = UIEdgeInsetsMake(LearnMathScale(30.0), LearnMathScale(24.0), 0, LearnMathScale(24.0));
    
    UICollectionView *collectionView = [[UICollectionView alloc] initWithFrame:CGRectZero collectionViewLayout:layout];
    self.collectionView = collectionView;
    self.collectionView.backgroundColor = [UIColor colorForSet:ColorSetWhite];
    [self.view addSubview:collectionView];
    [self.collectionView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(headerView.mas_bottom);
            make.left.and.right.and.bottom.equalTo(self.view);
    }];
    self.collectionView.layer.cornerRadius = LearnMathScale(30.0);
    self.collectionView.layer.masksToBounds = YES;
    self.collectionView.layer.maskedCorners = kCALayerMinXMinYCorner | kCALayerMaxXMinYCorner;
    
    self.collectionView.delegate = self;
    self.collectionView.dataSource = self;
    
    [self.collectionView registerClass:[MathHomeViewSingleButtonCell class] forCellWithReuseIdentifier:singleCellId];
    [self.collectionView registerClass:[MathHomeViewMultiButtonCell class] forCellWithReuseIdentifier:multiCellId];
    
    _multiButtonImgNameArr = @[@"nil",@"icon-history",@"icon-1",@"icon-2",@"icon-3",@"icon-4"];
}


#pragma mark - UICollectionViewDataSource
- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView
{
    return 1;
}
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return 6;
}

- (__kindof UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    
    if (indexPath.row < 4) {
        MathHomeViewSingleButtonCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"SingleCell" forIndexPath:indexPath];
        cell.delegate = self;
        switch (indexPath.row) {
            case 0:
                [cell configureWithColor:[UIColor colorForSet:ColorSetDeepOrange] andTitle:@"Addition" andImage:@"btn-add"];
                break;
            case 1:
                [cell configureWithColor:[UIColor colorForSet:ColorSetOrange] andTitle:@"Subtraction" andImage:@"btn-sub"];
                break;
            case 2:
                [cell configureWithColor:[UIColor colorForSet:ColorSetBlue] andTitle:@"Multiplication" andImage:@"btn-mul"];
                break;
            case 3:
                [cell configureWithColor:[UIColor colorForSet:ColorSetGreen] andTitle:@"Division" andImage:@"btn-div"];
                break;
            default:
                break;
        }
        return cell;
    }else {
        MathHomeViewMultiButtonCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"MultiCell" forIndexPath:indexPath];
        if (indexPath.row == 4) {
            NSArray *imageName = [_multiButtonImgNameArr subarrayWithRange:NSMakeRange(0, 2)];
            [cell configureWithColor:[UIColor colorForSet:ColorSetPink]andButtons:imageName];
        } else if (indexPath.row == 5) {
            NSArray *imageName = [_multiButtonImgNameArr subarrayWithRange:NSMakeRange(2, 4)];
            [cell configureWithColor:[UIColor colorForSet:ColorSetPurple] andButtons:imageName];
        }
        return cell;
    }
    
}

#pragma mark - MathHomeViewSingleButtonCellDelegate
- (void)mathHomeViewSingleButtonCellDidTapButton:(MathHomeViewSingleButtonCell *)cell{
    NSIndexPath *indexPath = [self.collectionView indexPathForCell:cell];
    switch (indexPath.row) {
        case 0:
            [self additionTapped];
            break;
        case 1:
            [self subtractionTapped];
            break;
        case 2:
            [self multiplicationTapped];
            break;
        case 3:
            [self divisionTapped];
            break;
        default:
            break;
    }
}

#pragma mark - 跳转方法
- (void)additionTapped
{
    [self jumpToCollectionViewWithMathCategory:mathCategoryAddition];
}

- (void)subtractionTapped
{
    [self jumpToCollectionViewWithMathCategory:mathCategorySubtraction];
}

- (void)multiplicationTapped
{
    [self jumpToCollectionViewWithMathCategory:mathCategoryMultiplication];
}

- (void)divisionTapped
{
    [self jumpToCollectionViewWithMathCategory:mathCategoryDivision];
}

-(void)jumpToCollectionViewWithMathCategory:(mathCategory)category
{
    UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc] init];
    layout.itemSize = CGSizeMake(LearnMathScale(327.0), LearnMathScale(68.0));
    layout.minimumLineSpacing = LearnMathScale(18.0);
    layout.sectionInset = UIEdgeInsetsMake(LearnMathScale(24.0), 0.0, 0.0, 0.0);
    MathCateGoryCollectionViewController *vc = [[MathCateGoryCollectionViewController alloc]initWithCollectionViewLayout:layout];
    vc.category = category;
    [self.navigationController pushViewController:vc animated:YES];
}
- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [self.navigationController setNavigationBarHidden:YES animated:animated];
}
@end
