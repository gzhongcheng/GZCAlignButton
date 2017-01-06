//
//  GZCAlignButton.h
//  MemberSystem
//
//  Created by GuoZhongCheng on 16/6/22.
//  Copyright © 2016年 郭忠橙. All rights reserved.
//  图文混排的按钮，可定义图片与文字的排列方式，

#import <UIKit/UIKit.h>

//角标样式
typedef NS_ENUM(NSInteger, GZCAlignButtonBadgeStyle) {
    GZCAlignButtonBadgeStylePoint  = 0 ,    // 圆点
    GZCAlignButtonBadgeStyleString = 1 ,    // 字符串气泡
    GZCAlignButtonBadgeStyleRibbon = 2      // 右侧彩带
};

//图文混排的样式（图片相对文字的位置）
typedef NS_ENUM(NSInteger, GZCAlignButtonAlignment) {
    GZCAlignButtonAlignmentLeft  = 0 ,  // 图片在文字左侧
    GZCAlignButtonAlignmentRight = 1 ,  // 图片在文字右侧
    GZCAlignButtonAlignmentTop = 2 ,    // 图片在文字上方
    GZCAlignButtonAlignmentBottom = 3 , // 图片在文字下方
    GZCAlignButtonAlignmentBelow = 4    // 图片在文字底下（文字盖在图片上）
    
};

IB_DESIGNABLE

@interface GZCAlignButton : UIControl

@property (nonatomic,assign) IBInspectable CGFloat cornerRadius;   //圆角
@property (nonatomic,assign) IBInspectable CGFloat borderWidth;   //边框
@property (nonatomic,copy) IBInspectable UIColor * borderColor;   //边框颜色

@property (nonatomic,strong) UIImageView * imageView;      //图片
@property (nonatomic,strong) UILabel * titleLabel;      //标题
@property (nonatomic,strong) UILabel * badgeLabel;      //角标

@property (nonatomic,copy) IBInspectable NSString * title;  //标题
@property (nonatomic,copy) IBInspectable UIColor * titleColor;  //标题颜色
@property (nonatomic,copy) UIFont * titleFont;  //标题字体（由于IB不支持 所以只能代码设置了）
@property (nonatomic,assign) IBInspectable CGFloat titleFontSize;  //标题字号（主要是给IB用的）

@property (nonatomic,copy) IBInspectable UIImage * image;  //图片
@property (nonatomic,copy) IBInspectable UIColor * imageBackground;  //图片背景色
@property (nonatomic,assign) IBInspectable CGSize imageSize;  //图片大小
@property (nonatomic,assign) IBInspectable NSInteger imageRadius;  //图片的圆角
@property (nonatomic,copy) UIColor *imageTintColor;         //改变图片颜色

#if TARGET_INTERFACE_BUILDER
/**
 *  图片的填充模式
 *  枚举类型为UIViewContentMode
 **/
@property (nonatomic,assign) IBInspectable NSInteger imageContentMode;
/**
 *  排列方式
 *  枚举类型为GZCAlignButtonAlignment
 **/
@property (nonatomic,assign) IBInspectable NSInteger textAligment;
/**
 *  角标样式
 *  枚举类型为GZCAlignButtonBadgeStyle
 **/
@property (nonatomic,assign) IBInspectable NSInteger badgeStyle;
#else
@property (nonatomic,assign) UIViewContentMode imageContentMode;
@property (nonatomic,assign) GZCAlignButtonAlignment textAligment;
@property (nonatomic,assign) GZCAlignButtonBadgeStyle badgeStyle;
#endif


@property (nonatomic,assign) IBInspectable CGFloat alignPadding;  //图片与文字的间距,GZCAlignButtonAlignmentBelow时无效
@property (nonatomic,copy) IBInspectable UIColor * shadowColor;  //文字底色,GZCAlignButtonAlignmentBelow才有用

@property (nonatomic,copy) IBInspectable NSString * badge;//角标文字（如果为nil或者空字符串，则隐藏角标）
@property (nonatomic,assign) IBInspectable NSInteger badgeFontSize;  //角标字体大小
@property (nonatomic,assign) IBInspectable CGFloat badgeRadius;     //角标的圆角
@property (nonatomic,copy) IBInspectable UIColor * badgeBackgroundColor;              //角标背景颜色


- (void)reloadView;

@end
