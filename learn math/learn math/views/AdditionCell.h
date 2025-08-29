//
//  AdditionCell.h
//  learn math
//
//  Created by 基 on 2025/8/28.
//

#import <UIKit/UIKit.h>
@class AdditionModels;
NS_ASSUME_NONNULL_BEGIN

@interface AdditionCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UILabel *cellTitle;

@property (nonatomic,strong) AdditionModels *addition;
@end

NS_ASSUME_NONNULL_END
