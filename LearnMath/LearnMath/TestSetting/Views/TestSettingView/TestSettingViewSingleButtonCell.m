//
//  TestSettingViewSingleButtonCell.m
//  LearnMath
//
//  Created by 基 on 2025/9/11.
//

#import "TestSettingViewSingleButtonCell.h"
@interface TestSettingViewSingleButtonCell () <UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout,ExpandButtonViewCellDelegate>
@property (nonatomic, strong) ExpandButtonModels *models;
@property (nonatomic, strong) UIView *lineView;
@property (nonatomic, strong) UIImageView *downImageView;
@property (nonatomic, copy) NSString *identifier;
@property (nonatomic, strong) NSIndexPath *currentExpandedIndexPath;
@end

@implementation TestSettingViewSingleButtonCell
- (instancetype)initWithFrame:(CGRect)frame
{
    if (self == [super initWithFrame:frame]) {
        [self setUpSubviews];
    }
    return self;
}

- (void)setUpSubviews
{
    _settingScopeButton = [ScaleableButton buttonWithType:UIButtonTypeCustom];
    _settingScopeButton.layer.cornerRadius = LearnMathScale(10.0);
    _settingScopeButton.layer.masksToBounds = NO;
    _settingScopeButton.layer.shadowOpacity = 1.0;
    _settingScopeButton.layer.shadowRadius = 0.0;
    _settingScopeButton.layer.shadowOffset = CGSizeMake(0.0,LearnMathScale(8.0));
    _settingScopeButton.backgroundColor = [UIColor colorForSet:ColorSetWhite];
    _settingScopeButton.layer.borderWidth = LearnMathScale(2.0);
    _settingScopeButton.layer.borderColor = [UIColor colorForSet:ColorSetSkillBorder].CGColor;
    _settingScopeButton.layer.shadowColor = [UIColor colorForSet:ColorSetSkillShadow].CGColor;
    [self.contentView addSubview:self.settingScopeButton];
    [self.settingScopeButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self.contentView);
    }];
    
    _titleLabel = [[UILabel alloc] init];
    _titleLabel.textColor = [UIColor colorForSet:ColorSetSkillTitle];
    _titleLabel.font =  [UIFont ap_poppins:14.0 weight:UIFontWeightBold];
    [self.settingScopeButton addSubview:self.titleLabel];
    [self.titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.contentView).offset(LearnMathScale(14.0));
        make.leading.mas_equalTo(LearnMathScale(16.0));
        make.trailing.mas_equalTo(-LearnMathScale(16.0));
        make.height.mas_equalTo(LearnMathScale(18.0));
    }];
    
    _selectedImageView = [[UIImageView alloc] init];
    _selectedImageView.hidden = YES;
    _selectedImageView.image =  [UIImage imageNamed:@"TestSetting_box_selected"];
    [self.settingScopeButton addSubview:self.selectedImageView];
    [self.selectedImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.trailing.mas_equalTo(-LearnMathScale(16.0));
        make.centerY.equalTo(self.titleLabel);
        make.size.mas_equalTo(CGSizeMake(LearnMathScale(18.0), LearnMathScale(18.0)));
    }];
    
    _downImageView = [[UIImageView alloc] init];
    _downImageView.image = [UIImage imageNamed:@"TestSetting_down"];
    [self.settingScopeButton addSubview:self.downImageView];
    [self.downImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(LearnMathScale(20.0), LearnMathScale(20.0)));
        make.centerY.equalTo(self.titleLabel);
        make.trailing.equalTo(self.settingScopeButton.mas_trailing).offset(LearnMathScale(-13.0));
    }];
    
    _lineView = [[UIView alloc] init];
    _lineView.hidden = YES;
    _lineView.backgroundColor = [UIColor colorForSet:ColorSetSkillBorder];
    [self.settingScopeButton addSubview:self.lineView];
    [self.lineView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.settingScopeButton).offset(LearnMathScale(43.0));
        make.trailing.equalTo(self.settingScopeButton).offset(-LearnMathScale(16.0));
        make.leading.equalTo(self.settingScopeButton).offset(LearnMathScale(16.0));
        make.height.mas_equalTo(LearnMathScale(1.0));
    }];
    
    UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc] init];
    layout.minimumLineSpacing = LearnMathScale(13.0);
    layout.sectionInset = UIEdgeInsetsMake(0.0 , 0.0 , LearnMathScale(20.0), 0.0 );
    
    _collectionView = [[UICollectionView alloc] initWithFrame:CGRectZero collectionViewLayout:layout];
    _collectionView.backgroundColor = [UIColor clearColor];
    _collectionView.dataSource = self;
    _collectionView.delegate = self;
    _collectionView.hidden = YES;
    [self.settingScopeButton addSubview:self.collectionView];
    [self.collectionView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.lineView.mas_bottom).offset(LearnMathScale(12));
        make.bottom.leading.trailing.equalTo(self.settingScopeButton);
    }];
    
    [self.collectionView registerClass:[ExpandButtonViewCell class] forCellWithReuseIdentifier:@"Cell"];
    
    [self.collectionView registerClass:[ExpandButtonHeaderView class] forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"headerCell"];

    _selectedIndexPaths = [NSMutableSet set];
}

- (void)configureWithExpandModel:(ExpandButtonModels *)model
                      identifier:(NSString *)identifier
                        expanded:(BOOL)expanded {
    self.identifier = identifier;
    self.models = model;
    self.lineView.hidden = !expanded;
    self.collectionView.hidden = !expanded;

    self.downImageView.transform = expanded ? CGAffineTransformMakeRotation(M_PI) : CGAffineTransformIdentity;
    
    if (expanded) {
        [self.collectionView reloadData];
            [self.collectionView layoutIfNeeded];
    }
}
#pragma mark - UICollectionViewDataSource
- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView
{
    if ([self.identifier isEqualToString:@"2"]) {
        return 1;
    }
    if ([self.identifier isEqualToString:@"3"]) {
        return self.models.title.count;;
    }
    return 0;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    if ([self.identifier isEqualToString:@"2"]) {
        return self.models.title.count;
    }
    if ([self.identifier isEqualToString:@"3"]) {
        return self.models.skill[section].count;
    }
    return 0;
}

- (__kindof UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    ExpandButtonViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"Cell" forIndexPath:indexPath];
    if ([self.identifier isEqualToString:@"2"]) {
        cell.titleLabel.text = self.models.title[indexPath.row];
    } else if([self.identifier isEqualToString:@"3"]) {
        cell.titleLabel.text = self.models.skill[indexPath.section][indexPath.row];
    }
    
    BOOL isSelected = [self.selectedIndexPaths containsObject:indexPath];
    cell.selectedImage.image = [UIImage imageNamed:isSelected ? @"TestSetting_box_selected" : @"TestSetting_box_unselect"];

    cell.delegeate = self;

    return cell;
}

- (UICollectionReusableView *)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath
{
    if ([kind isEqualToString:UICollectionElementKindSectionHeader] && [self.identifier isEqualToString:@"3"]){
            ExpandButtonHeaderView *header = [collectionView dequeueReusableSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"headerCell" forIndexPath:indexPath];
            [header configureWithTitle:self.models.title[indexPath.section]];
            return header;
        }
        return [UICollectionReusableView new];
}

#pragma mark - UICollectionViewDelegateFlowLayou
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{
    return CGSizeMake(self.settingScopeButton.bounds.size.width - LearnMathScale(16.0) * 2, LearnMathScale(18.0));
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout referenceSizeForHeaderInSection:(NSInteger)section
{
    if ([self.identifier isEqualToString:@"3"]) {
        return CGSizeMake(LearnMathScale(327), LearnMathScale(16.0));
    }
    return CGSizeZero;
}



- (void)ExpandButtonVIewCell:(ExpandButtonViewCell *)cell didClickedButton:(ScaleableButton *)sender
{
    NSIndexPath *indexPath = [self.collectionView indexPathForCell:cell];
    if ([self.selectedIndexPaths containsObject:indexPath]) {
        [self.selectedIndexPaths removeObject:indexPath];
    } else {
        [self.selectedIndexPaths addObject:indexPath];
    }
    [self.collectionView reloadItemsAtIndexPaths:@[indexPath]];
    
    NSMutableArray *selectedCategoyiedNames = [NSMutableArray array];
    NSMutableArray *skillWithCategoryPairs = [NSMutableArray array];
    
    for (NSIndexPath *idx in self.selectedIndexPaths) {
        NSString *name;
        if ([self.identifier isEqualToString:@"2"]) {
            name = self.models.title[idx.row];
            [selectedCategoyiedNames addObject:name];
        } else if ([self.identifier isEqualToString:@"3"]) {
            name = self.models.skill[idx.section][idx.row];
            NSString *skillName = self.models.skill[idx.section][idx.row];
            NSString *categoryName = self.models.title[idx.section];
        
            [selectedCategoyiedNames addObject:categoryName];
            
            NSDictionary *pair = @{@"skillName": skillName, @"categoryName": categoryName};
            [skillWithCategoryPairs addObject:pair];
        }
    }
    
    if ([self.delegate respondsToSelector:@selector(testSettingCell:didUpdateSelectedCategoriesNames:skillCategoryPairs:identifier:)]) {
        [self.delegate testSettingCell:self didUpdateSelectedCategoriesNames:selectedCategoyiedNames skillCategoryPairs:skillWithCategoryPairs identifier:self.identifier];
    }
}
@end
