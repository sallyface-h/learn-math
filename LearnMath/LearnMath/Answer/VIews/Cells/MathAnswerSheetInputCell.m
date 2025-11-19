//
//  MathAnswerSheetInputCell.m
//  LearnMath
//
//  Created by 基 on 2025/10/20.
//

#import "MathAnswerSheetInputCell.h"
#import "MathAnswerSheetInputCell.h"
#import "MathAnswerSheetInputItem.h"

@interface MathAnswerSheetInputCell ()
@property (nonatomic, strong)ScaleableButton *operationButton;
@property (nonatomic, strong) MathAnswerSheetInputItem *item;
@end

@implementation MathAnswerSheetInputCell
- (instancetype)initWithFrame:(CGRect)frame
{
    if (self == [super initWithFrame:frame]) {
        [self setUpSubviews];
    }
    return self;
}

- (void)setUpSubviews
{
    _operationButton = [ScaleableButton buttonWithType:UIButtonTypeCustom];
    _operationButton.layer.cornerRadius = 10.0;
    [self.contentView addSubview:self.operationButton];
    [self.operationButton addTarget:self action:@selector(operationButtonAction:) forControlEvents:UIControlEventTouchDown];
    [self.operationButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self.contentView);
    }];
}

- (void)configureWithItem:(MathAnswerSheetInputItem *)item {
    self.item = item;
    [self.operationButton setTitle:item.number forState:UIControlStateNormal];

    switch (item.type) {
        case MathAnswerSheetInputTypeNumber:
            [self.operationButton setTitleColor:[UIColor colorForSet:ColorSetSkillTitle] forState:UIControlStateNormal];
            self.operationButton.titleLabel.font = [UIFont ap_baloo:34 weight:UIFontWeightRegular];
            self.operationButton.backgroundColor = [UIColor colorForSet:ColorSetWhite];
            break;
        case MathAnswerSheetInputTypeClean:
            [self.operationButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
            self.operationButton.titleLabel.font = [UIFont ap_baloo:20 weight:UIFontWeightBold];
            self.operationButton.backgroundColor = [UIColor colorForSet:ColorSetPurple];
            break;
        case MathAnswerSheetInputTypeCheck:
            [self.operationButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
            _operationButton.titleLabel.font = [UIFont ap_baloo:20 weight:UIFontWeightBold];
            self.operationButton.backgroundColor = [UIColor colorForSet:ColorSetOrange];
            break;
        default:
            [self.operationButton setTitleColor:[UIColor colorForSet:ColorSetSkillTitle] forState:UIControlStateNormal];
            self.operationButton.titleLabel.font = [UIFont ap_baloo:34 weight:UIFontWeightRegular];
            self.operationButton.backgroundColor = [UIColor colorForSet:ColorSetWhite];
            break;
    }
}

- (void)operationButtonAction:(ScaleableButton *)sender {
    if ([self.delegate respondsToSelector:@selector(mathAnswerSheetInputCell:didClickedOperationButton:item:)]) {
        [self.delegate mathAnswerSheetInputCell:self didClickedOperationButton:sender item:self.item];
    }
}
@end
