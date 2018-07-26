//
//  NSMutableAttributedString+Chain.h
//
//  Created by 韦家冰 on 2017/3/3.


/*使用例子
 
 NSString *text= @"说明:\n1、个人业绩为实时统计；\n2、奖励显示为T+1(当日办理隔日显示)；\n3、无邀请码的订单不在个人业绩统计范畴；\n4、如对奖金有疑问，请向上级反馈处理。";
 
 NSMutableAttributedString *att=[[NSMutableAttributedString alloc]initWithString:text];
 //设置字体、颜色、行间距
 [att ps_setFont:[UIFont systemFontOfSize:14.0]];
 [att ps_setForegroundColor:k_Color_9B9B9B];
 [att ps_setLineSpacing:2];
 
 //把全部“为”字变成红色、字间距为10
 [att ps_changeSubStrings:@[@"为"] makeCalculators:^(NSMutableAttributedString *make) {
        [make ps_setForegroundColor:k_Color_9B9B9B];
        [make ps_setLineSpacing:10];
 }];
 
 //把全部“@"个人",@"绩"变成绿色、字号19、设置笔画宽度（中空效果）
 [att ps_changeSubStrings:@[@"个人",@"绩"] makeCalculators:^(NSMutableAttributedString *make) {
        [make ps_setForegroundColor:[UIColor greenColor]];
        [make ps_setFont:[UIFont systemFontOfSize:19]];
        [make ps_setStrokeWidth:4];
 }];
 
 */


#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>


@interface NSMutableAttributedString (Chain)

/**
 单独设置一些文字
 @param subStrings 字符数组
 @param block   里面用make.各种想要的设置
 */
- (void)ps_changeSubStrings:(NSArray *)subStrings makeCalculators:(void (^)(NSMutableAttributedString * make))block;


/**
 多个AttributedString连接
 */
- (void)ps_appendAttributedStrings:(NSArray *)attrStrings;
/**
 多个AttributedString连接
 */
+ (NSMutableAttributedString *)ps_appendAttributedStrings:(NSArray *)attrStrings;

#pragma mark -基本设置
// NSFontAttributeName                  设置字体属性，默认值：字体：Helvetica(Neue) 字号：12
// NSForegroundColorAttributeNam        设置字体颜色，取值为 UIColor对象，默认值为黑色
// NSBackgroundColorAttributeName       设置字体所在区域背景颜色，取值为 UIColor对象，默认值为nil, 透明色
// NSLigatureAttributeName              设置连体属性，取值为NSNumber 对象(整数)，0 表示没有连体字符，1 表示使用默认的连体字符
// NSKernAttributeName                  设定字符间距，取值为 NSNumber 对象（整数），正值间距加宽，负值间距变窄
// NSStrikethroughStyleAttributeName    设置删除线，取值为 NSNumber 对象（整数）
// NSStrikethroughColorAttributeName    设置删除线颜色，取值为 UIColor 对象，默认值为黑色
// NSUnderlineStyleAttributeName        设置下划线，取值为 NSNumber 对象（整数），枚举常量 NSUnderlineStyle中的值，与删除线类似
// NSUnderlineColorAttributeName        设置下划线颜色，取值为 UIColor 对象，默认值为黑色
// NSStrokeWidthAttributeName           设置笔画宽度，取值为 NSNumber 对象（整数），负值填充效果，正值中空效果
// NSStrokeColorAttributeName           填充部分颜色，不是字体颜色，取值为 UIColor 对象
// NSShadowAttributeName                设置阴影属性，取值为 NSShadow 对象
// NSTextEffectAttributeName            设置文本特殊效果，取值为 NSString 对象，目前只有图版印刷效果可用：
// NSBaselineOffsetAttributeName        设置基线偏移值，取值为 NSNumber （float）,正值上偏，负值下偏
// NSObliquenessAttributeName           设置字形倾斜度，取值为 NSNumber （float）,正值右倾，负值左倾
// NSExpansionAttributeName             设置文本横向拉伸属性，取值为 NSNumber （float）,正值横向拉伸文本，负值横向压缩文本
// NSWritingDirectionAttributeName      设置文字书写方向，从左向右书写或者从右向左书写
// NSVerticalGlyphFormAttributeName     设置文字排版方向，取值为 NSNumber 对象(整数)，0 表示横排文本，1 表示竖排文本
// NSLinkAttributeName                  设置链接属性，点击后调用打开指定URL地址
// NSAttachmentAttributeName            设置文本附件,取值为NSTextAttachment对象,常用于文字图片混排

/**
 (文字颜色)
 */
- (void)ps_setForegroundColor:(UIColor *)foregroundColor;


/**
 (背景颜色)
 */
- (void)ps_setBackgroundColor:(UIColor *)backgroundColor;

/**
 (字体)
 */
- (void)ps_setFont:(UIFont *)obj;

/**
 (偏移量) 正值上偏，负值下偏
 */
- (void)ps_setBaselineOffset:(CGFloat)obj;

/**
 设置连体属性，0 表示没有连体字符，1 表示使用默认的连体字符
 */
- (void)ps_setLigature:(NSInteger)obj;

/**
 (字间距)，取值为 NSNumber 对象（整数），正值间距加宽，负值间距变窄
 */
- (void)ps_setKern:(NSInteger)obj;

/**
 (删除线)，取值为 NSNumber 对象（整数）
 */
- (void)ps_setStrikethroughStyle:(NSUnderlineStyle)obj;

/**
 设置删除线颜色，取值为 UIColor 对象，默认值为黑色
 */
- (void)ps_setStrikethroughColor:(UIColor *)obj;


/**
 设置下划线，取值为 NSNumber 对象（整数），枚举常量 NSUnderlineStyle中的值，与删除线类似
 */
- (void)ps_setUnderlineStyle:(NSUnderlineStyle)underlineStyle;


/**
 设置下划线颜色，取值为 UIColor 对象，默认值为黑色
 */
- (void)ps_setUnderlineColor:(UIColor *)obj;


/**
 设置笔画宽度，取值为 NSNumber 对象（整数），负值填充效果，正值中空效果
 */
- (void)ps_setStrokeWidth:(NSInteger)obj;


/**
 填充部分颜色，不是字体颜色，取值为 UIColor 对象
 */
- (void)ps_setStrokeColor:(UIColor *)obj;


/**
 设置阴影属性，取值为 NSShadow 对象
 */
- (void)ps_setShadow:(NSShadow *)obj;


/**
 设置文本特殊效果，取值为 NSString 对象，目前只有图版印刷效果可用：
 */
- (void)ps_setTextEffect:(NSString *)obj;


/**
 设置字形倾斜度，取值为 NSNumber （float）,正值右倾，负值左倾
 */
- (void)ps_setObliqueness:(CGFloat)obj;


/**
 设置文本横向拉伸属性，取值为 NSNumber （float）,正值横向拉伸文本，负值横向压缩文本
 */
- (void)ps_setExpansion:(CGFloat)obj;


/**
 设置文字书写方向NSWritingDirection
 */
- (void)ps_setWritingDirection:(NSWritingDirection)obj;


/**
 设置文字排版方向，取值为 NSNumber 对象(整数)，0 表示横排文本，1 表示竖排文本
 */
- (void)ps_setVerticalGlyph:(NSInteger)obj;


/**
 设置链接属性，点击后调用打开指定URL地址
 */
- (void)ps_setLink:(NSURL *)obj;


#pragma mark -NSParagraphStyleAttributeName 设置文本段落排版格式
//alignment                 //对齐方式
//lineSpacing               //行距
//paragraphSpacing          //段距
//firstLineHeadIndent       //首行缩进
//headIndent                //缩进
//tailIndent                //尾部缩进
//lineBreakMode             //断行方式
//maximumLineHeight         //最大行高
//minimumLineHeight         //最低行高
//paragraphSpacingBefore    //段首空间
//baseWritingDirection      //句子方向
//lineHeightMultiple        //可变行高,乘因数。
//hyphenationFactor         //连字符属性

/**
 (对齐)
 */
- (void)ps_setAlignment:(NSTextAlignment)obj;


/**
 (调整行间距)
 */
- (void)ps_setLineSpacing:(CGFloat)obj;


/**
 (调整段间距)
 */
- (void)ps_setParagraphSpacing:(CGFloat)obj;


/**
 首行缩进
 */
- (void)ps_setFirstLineHeadIndent:(CGFloat)obj;


/**
 缩进
 */
- (void)ps_setHeadIndent:(CGFloat)obj;

/**
 尾部缩进
 */
- (void)ps_setTailIndent:(CGFloat)obj;


/**
 断行方式
 */
- (void)ps_setLineBreakMode:(NSLineBreakMode)obj;

/**
 最大行高
 */
- (void)ps_setMaximumLineHeight:(CGFloat)obj;

/**
 最低行高
 */
- (void)ps_setMinimumLineHeight:(CGFloat)obj;

/**
 句子方向
 */
- (void)ps_setBaseWritingDirection:(NSWritingDirection)obj;

/**
 可变行高,乘因数。
 */
- (void)ps_setLineHeightMultiple:(CGFloat)obj;

/**
 连字符属性。
 */
- (void)ps_setHyphenationFactor:(CGFloat)obj;

@end
