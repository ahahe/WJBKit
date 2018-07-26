//
//  NSMutableAttributedString+Chain.m
//
//  Created by 韦家冰 on 2017/3/3.
//

#import "NSMutableAttributedString+Chain.h"
#import <objc/runtime.h>

@interface NSMutableAttributedString ()
@property(nonatomic, assign) NSRange changeRange;
@end

@implementation NSMutableAttributedString (Chain)

/**
 单独设置一些文字
 @param subStrings 字符数组
 @param block   里面用make.各种想要的设置
 */
- (void)ps_changeSubStrings:(NSArray *)subStrings makeCalculators:(void (^)(NSMutableAttributedString * make))block{
    
    for (NSString *rangeStr in subStrings) {
        
        NSMutableArray *array = [self ps_getRangeWithTotalString:self.string SubString:rangeStr];
        for (NSNumber *rangeNum in array) {
            //设置修改range
            self.changeRange = [rangeNum rangeValue];
            //block 链式调用
            block(self);
        }
    }
    //设置为空
    self.changeRange = NSMakeRange(0, 0);
}

/**
 多个AttributedString连接
 */
- (void)ps_appendAttributedStrings:(NSArray *)attrStrings{
    
    for (NSAttributedString *att in attrStrings) {
        [self appendAttributedString:att];
    }
}

/**
 多个AttributedString连接
 */
+ (NSMutableAttributedString *)ps_appendAttributedStrings:(NSArray *)attrStrings{
    
    NSMutableAttributedString *att = [NSMutableAttributedString new];
    [att ps_appendAttributedStrings:attrStrings];
    return att;
}

#pragma mark - Private Methods
/**
 *  获取某个字符串中子字符串的位置数组
 *  @param totalString 总的字符串
 *  @param subString   子字符串
 *  @return 位置数组
 */
- (NSMutableArray *)ps_getRangeWithTotalString:(NSString *)totalString SubString:(NSString *)subString {
    
    if (subString == nil && [subString isEqualToString:@""]) {
        return nil;
    }
    // rangeOfString 查找
    
    NSMutableArray *arrayRanges = [NSMutableArray array];
    NSRange searchRange = NSMakeRange(0, totalString.length);
    NSRange range;
    while ((range = [totalString rangeOfString:subString options:0 range:searchRange]).location != NSNotFound) {
        [arrayRanges addObject:[NSNumber valueWithRange:range]];
        searchRange = NSMakeRange(NSMaxRange(range), totalString.length - NSMaxRange(range));
    }
    return arrayRanges;
    
}

- (void)ps_addAttribute:(NSString *)name value:(id)value{
    
    NSRange range = [self range];
    if (range.length>0) {
        [self addAttribute:name value:value range:range];
    }else{
        NSLog(@"AttributedString的string为空，注意!!!");
    }
}

//获取有效的range
- (NSRange)range{
    
    NSRange range = NSMakeRange(0, 0);
    NSString *string = self.string;
    if (string && string.length > 0) {
        
        if (self.changeRange.length >0 && NSMaxRange(self.changeRange) <= string.length) {
            //如果是需要修改的字符，就使用changeRange
            range = self.changeRange;
        }else{
            //设置全部字符串
            range = NSMakeRange(0, string.length);
        }
    }
    return range;
}

- (NSMutableParagraphStyle *)ps_paragraphStyle{
    
    NSRange range = [self range];
    if (range.length > 0) {
        
        NSDictionary *dic = [self attributesAtIndex:0 effectiveRange:&range];
        NSMutableParagraphStyle *paragraphStyle = dic[@"NSParagraphStyle"];
        
        //如果字符串里面没有paragraphStyle，new一个新的
        if (!paragraphStyle) {
            paragraphStyle = [[NSMutableParagraphStyle alloc]init];
        }
        return paragraphStyle;
    }else{
        NSLog(@"AttributedString的string为空，注意!!!");
        return nil;
    }
}

#pragma mark -ChangeRange的get、set

-(void)setChangeRange:(NSRange)changeRange{
    objc_setAssociatedObject(self, @selector(changeRange), [NSNumber valueWithRange:changeRange], OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

-(NSRange)changeRange{
    
    NSNumber *rangeNum = objc_getAssociatedObject(self, @selector(changeRange));
    NSRange range = [rangeNum rangeValue];
    return range;
}

#pragma mark - 设置各种配置参数
#pragma mark - 文字颜色
- (void)ps_setForegroundColor:(UIColor *)obj{
    [self ps_addAttribute:NSForegroundColorAttributeName value:obj];
}

#pragma mark - 文字背景颜色
- (void)ps_setBackgroundColor:(UIColor *)obj{
    
    [self ps_addAttribute:NSBackgroundColorAttributeName value:obj];
}


#pragma mark - 字体
- (void)ps_setFont:(UIFont *)obj{
    
    [self ps_addAttribute:NSFontAttributeName value:obj];
}

#pragma mark - 偏移量
- (void)ps_setBaselineOffset:(CGFloat)obj{
    
    [self ps_addAttribute:NSBaselineOffsetAttributeName value:@(obj)];
}


#pragma mark - ps_ligature(连体符)设置连体属性，0 表示没有连体字符，1 表示使用默认的连体字符
- (void)ps_setLigature:(NSInteger)obj{
    
    [self ps_addAttribute:NSLigatureAttributeName value:@(obj)];
}


#pragma mark - ps_kern(字间距)，取值为 NSNumber 对象（整数），正值间距加宽，负值间距变窄
- (void)ps_setKern:(NSInteger)obj{
    [self ps_addAttribute:NSKernAttributeName value:@(obj)];
}


#pragma mark - ps_strikethrough(删除线)，NSUnderlineStyle
- (void)ps_setStrikethroughStyle:(NSUnderlineStyle)obj {
    [self ps_addAttribute:NSStrikethroughStyleAttributeName value:@(obj)];
}


#pragma mark - 设置删除线颜色，取值为 UIColor 对象，默认值为黑色
- (void)ps_setStrikethroughColor:(UIColor *)obj {
    [self ps_addAttribute:NSStrikethroughColorAttributeName value:obj];
}


#pragma mark - 设置下划线，取值为 NSNumber 对象（整数），枚举常量 NSUnderlineStyle中的值，与删除线类似
- (void)ps_setUnderlineStyle:(NSUnderlineStyle)underlineStyle{
    [self ps_addAttribute:NSUnderlineStyleAttributeName value:@(underlineStyle)];
}

#pragma mark - 设置下划线颜色，取值为 UIColor 对象，默认值为黑色
- (void)ps_setUnderlineColor:(UIColor *)obj{
    [self ps_addAttribute:NSUnderlineColorAttributeName value:obj];
}


#pragma mark - 设置笔画宽度，取值为 NSNumber 对象（整数），负值填充效果，正值中空效果
- (void)ps_setStrokeWidth:(NSInteger)obj{
    [self ps_addAttribute:NSStrokeWidthAttributeName value:@(obj)];
}

#pragma mark - 填充部分颜色，不是字体颜色，取值为 UIColor 对象
- (void)ps_setStrokeColor:(UIColor *)obj{
    [self ps_addAttribute:NSStrokeColorAttributeName value:obj];
}


#pragma mark - 设置阴影属性，取值为 NSShadow 对象
- (void)ps_setShadow:(NSShadow *)obj{
    [self ps_addAttribute:NSShadowAttributeName value:obj];
}


#pragma mark - 设置文本特殊效果，取值为 NSString 对象，目前只有图版印刷效果可用：
- (void)ps_setTextEffect:(NSString *)obj{
    [self ps_addAttribute:NSTextEffectAttributeName value:obj];
}


#pragma mark - 设置字形倾斜度，取值为 NSNumber （float）,正值右倾，负值左倾
- (void)ps_setObliqueness:(CGFloat)obj{
    [self ps_addAttribute:NSObliquenessAttributeName value:@(obj)];
}


#pragma mark - 设置文本横向拉伸属性，取值为 NSNumber （float）,正值横向拉伸文本，负值横向压缩文本
- (void)ps_setExpansion:(CGFloat)obj{
    [self ps_addAttribute:NSExpansionAttributeName value:@(obj)];
}

#pragma mark - 设置文字书写方向NSWritingDirection
- (void)ps_setWritingDirection:(NSWritingDirection)obj{
    [self ps_addAttribute:NSWritingDirectionAttributeName value:@(obj)];
}


#pragma mark - 设置文字排版方向，取值为 NSNumber 对象(整数)，0 表示横排文本，1 表示竖排文本
- (void)ps_setVerticalGlyph:(NSInteger)obj{
    [self ps_addAttribute:NSVerticalGlyphFormAttributeName value:@(obj)];
}

#pragma mark - 设置链接属性，点击后调用打开指定URL地址
- (void)ps_setLink:(NSURL *)obj{
    [self ps_addAttribute:NSLinkAttributeName value:obj];
}

//NSAttachmentAttributeName 设置文本附件,取值为NSTextAttachment对象,常用于文字图片混排
/*
 NSTextAttachment *textAttachment01 = [[NSTextAttachment alloc] init];
 textAttachment01.image = [UIImage imageNamed: @"10000.jpeg"];  //设置图片源
 textAttachment01.bounds = CGRectMake(0, 0, 30, 30);          //设置图片位置和大小
 NSMutableAttributedString *attrStr01 = [[NSMutableAttributedString alloc] initWithString: originStr];
 [attrStr01 addAttribute: NSFontAttributeName value: [UIFont systemFontOfSize: 25] range: NSMakeRange(0, originStr.length)];
 NSAttributedString *attrStr11 = [NSAttributedString attributedStringWithAttachment: textAttachment01];
 [attrStr01 insertAttributedString: attrStr11 atIndex: 2];  //NSTextAttachment占用一个字符长度，插入后原字符串长度增加1
 _label01.attributedText = attrStr01;
 */

#pragma mark - 设置文本段落排版格式NSParagraphStyleAttributeName 
#pragma mark - 对齐
- (void)ps_setAlignment:(NSTextAlignment)obj{
    
    NSMutableParagraphStyle *style = [self ps_paragraphStyle];
    style.alignment = obj;
    [self ps_addAttribute:NSParagraphStyleAttributeName value:style];
}



#pragma mark - 行间距
- (void)ps_setLineSpacing:(CGFloat)obj{
    
    NSMutableParagraphStyle *style = [self ps_paragraphStyle];
    style.lineSpacing = obj;
    [self ps_addAttribute:NSParagraphStyleAttributeName value:style];
}

#pragma mark - 段间距
- (void)ps_setParagraphSpacing:(CGFloat)obj{
    
    NSMutableParagraphStyle *style = [self ps_paragraphStyle];
    style.paragraphSpacing = obj;
    [self ps_addAttribute:NSParagraphStyleAttributeName value:style];
}

#pragma mark - 首行缩进
- (void)ps_setFirstLineHeadIndent:(CGFloat)obj{
    
    NSMutableParagraphStyle *style = [self ps_paragraphStyle];
    style.firstLineHeadIndent = obj;
    [self ps_addAttribute:NSParagraphStyleAttributeName value:style];
}


#pragma mark - 缩进
- (void)ps_setHeadIndent:(CGFloat)obj{
    
    NSMutableParagraphStyle *style = [self ps_paragraphStyle];
    style.headIndent = obj;
    [self ps_addAttribute:NSParagraphStyleAttributeName value:style];
}

#pragma mark - 尾部缩进
- (void)ps_setTailIndent:(CGFloat)obj{
    
    NSMutableParagraphStyle *style = [self ps_paragraphStyle];
    style.tailIndent = obj;
    [self ps_addAttribute:NSParagraphStyleAttributeName value:style];
}

#pragma mark - 断行方式
- (void)ps_setLineBreakMode:(NSLineBreakMode)obj{
    
    NSMutableParagraphStyle *style = [self ps_paragraphStyle];
    style.lineBreakMode = obj;
    [self ps_addAttribute:NSParagraphStyleAttributeName value:style];
}

#pragma mark - 最大行高
- (void)ps_setMaximumLineHeight:(CGFloat)obj{
    
    NSMutableParagraphStyle *style = [self ps_paragraphStyle];
    style.maximumLineHeight = obj;
    [self ps_addAttribute:NSParagraphStyleAttributeName value:style];
}



#pragma mark - 最低行高
- (void)ps_setMinimumLineHeight:(CGFloat)obj{
    
    NSMutableParagraphStyle *style = [self ps_paragraphStyle];
    style.minimumLineHeight = obj;
    [self ps_addAttribute:NSParagraphStyleAttributeName value:style];
}

#pragma mark - 句子方向
- (void)ps_setBaseWritingDirection:(NSWritingDirection)obj{
    
    NSMutableParagraphStyle *style = [self ps_paragraphStyle];
    style.baseWritingDirection = obj;
    [self ps_addAttribute:NSParagraphStyleAttributeName value:style];
}

#pragma mark - 可变行高,乘因数
- (void)ps_setLineHeightMultiple:(CGFloat)obj{
    
    NSMutableParagraphStyle *style = [self ps_paragraphStyle];
    style.lineHeightMultiple = obj;
    [self ps_addAttribute:NSParagraphStyleAttributeName value:style];
}

#pragma mark - 连字符属性
- (void)ps_setHyphenationFactor:(CGFloat)obj{
    
    NSMutableParagraphStyle *style = [self ps_paragraphStyle];
    style.hyphenationFactor = obj;
    [self ps_addAttribute:NSParagraphStyleAttributeName value:style];
}


@end
