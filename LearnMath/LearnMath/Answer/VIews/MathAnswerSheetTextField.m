//
//  MathAnswerSheetTextField.m
//  LearnMath
//
//  Created by 基 on 2025/10/20.
//

#import "MathAnswerSheetTextField.h"
@interface MathAnswerSheetTextField ()
@property (nonatomic, assign) UIEdgeInsets padding;
@property (nonatomic, strong) UIColor *bgColor;
@property (nonatomic, assign) CGFloat caretHeight;
@end

@implementation MathAnswerSheetTextField

- (instancetype)initWithPadding:(UIEdgeInsets)padding bgColor:(UIColor *)bgColor
{
    if (self == [super initWithFrame:CGRectZero]) {
        _padding = padding;
        _bgColor = bgColor;
        _caretHeight = LearnMathScale(20.0);
        
        self.textAlignment = NSTextAlignmentCenter;
        self.textColor = [UIColor colorForSet:ColorSetSkillTitle];
        self.font = [UIFont ap_baloo:35.0 weight:UIFontWeightRegular];
        self.tintColor = [UIColor clearColor];
        //告诉系统：这个输入框 没有特定的内容类型。
        self.textContentType = nil;
        //关闭 自动拼写纠正（Auto-Correction） 功能。
        self.autocorrectionType = UITextAutocorrectionTypeNo;
        //禁用 自动首字母大写 功能。
        self.autocapitalizationType = UITextAutocapitalizationTypeNone;
        //禁止系统弹出键盘。
        self.inputView = [[UIView alloc] initWithFrame:CGRectZero];
        //不显示输入法上方工具栏。
        self.inputAccessoryView = [[UIView alloc] initWithFrame:CGRectZero];
        //去掉 iOS 键盘自带的“剪贴板 / 自动填充”小条。
        UITextInputAssistantItem *item = self.inputAssistantItem;
        item.leadingBarButtonGroups = @[];
        item.trailingBarButtonGroups = @[];
        
        self.layer.borderColor = [UIColor colorForSet:ColorSetSkillTitle].CGColor;
        self.layer.borderWidth = LearnMathScale(5.5);
        self.layer.cornerRadius = LearnMathScale(9.2);
    }
    return self;
}

- (BOOL)becomeFirstResponder
{
    self.textColor = self.bgColor;
    self.layer.borderColor = self.bgColor.CGColor;
    return [super becomeFirstResponder];
}

- (BOOL)resignFirstResponder
{
    self.textColor = [UIColor colorForSet:ColorSetSkillTitle];
    self.layer.borderColor = [UIColor colorForSet:ColorSetSkillTitle].CGColor;
    return [super resignFirstResponder];
}
//已经编辑完成的文字
- (CGRect)textRectForBounds:(CGRect)bounds {
    return UIEdgeInsetsInsetRect(bounds, self.padding);
}
//提示文字
- (CGRect)placeholderRectForBounds:(CGRect)bounds {
    return UIEdgeInsetsInsetRect(bounds, self.padding);
}
//正在编辑的文字
- (CGRect)editingRectForBounds:(CGRect)bounds {
    return UIEdgeInsetsInsetRect(bounds, self.padding);
}

//右视图左移
- (CGRect)rightViewRectForBounds:(CGRect)bounds
{
    CGRect rect = [super rightViewRectForBounds:bounds];
    rect.origin.x -= self.padding.right;
    return rect;
}
//左视图右移
- (CGRect)leftViewRectForBounds:(CGRect)bounds {
    CGRect rect = [super leftViewRectForBounds:bounds];
    rect.origin.x += self.padding.left;
    return rect;
}
//隐藏文本框光标
- (CGRect)caretRectForPosition:(UITextPosition *)position {
    return CGRectZero;
}
//禁止复制粘贴
- (BOOL)canPerformAction:(SEL)action withSender:(id)sender
{
    if (action == @selector(paste:) ||
        action == @selector(copy:) ||
        action == @selector(select:) ||
        action == @selector(selectAll:)) {
        return NO;
    }
    return [super canPerformAction:action withSender:sender];
}
@end
