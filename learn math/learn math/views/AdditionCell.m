//
//  AdditionCell.m
//  learn math
//
//  Created by 基 on 2025/8/28.
//

#import "AdditionCell.h"
#import "AdditionModels.h"
@implementation AdditionCell
- (void)setAddition:(AdditionModels *)addition{
    _addition = addition;
    self.cellTitle.text = addition.title;
    
}
- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
