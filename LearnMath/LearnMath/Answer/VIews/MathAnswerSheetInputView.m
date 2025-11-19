//
//  MathAnswerSheetInputView.m
//  LearnMath
//
//  Created by 基 on 2025/10/20.
//

#import "MathAnswerSheetInputView.h"
#import "MathAnswerSheetInputItem.h"
#import "MathAnswerSheetViewController.h"
@interface MathAnswerSheetInputView () <UICollectionViewDataSource, UICollectionViewDelegateFlowLayout, MathAnswerSheetInputCellDelegate>

@property (nonatomic, strong) UICollectionView *collectionView;
@property (nonatomic, strong) NSMutableArray<MathAnswerSheetInputItem *> *items;

@property (nonatomic, assign) CGFloat cellHeight;
@property (nonatomic, assign) CGFloat topSpacing;
@property (nonatomic, assign) CGFloat cellSpacing;
@property (nonatomic, assign) CGFloat leftAndRightSpacing;
@property (nonatomic, assign) CGFloat cellWidth;

@end

@implementation MathAnswerSheetInputView
- (instancetype)initWithFrame:(CGRect)frame
{
    if (self == [super initWithFrame:frame]) {
        [self setUpUIConfig];
        [self setUpSubviews];
        [self generateItems];
    }
    return self;
}

- (void)setUpUIConfig {
    self.cellHeight = 54.0;
    self.topSpacing = 20.0;
    self.cellSpacing = 6.0;
    self.leftAndRightSpacing = 12.0;
    
    self.cellWidth = floor(([MathAnswerSheetViewController finalWidth] - self.leftAndRightSpacing * 2 - self.cellSpacing * 2) / 3.0);
}

- (void)setUpSubviews
{
    self.backgroundColor = [[UIColor whiteColor] colorWithAlphaComponent:0.3];
    
    UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc] init];
    
    self.collectionView = [[UICollectionView alloc] initWithFrame:CGRectZero collectionViewLayout:layout];
    self.collectionView.backgroundColor = [UIColor clearColor];
    [self addSubview:self.collectionView];
    [self.collectionView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self);
    }];
    
    self.collectionView.dataSource = self;
    self.collectionView.delegate = self;
    
    [self.collectionView registerClass:[MathAnswerSheetInputCell class] forCellWithReuseIdentifier:@"cell"];
}

- (void)generateItems
{
    self.items = [NSMutableArray array];
    
    for (NSInteger i = 0; i < 9; i++) {
        MathAnswerSheetInputItem *item = [[MathAnswerSheetInputItem alloc] initWithType:MathAnswerSheetInputTypeNumber number:[NSString stringWithFormat:@"%ld",i + 1 ]];
        [self.items addObject:item];
    }
    
    MathAnswerSheetInputItem *cleanItem = [[MathAnswerSheetInputItem alloc] initWithType:MathAnswerSheetInputTypeClean number:@"Clear"];
    [self.items addObject:cleanItem];
    
    MathAnswerSheetInputItem *zeroItem = [[MathAnswerSheetInputItem alloc] initWithType:MathAnswerSheetInputTypeNumber number:@"0"];
    [self.items addObject:zeroItem];
    
    MathAnswerSheetInputItem *checkItem = [[MathAnswerSheetInputItem alloc] initWithType:MathAnswerSheetInputTypeCheck number:@"Check"];
    [self.items addObject:checkItem];

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
    MathAnswerSheetInputCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"cell" forIndexPath:indexPath];
    [cell configureWithItem:self.items[indexPath.row]];
    cell.delegate = self;
    return cell;
}
#pragma mark - UICollectionViewDelegateFlowLayout
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{
    return CGSizeMake(self.cellWidth, self.cellHeight);
}

- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout minimumLineSpacingForSectionAtIndex:(NSInteger)section
{
    return self.cellSpacing;
}

- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout minimumInteritemSpacingForSectionAtIndex:(NSInteger)section
{
    return self.cellSpacing;
}

- (UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout insetForSectionAtIndex:(NSInteger)section
{
    return UIEdgeInsetsMake(self.topSpacing, self.leftAndRightSpacing, 0.0, self.leftAndRightSpacing);
}
#pragma mark - MathAnswerSheetInputCellDelegate

- (void)mathAnswerSheetInputCell:(MathAnswerSheetInputCell *)cell didClickedOperationButton:(ScaleableButton *)btn item:(MathAnswerSheetInputItem *)item {
    if ([self.delegate respondsToSelector:@selector(mathAnswerSheetInputView:didClickedOperationButton:item:)]) {
        [self.delegate mathAnswerSheetInputView:self didClickedOperationButton:btn item:item];
    }
}
@end
