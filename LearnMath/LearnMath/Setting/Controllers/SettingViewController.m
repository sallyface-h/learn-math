//
//  SettingViewController.m
//  LearnMath
//
//  Created by 基 on 2025/10/14.
//

#import "SettingViewController.h"
#import "EachMathNavigationBarView.h"
@interface SettingViewController ()<UICollectionViewDataSource,UICollectionViewDelegateFlowLayout,SettingsCellDelegate,EachMathNavigationBarViewDelegate>
@property (nonatomic, strong) UICollectionView *collectionView;
@property (nonatomic, strong) NSArray<SettingItem *> *items;
@end

@implementation SettingViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setupNavigationBar];
    [self setupCollectionView];
    [self generateItems];
}
- (void)setupNavigationBar {
    EachMathNavigationBarView *navView = [[EachMathNavigationBarView alloc] initWithCategoryID:self.categoryID];
    navView.delegate = self;
    [self.view addSubview:navView];
    [navView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.leading.trailing.equalTo(self.view);
        make.height.mas_equalTo(LearnMathScale(64.0) + LearnMathScale(59.0));
    }];
}

- (void)setupCollectionView {
    self.view.backgroundColor = [UIColor colorForSet:ColorSetPurple];
    
    UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc] init];
    layout.minimumLineSpacing = LearnMathScale(14.0);
    layout.sectionInset = UIEdgeInsetsMake(LearnMathScale(24.0), LearnMathScale(24.0), LearnMathScale(24.0), LearnMathScale(24.0));
    layout.itemSize = CGSizeMake(SCREEN_WIDTH - LearnMathScale(24.0)*2, LearnMathScale(58.0));

    self.collectionView = [[UICollectionView alloc] initWithFrame:CGRectZero collectionViewLayout:layout];
    self.collectionView.backgroundColor = [UIColor colorForSet:ColorSetWhite];
    self.collectionView.layer.cornerRadius = LearnMathScale(30.0);
    self.collectionView.layer.masksToBounds = YES;
    self.collectionView.layer.maskedCorners = kCALayerMinXMinYCorner | kCALayerMaxXMinYCorner;
    self.collectionView.delegate = self;
    self.collectionView.dataSource = self;
    [self.collectionView registerClass:[SettingViewCell class] forCellWithReuseIdentifier:@"cell"];
    [self.view addSubview:self.collectionView];

    [self.collectionView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.view.mas_top).offset(LearnMathScale(123.0));
        make.leading.trailing.bottom.equalTo(self.view);
    }];
}

- (void)generateItems {
    SettingItem *sound = [[SettingItem alloc] initWithType:SettingItemTypeSoundEffects title:@"Sound Effects" subTitle:nil isOn:!AppStoreKit.isSoundEffectsDisable];
    SettingItem *haptics = [[SettingItem alloc] initWithType:SettingItemTypeHaptics title:@"Haptics" subTitle:nil isOn:!AppStoreKit.isHapticsDisable];
    SettingItem *clear = [[SettingItem alloc] initWithType:SettingItemTypeClearCache title:@"Clear Cache" subTitle:@"0MB" isOn:NO];

    self.items = @[sound, haptics, clear];
    [self.collectionView reloadData];
}
#pragma mark - UICollectionViewDataSource
- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView
{
    return 1;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return self.items.count;
}

- (__kindof UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    SettingViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"cell" forIndexPath:indexPath];
    SettingItem *item = self.items[indexPath.item];
    [cell configureWithItem:item];
    cell.delegate = self;
    return cell;
}

#pragma mark - SettingsCellDelegate
- (void)settingsCell:(SettingViewCell *)cell switchBtnValueChanged:(SevenSwitch *)switchBtn {
    NSIndexPath *indexPath = [self.collectionView indexPathForCell:cell];
    if (!indexPath) return;
    SettingItem *item = self.items[indexPath.item];
    item.isOn = switchBtn.on;

    switch (item.type) {
        case SettingItemTypeSoundEffects:
            [AppStoreKit soundEffectsDisable:!switchBtn.on];
            break;
        case SettingItemTypeHaptics:
            [AppStoreKit hapticsDisable:!switchBtn.on];
            break;
        default:
            break;
    }
}

- (void)settingsCell:(SettingViewCell *)cell didClickedClearBtn:(UIButton *)button {
    NSLog(@"点击清理缓存");
    // 调用缓存清理逻辑
}
@end
