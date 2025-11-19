//
//  MathAnalyzeSuggestionCell.h
//  LearnMath
//
//  Created by 基 on 2025/11/19.
//

#import <UIKit/UIKit.h>
@import AppearanceKit;
@import Masonry;
@class MathAnalyzeSuggestionCell;
NS_ASSUME_NONNULL_BEGIN

@protocol MathAnalyzeSuggestionCellDelegate <NSObject>

- (void)mathAnalyzeSuggestionCell:(MathAnalyzeSuggestionCell *)cell didClickedBgButton:(ScaleableButton *)bgButton;
@end
@interface MathAnalyzeSuggestionCell : UICollectionViewCell
@property (nonatomic, weak) id<MathAnalyzeSuggestionCellDelegate> delegate;
@end

NS_ASSUME_NONNULL_END
