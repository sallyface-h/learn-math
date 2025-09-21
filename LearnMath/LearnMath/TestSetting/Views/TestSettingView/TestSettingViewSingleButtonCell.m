//
//  TestSettingViewSingleButtonCell.m
//  LearnMath
//
//  Created by 基 on 2025/9/11.
//

#import "TestSettingViewSingleButtonCell.h"
@interface TestSettingViewSingleButtonCell () <UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout>
@property (nonatomic, strong) ExpandButtonModels *models;
@property (nonatomic, strong) UICollectionView *collectionView;

@property (nonatomic, strong) UIView *lineView;
@property (nonatomic, strong) UIImageView *downImageView;


@end

@implementation TestSettingViewSingleButtonCell
- (instancetype)initWithFrame:(CGRect)frame
{
    if (self == [super initWithFrame:frame]) {
        [self setUpSubviews];
    }
    return self;
}

- (void)configureWithExpandModel:(ExpandButtonModels *)model {
    self.models = model;
    [self.collectionView reloadData];

}

- (void)setExpanded:(BOOL)expanded {
    self.lineView.hidden = !expanded;
    [UIView animateWithDuration:0.25 animations:^{
        self.downImageView.transform = expanded ? CGAffineTransformMakeRotation(M_PI) : CGAffineTransformIdentity;
    }];
}

- (void)setUpSubviews
{
    _settingScopeButton = [UIButton buttonWithType:UIButtonTypeCustom];
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
    _titleLabel.font = [UIFont poppinsFontOfSize:14.0 weight:UIFontWeightBold];
    [self.settingScopeButton addSubview:self.titleLabel];
    [self.titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(LearnMathScale(14.0));
        make.leading.mas_equalTo(LearnMathScale(16.0));
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
        make.top.equalTo(self.titleLabel.mas_bottom).offset(10);
        make.trailing.equalTo(self.settingScopeButton).offset(-LearnMathScale(16.0));
        make.leading.equalTo(self.settingScopeButton).offset(LearnMathScale(16.0));
        make.height.mas_equalTo(LearnMathScale(1.0));
    }];
    
    UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc] init];
    layout.minimumLineSpacing = LearnMathScale(13.0);
    layout.sectionInset = UIEdgeInsetsMake(LearnMathScale(12.0), 0.0 , LearnMathScale(20.0), 0.0 );
    
    _collectionView = [[UICollectionView alloc] initWithFrame:CGRectZero collectionViewLayout:layout];
    _lineView.hidden = YES;
    _collectionView.backgroundColor = [UIColor clearColor];
    _collectionView.dataSource = self;
    _collectionView.delegate = self;
    [self.settingScopeButton addSubview:self.collectionView];
    [self.collectionView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.lineView.mas_bottom).offset(LearnMathScale(12));
        make.bottom.leading.trailing.equalTo(self.settingScopeButton);
    }];
    
   
    
    [self.collectionView registerClass:[ExpandButtonViewCell class] forCellWithReuseIdentifier:@"Cell"];
    
    [self.collectionView registerClass:[ExpandButtonHeaderView class] forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"headerCell"];

    
}

#pragma mark - UICollectionViewDataSource
- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView
{
    if (self.buttonType == ExpandButtonTypeOperations) {
        return 1;
    } else {
        return self.models.title.count;
    }
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    if (self.buttonType == ExpandButtonTypeOperations) {
        return self.models.title.count;
    } else {
        return self.models.skill[section].count;
    }
}

- (__kindof UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    ExpandButtonViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"Cell" forIndexPath:indexPath];
    if (self.buttonType == ExpandButtonTypeOperations) {
        cell.titleLabel.text = self.models.title[indexPath.row];
        return cell;
    } else {
        cell.titleLabel.text = self.models.skill[indexPath.section][indexPath.row];
        return cell;
    }
}

- (UICollectionReusableView *)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath
{
    if ([kind isEqualToString:UICollectionElementKindSectionHeader]){
        if (self.buttonType == ExpandButtonTypeSkills) {
            ExpandButtonHeaderView *header = [collectionView dequeueReusableSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"headerCell" forIndexPath:indexPath];
            [header configureWithTitle:self.models.title[indexPath.section]];
            return  header;
        } else {
            return [UICollectionReusableView new];
        }
    } else {
        return [UICollectionReusableView new];
    }
}
#pragma mark - UICollectionViewDelegateFlowLayou
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{
    return CGSizeMake(self.settingScopeButton.bounds.size.width - LearnMathScale(16.0) * 2, LearnMathScale(18.0));
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout referenceSizeForHeaderInSection:(NSInteger)section
{
    if (self.buttonType == ExpandButtonTypeSkills) {
        return CGSizeMake(LearnMathScale(327), LearnMathScale(16.0));
    } else {
        return CGSizeZero;
    }
}
@end
