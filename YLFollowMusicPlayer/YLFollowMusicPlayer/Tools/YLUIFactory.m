//
//  YLUIKit.m
//  YLUIFactory
//
//  Created by TK-001289 on 2016/11/24.
//  Copyright © 2016年 YL. All rights reserved.
//

#import "YLUIFactory.h"

@implementation YLUIFactory
#pragma mark---UILabel
+ (UILabel *)labelWithFontSize:(CGFloat)fontSize
                     textColor:(UIColor *)textColor
{
    return [self labelWithFontSize:fontSize
                         textColor:textColor
                         alignment:NSTextAlignmentLeft];
}

+ (UILabel *)labelWithFontSize:(CGFloat)fontSize
                     textColor:(UIColor *)textColor
                     alignment:(NSTextAlignment)alignment
{
    return [self labelWithFontSize:fontSize
                         textColor:textColor
                         alignment:alignment
                              text:nil];
}

+ (UILabel *)labelWithFontSize:(CGFloat)fontSize
                     textColor:(UIColor *)textColor
                     alignment:(NSTextAlignment)alignment
                        radius:(CGFloat)radius
{
    UILabel *lable = [self labelWithFontSize:fontSize
                                   textColor:textColor
                                   alignment:alignment];
    lable.layer.cornerRadius = radius;
    lable.layer.masksToBounds = YES;
    return lable;
}

+ (UILabel *)labelWithFontSize:(CGFloat)fontSize
                     textColor:(UIColor *)textColor
                     alignment:(NSTextAlignment)alignment
                        radius:(CGFloat)radius
                   borderColor:(UIColor *)bColor
                   borderWidth:(CGFloat)bWidth
{
    UILabel *lable = [self labelWithFontSize:fontSize
                                   textColor:textColor
                                   alignment:alignment
                                      radius:radius];
    lable.layer.borderColor = bColor.CGColor;
    lable.layer.borderWidth = bWidth;
    return lable;
}


+ (UILabel *)labelWithFontSize:(CGFloat)fontSize
                     textColor:(UIColor *)textColor
                     alignment:(NSTextAlignment)alignment
                         lines:(NSInteger)lines
{
    return [self labelWithFontSize:fontSize
                         textColor:textColor
                         alignment:alignment
                             lines:lines
                         breakMode:NSLineBreakByWordWrapping];
}

+ (UILabel *)labelWithFontSize:(CGFloat)fontSize
                     textColor:(UIColor *)textColor
                     alignment:(NSTextAlignment)alignment
                         lines:(NSInteger)lines
                     breakMode:(NSLineBreakMode)breakMode
{
    return [self labelWithFontSize:fontSize
                         textColor:textColor
                         alignment:alignment
                             lines:lines
                         breakMode:breakMode
                              text:nil];
}

+ (UILabel *)labelWithFontSize:(CGFloat)fontSize
                     textColor:(UIColor *)textColor
                          text:(NSString *)text
{
    return [self labelWithFontSize:fontSize
                         textColor:textColor
                         alignment:NSTextAlignmentLeft
                              text:text];
}

+ (UILabel *)labelWithFontSize:(CGFloat)fontSize
                     textColor:(UIColor *)textColor
                     alignment:(NSTextAlignment)alignment
                          text:(NSString *)text
{
    return [self labelWithFontSize:fontSize
                         textColor:textColor
                         alignment:alignment
                             lines:1
                         breakMode:-1
                              text:text];
}

+ (UILabel *)labelWithFontSize:(CGFloat)fontSize
                     textColor:(UIColor *)textColor
                     alignment:(NSTextAlignment)alignment
                         lines:(NSInteger)lines
                     breakMode:(NSLineBreakMode)breakMode
                          text:(NSString *)text
{
    UILabel *label = [[UILabel alloc]init];
    label.font = [UIFont systemFontOfSize:fontSize];
    label.textColor = textColor;
    label.textAlignment = alignment;
    label.numberOfLines = lines;
    if(breakMode >= 0){
        label.lineBreakMode = breakMode;
    }
    label.text = text;
    return label;
}

#pragma mark--UIButton
+ (UIButton *)btnWithFontSize:(CGFloat)fontSize
                  nTitleColor:(UIColor *)nTitleColor
                        title:(NSString *)title
{
    return [self btnWithFontSize:fontSize
                     nTitleColor:nTitleColor
                           title:title image:nil];
}

+ (UIButton *)btnWithFontSize:(CGFloat)fontSize
                  nTitleColor:(UIColor *)nTitleColor
                        title:(NSString *)title
                        image:(UIImage *)image
{
    return [self btnWithFontSize:fontSize
                     nTitleColor:nTitleColor
                     hTitleColor:nil
                           title:title
                           image:image
                       backImage:nil];
}

+ (UIButton *)btnWithFontSize:(CGFloat)fontSize
                     nTitleColor:(UIColor *)nTitleColor
                           title:(NSString *)title
                       backColor:(UIColor *)backColor
{
    return [self btnWithFontSize:fontSize
                     nTitleColor:nTitleColor
                     hTitleColor:nil
                     dTitleColor:nil
                           title:title
                           image:nil
                       backColor:backColor
                      nBackImage:nil
                      hBackImage:nil
                      dBackImage:nil];
}

+ (UIButton *)btnWithFontSize:(CGFloat)fontSize
                  nTitleColor:(UIColor *)nTitleColor
                  hTitleColor:(UIColor *)hTitleColor
                        title:(NSString *)title
                    backColor:(UIColor *)backColor
{
    return [self btnWithFontSize:fontSize
                     nTitleColor:nTitleColor
                     hTitleColor:hTitleColor
                     dTitleColor:nil
                           title:title
                           image:nil
                       backColor:backColor
                      nBackImage:nil
                      hBackImage:nil
                      dBackImage:nil];
}

+ (UIButton *)btnWithFontSize:(CGFloat)fontSize
                  nTitleColor:(UIColor *)nTitleColor
                  hTitleColor:(UIColor *)hTitleColor
                        title:(NSString *)title
                    backColor:(UIColor *)backColor
                       radius:(CGFloat)radius
{
    UIButton *button = [self btnWithFontSize:fontSize
                                 nTitleColor:nTitleColor
                                 hTitleColor:hTitleColor
                                       title:title
                                   backColor:backColor];
    button.layer.cornerRadius = radius;
    button.layer.masksToBounds = YES;
    return button;
}

+ (UIButton *)btnWithFontSize:(CGFloat)fontSize
                  nTitleColor:(UIColor *)nTitleColor
                  hTitleColor:(UIColor *)hTitleColor
                        title:(NSString *)title
                    backColor:(UIColor *)backColor
                       radius:(CGFloat)radius
                  borderColor:(UIColor *)bColor
                  borderWidth:(CGFloat)bWidth
{
    UIButton *button = [self btnWithFontSize:fontSize
                                 nTitleColor:nTitleColor
                                 hTitleColor:hTitleColor
                                       title:title
                                   backColor:backColor
                                      radius:radius];
    button.layer.borderColor = bColor.CGColor;
    button.layer.borderWidth = bWidth;
    return button;
}

+ (UIButton *)btnWithFontSize:(CGFloat)fontSize
                  nTitleColor:(UIColor *)nTitleColor
                  hTitleColor:(UIColor *)hTitleColor
                        title:(NSString *)title
                        image:(UIImage *)image
                    backImage:(UIImage *)backImage
{
    return [self btnWithFontSize:fontSize
                     nTitleColor:nTitleColor
                     hTitleColor:hTitleColor
                           title:title
                           image:image
                      nBackImage:backImage
                      hBackImage:nil];
}

+ (UIButton *)btnWithFontSize:(CGFloat)fontSize
                  nTitleColor:(UIColor *)nTitleColor
                  hTitleColor:(UIColor *)hTitleColor
                        title:(NSString *)title
                        image:(UIImage *)image
                   nBackImage:(UIImage *)nBackImage
                   hBackImage:(UIImage *)hBackImage
{
    return [self btnWithFontSize:fontSize
                     nTitleColor:nTitleColor
                     hTitleColor:hTitleColor
                     dTitleColor:nil
                           title:title
                           image:image
                       backColor:nil
                      nBackImage:nBackImage
                      hBackImage:hBackImage
                      dBackImage:nil];
}

+ (UIButton *)btnWithFontSize:(CGFloat)fontSize
                  nTitleColor:(UIColor *)nTitleColor
                  hTitleColor:(UIColor *)hTitleColor
                  dTitleColor:(UIColor *)dTitleColor
                        title:(NSString *)title
                        image:(UIImage *)image
                    backColor:(UIColor *)backColor
                   nBackImage:(UIImage *)nBackImage
                   hBackImage:(UIImage *)hBackImage
                   dBackImage:(UIImage *)dBackImage
{
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    button.titleLabel.font = [UIFont systemFontOfSize:fontSize];
    if(nTitleColor){
        [button setTitleColor:nTitleColor forState:UIControlStateNormal];
    }
    if(hTitleColor){
        [button setTitleColor:hTitleColor forState:UIControlStateHighlighted];
    }
    if(dTitleColor){
        [button setTitleColor:dTitleColor forState:UIControlStateDisabled];
    }
    [button setTitle:title forState:UIControlStateNormal];
    [button setImage:image forState:UIControlStateNormal];
    button.backgroundColor = backColor;
    if(nBackImage){
        [button setBackgroundImage:nBackImage forState:UIControlStateNormal];
    }
    if(hBackImage){
        [button setBackgroundImage:hBackImage forState:UIControlStateHighlighted];
    }
    if(dBackImage){
        [button setBackgroundImage:dBackImage forState:UIControlStateDisabled];
    }
    return button;
}

#pragma mark---UITextFiled

+ (UITextField *)textFieldWithFont:(CGFloat)fontSize
                       placeholder:(NSString *)holder
                         textColor:(UIColor *)textColor
                         tintColor:(UIColor *)tintColor
{
    return [self textFieldWithFont:fontSize
                       placeholder:holder
                         textColor:textColor
                         tintColor:tintColor
                         alignment:NSTextAlignmentLeft
                         clearMode:0
                     autoCrrection:0
                       autoCapital:0];
}

+ (UITextField *)textFieldWithFont:(CGFloat)fontSize
                       placeholder:(NSString *)holder
                         textColor:(UIColor *)textColor
                         tintColor:(UIColor *)tintColor
                         alignment:(NSTextAlignment)alignment
                         clearMode:(UITextFieldViewMode)clearMode
                     autoCrrection:(UITextAutocorrectionType)correctionType
                       autoCapital:(UITextAutocapitalizationType)capitalType
{
    UITextField *textFiled = [[UITextField alloc]init];
    textFiled.font = [UIFont systemFontOfSize:fontSize];
    textFiled.placeholder = holder;
    textFiled.textColor = textColor;
    textFiled.tintColor = tintColor;
    textFiled.textAlignment = alignment;
    textFiled.clearButtonMode = clearMode;
    textFiled.autocorrectionType = correctionType;
    textFiled.autocapitalizationType = capitalType;
    return textFiled;
}

#pragma mark---UIImageView

+ (UIImageView *)imageViewWithImageName:(NSString *)name
                                  frame:(CGRect)frame
{
    UIImageView *imageView = [self imageViewWithRadius:0];
    imageView.image = [UIImage imageNamed:name];
    imageView.frame = frame;
    return imageView;
}

+ (UIImageView *)imageViewWithRadius:(CGFloat)radius
{
    return [self imageViewWithRadius:radius
                         borderWidth:0
                         borderColor:nil];
}

+ (UIImageView *)imageViewWithRadius:(CGFloat)radius
                         borderWidth:(CGFloat)bWidth
                         borderColor:(UIColor *)bColor
{
    UIImageView *imageView = [[UIImageView alloc]init];
    imageView.layer.cornerRadius = radius;
    imageView.layer.masksToBounds = YES;
    imageView.layer.borderWidth = bWidth;
    imageView.layer.borderColor = bColor.CGColor;
    return imageView;
}

#pragma mark---UITableView
+ (UITableView *)tableWithFrame:(CGRect)frame
                          style:(UITableViewStyle)style
                      cellClass:(NSArray *)className
                       delegate:(id <UITableViewDelegate>)delegate
                     dataSource:(id <UITableViewDataSource>)dataSource
{
    return [self tableWithFrame:frame
                          style:style
                      backColor:nil
                 separatorColor:nil
                      cellClass:className
                       delegate:delegate
                     dataSource:dataSource];
}

+ (UITableView *)tableWithFrame:(CGRect)frame
                          style:(UITableViewStyle)style
                      backColor:(UIColor *)backColor
                 separatorColor:(UIColor *)separatorColor
                      cellClass:(NSArray *)className
                       delegate:(id <UITableViewDelegate>)delegate
                     dataSource:(id <UITableViewDataSource>)dataSource
{
    UITableView *table = [[UITableView alloc]initWithFrame:frame style:style];
    if(backColor){
        table.backgroundColor = backColor;
    }
    if(separatorColor){
        table.separatorColor = separatorColor;
    }
    if([className isKindOfClass:[NSArray class]] && className.count > 0){
        for(NSString *classStr in className){
            if([classStr isKindOfClass:[NSString class]] && classStr != nil){
                [table registerClass:NSClassFromString(classStr) forCellReuseIdentifier:classStr];
            }
        }
    }
    table.delegate = delegate;
    table.dataSource = dataSource;
    return table;
}
@end
