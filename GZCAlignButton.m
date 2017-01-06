//
//  GZCAlignButton.m
//  MemberSystem
//
//  Created by GuoZhongCheng on 16/6/22.
//  Copyright © 2016年 郭忠橙. All rights reserved.
//

#import "GZCAlignButton.h"
#import "UIImage+RenderedImage.h"

@implementation GZCAlignButton

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self getImageView];
        [self getTitleLabel];
        [self getBadgeLabel];
        _textAligment = GZCAlignButtonAlignmentLeft;
        _badgeStyle = GZCAlignButtonBadgeStylePoint;
        self.title = @"";
        self.badge = nil;
        self.imageSize = CGSizeZero;
        self.clipsToBounds = YES;
    }
    return self;
}

- (instancetype)initWithCoder:(NSCoder *)coder
{
    self = [super initWithCoder:coder];
    if (self) {
        [self getImageView];
        [self getTitleLabel];
        [self getBadgeLabel];
    }
    return self;
}

#pragma mark - getViews
- (UIImageView *)getImageView{
    if (_imageView == nil) {
        self.imageView = ({
            UIImageView *imageView = [[UIImageView alloc]initWithFrame:CGRectZero];
            imageView.clipsToBounds = YES;
            imageView.contentMode = UIViewContentModeScaleAspectFit;
            [self addSubview:imageView];
            imageView;
        });
    }
    return _imageView;
}

- (UILabel *)getTitleLabel{
    if (_titleLabel == nil) {
        self.titleLabel = ({
            UILabel * label = [[UILabel alloc]initWithFrame:CGRectZero];
            label.textColor = [UIColor blackColor];
            label.textAlignment = NSTextAlignmentCenter;
            label.font = [UIFont systemFontOfSize:13];
            [self addSubview:label];
            label;
        });
    }
    return _titleLabel;
}

- (UILabel *)getBadgeLabel{
    if (_badgeLabel == nil) {
        self.badgeLabel = ({
            UILabel * label = [[UILabel alloc]initWithFrame:CGRectZero];
            label.textColor = [UIColor whiteColor];
            label.clipsToBounds = YES;
            label.textAlignment = NSTextAlignmentCenter;
            label.font = [UIFont systemFontOfSize:8];
            label.backgroundColor = [UIColor redColor];
            [self addSubview:label];
            label.hidden = YES;
            label;
        });
    }
    return _badgeLabel;
}

#pragma mark - setter

-(void)setCornerRadius:(CGFloat)cornerRadius{
    _cornerRadius = cornerRadius;
    self.layer.cornerRadius = cornerRadius;
    self.layer.masksToBounds = cornerRadius > 0?true:false;
}

-(void)setBorderWidth:(CGFloat)borderWidth{
    _borderWidth = borderWidth;
    self.layer.borderWidth = borderWidth;
}

-(void)setBorderColor:(UIColor *)borderColor{
    _borderColor = borderColor;
    self.layer.borderColor = borderColor.CGColor;
}

-(void)setTitle:(NSString *)title{
    _title = title;
    [self getTitleLabel].text = title;
    [[self getTitleLabel] sizeToFit];
    //设置label的文字时，需要手动调用刷新界面的方法，不然会出现布局乱的bug
    [self reloadView];
}

-(void)setTitleColor:(UIColor *)titleColor{
    _titleColor = titleColor;
    [self getTitleLabel].textColor = titleColor;
}

-(void)setTitleFont:(UIFont *)titleFont{
    _titleFont = titleFont;
    [self getTitleLabel].font = titleFont;
    [[self getTitleLabel] sizeToFit];
}

-(void)setTitleFontSize:(CGFloat)titleFontSize{
    _titleFontSize = titleFontSize;
    [self setTitleFont: [[self getTitleLabel].font fontWithSize:titleFontSize]];
}

-(void)setImage:(UIImage *)image{
    _image = image;
    [self getImageView].image = image;
}

-(void)setImageBackground:(UIColor *)imageBackground{
    _imageBackground = imageBackground;
    [self getImageView].backgroundColor = imageBackground;
}

-(void)setImageRadius:(NSInteger)imageRadius{
    _imageRadius = imageRadius;
    [self getImageView].layer.cornerRadius = imageRadius;
    [self getTitleLabel].layer.cornerRadius = imageRadius;
}

-(void)setImageTintColor:(UIColor *)imageTintColor{
    _imageTintColor = imageTintColor;
    [[self getImageView] setImage:[_image imageWithColor:imageTintColor]];
}

-(void)setImageContentMode:(UIViewContentMode)imageContentMode{
    _imageContentMode = imageContentMode;
    [self getImageView].contentMode = imageContentMode;
}

-(void)setTextAligment:(GZCAlignButtonAlignment)textAligment{
    _textAligment = textAligment;
    [self reloadView];
}

-(void)setAlignPadding:(CGFloat)alignPadding{
    _alignPadding = alignPadding;
}

-(void)setBadge:(NSString *)badge{
    _badge = badge;
    [self getBadgeLabel].text = badge;
    if (_badge==nil) {
        _badgeLabel.hidden = YES;
        return;
    }
    _badgeLabel.hidden = NO;
    //设置label的文字时，需要手动调用刷新界面的方法，不然会出现布局乱的bug
    [self reloadView];
}

-(void)setBadgeFontSize:(NSInteger)badgeFontSize{
    _badgeFontSize = badgeFontSize;
    [self getBadgeLabel].font = [UIFont systemFontOfSize:badgeFontSize];
}

-(void)setBadgeRadius:(CGFloat)badgeRadius{
    _badgeRadius = badgeRadius;
}

-(void)setBadgeBackgroundColor:(UIColor *)badgeBackgroundColor{
    _badgeBackgroundColor = badgeBackgroundColor;
    [self getBadgeLabel].backgroundColor = badgeBackgroundColor;
}

-(void)setBadgeStyle:(GZCAlignButtonBadgeStyle)badgeStyle{
    _badgeStyle = badgeStyle;
}

- (void)reloadView{
    [self layoutBadgeView];
    [self layoutImageAndTitle];
}

- (void)layoutImageAndTitle{
    CGRect rect = self.bounds;
    _titleLabel.backgroundColor = [UIColor clearColor];
    _titleLabel.clipsToBounds = NO;
    //如果字符串为空，就不用间距了
    if (_title == nil || _title.length == 0) {
        _alignPadding = 0;
    }
    float badgeX = 0;
    float badgeY = 0;
    //计算位置
    switch (_textAligment) {
        case GZCAlignButtonAlignmentLeft:
        {
            float width = CGRectGetWidth(_titleLabel.frame) + _alignPadding + _imageSize.width;
            _imageView.frame = CGRectMake((rect.size.width - width)/2,(rect.size.height - _imageSize.height)/2,_imageSize.width, _imageSize.height);
            _titleLabel.frame = CGRectMake(CGRectGetMaxX(_imageView.frame) + _alignPadding,(rect.size.height - CGRectGetHeight(_titleLabel.frame))/2, CGRectGetWidth(_titleLabel.frame), CGRectGetHeight(_titleLabel.frame));
            badgeX = CGRectGetMaxX(_imageView.frame) > CGRectGetMaxX(_titleLabel.frame) ? (CGRectGetMaxX(_imageView.frame) - _badgeRadius * 4):(CGRectGetMaxX(_titleLabel.frame)-_badgeRadius);
            badgeY = CGRectGetMinY(_imageView.frame) < CGRectGetMinY(_titleLabel.frame) ? (CGRectGetMinY(_imageView.frame)):(CGRectGetMinY(_titleLabel.frame));
            break;
        }
        case GZCAlignButtonAlignmentRight:
        {
            float width = CGRectGetWidth(_titleLabel.frame) + _alignPadding + _imageSize.width;
            _titleLabel.frame = CGRectMake((rect.size.width - width)/2, (rect.size.height - CGRectGetHeight(_titleLabel.frame))/2, CGRectGetWidth(_titleLabel.frame), CGRectGetHeight(_titleLabel.frame));
            _imageView.frame = CGRectMake(CGRectGetMaxX(_titleLabel.frame) + _alignPadding, (rect.size.height - _imageSize.height)/2, _imageSize.width, _imageSize.height);
            badgeX = CGRectGetMaxX(_imageView.frame) > CGRectGetMaxX(_titleLabel.frame) ? (CGRectGetMaxX(_imageView.frame) - _badgeRadius * 4):(CGRectGetMaxX(_titleLabel.frame)-_badgeRadius);
            badgeY = _imageSize.height > CGRectGetHeight(_titleLabel.frame) ? CGRectGetMinY(_imageView.frame) : CGRectGetMinY(_titleLabel.frame);
            break;
        }
        case GZCAlignButtonAlignmentTop:
        {
            float height = CGRectGetHeight(_titleLabel.frame) + _alignPadding + _imageSize.height;
            _imageView.frame = CGRectMake((rect.size.width - _imageSize.width)/2,(rect.size.height - height)/2,_imageSize.width, _imageSize.height);
            _titleLabel.frame = CGRectMake((rect.size.width - CGRectGetWidth(_titleLabel.frame))/2, CGRectGetMaxY(_imageView.frame) + _alignPadding, CGRectGetWidth(_titleLabel.frame) , CGRectGetHeight(_titleLabel.frame));
            badgeX = CGRectGetWidth(_imageView.frame) > 0 ? (CGRectGetMaxX(_imageView.frame) - _badgeRadius * 4):(CGRectGetMaxX(_titleLabel.frame)-_badgeRadius);
            badgeY = CGRectGetMinY(_titleLabel.frame) < CGRectGetMinY(_imageView.frame) ? CGRectGetMinY(_titleLabel.frame) : CGRectGetMinY(_imageView.frame);
            break;
        }
        case GZCAlignButtonAlignmentBottom:
        {
            float height = CGRectGetHeight(_titleLabel.frame) + _alignPadding + _imageSize.height;
            _titleLabel.frame = CGRectMake((rect.size.width - CGRectGetWidth(_titleLabel.frame))/2, (rect.size.height - height)/2, CGRectGetWidth(_titleLabel.frame), CGRectGetHeight(_titleLabel.frame));
            _imageView.frame = CGRectMake((rect.size.width - _imageSize.width)/2, CGRectGetMaxY(_titleLabel.frame) + _alignPadding , _imageSize.width, _imageSize.height);
            badgeX = CGRectGetWidth(_titleLabel.frame) > 0 ? (CGRectGetMaxX(_titleLabel.frame)-_badgeRadius):(CGRectGetMaxX(_imageView.frame) - _badgeRadius * 4);
            badgeY = CGRectGetMinY(_imageView.frame) < CGRectGetMinY(_titleLabel.frame) ? (CGRectGetMinY(_imageView.frame)):(CGRectGetMinY(_titleLabel.frame));
            break;
        }
        case GZCAlignButtonAlignmentBelow:
        {
            _imageView.frame = CGRectMake((rect.size.width - _imageSize.width)/2 ,(rect.size.height - _imageSize.height)/2 , _imageSize.width, _imageSize.height);
            _titleLabel.frame = _imageView.frame;
            badgeX = CGRectGetMaxX(_imageView.frame) - _badgeRadius * 4;
            badgeY = CGRectGetMinY(_imageView.frame);
            _titleLabel.backgroundColor = _shadowColor;
            _titleLabel.clipsToBounds = YES;
            break;
        }
    }
    if (_badgeStyle != GZCAlignButtonBadgeStyleRibbon) {
        _badgeLabel.frame = CGRectMake(badgeX, badgeY, CGRectGetWidth(_badgeLabel.frame), CGRectGetHeight(_badgeLabel.frame));
    }
}

-(void)layoutBadgeView{
    switch (_badgeStyle) {
        case GZCAlignButtonBadgeStylePoint:{
            _badgeLabel.text  = @"";
            float minheight = _badgeRadius * 2;
            _badgeLabel.frame = CGRectMake(0, 0, minheight, minheight);
            _badgeLabel.layer.cornerRadius = _badgeRadius;
            break;
        }
        case GZCAlignButtonBadgeStyleString:{
            _badgeLabel.text = _badge;
            [_badgeLabel sizeToFit];
            float minheight = _badgeRadius * 2;
            float width = CGRectGetWidth(_badgeLabel.frame) + minheight;
            float heigh = CGRectGetHeight(_badgeLabel.frame) > minheight ? CGRectGetHeight(_badgeLabel.frame):minheight;
            _badgeLabel.frame = CGRectMake(0, 0, width, heigh);
            _badgeLabel.layer.cornerRadius = heigh/2;
            break;
        }
        case GZCAlignButtonBadgeStyleRibbon:{
            _badgeLabel.text = _badge;
            [_badgeLabel sizeToFit];
            CGPoint centerPoint = CGPointMake(CGRectGetWidth(self.frame) - CGRectGetWidth(_badgeLabel.frame)/2 - 10, CGRectGetWidth(_badgeLabel.frame)/2 + 10) ;
            float width = CGRectGetWidth(_badgeLabel.frame) + CGRectGetWidth(self.frame);
            float heigh = CGRectGetHeight(_badgeLabel.frame);
            _badgeLabel.frame = CGRectMake(0 , 0, width, heigh);
            _badgeLabel.center = centerPoint;
            CGAffineTransform transform = CGAffineTransformMakeRotation(45 * M_PI/180.0);
            [_badgeLabel setTransform:transform];
            break;
        }
    }
}

#pragma mark - DrawRect
- (void)drawRect:(CGRect)rect {
    [self reloadView];
    [self bringSubviewToFront:_titleLabel];
    [self bringSubviewToFront:_badgeLabel];
}


@end
