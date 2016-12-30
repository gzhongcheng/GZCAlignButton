//
//  GZCAlignButton.m
//  MemberSystem
//
//  Created by GuoZhongCheng on 16/6/22.
//  Copyright © 2016年 郭忠橙. All rights reserved.
//

#import "GZCAlignButton.h"

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
        self.imageContentMode = UIViewContentModeScaleAspectFit;
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
            label.numberOfLines = 2;
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

-(void)setImageContentMode:(NSInteger)imageContentMode{
    _imageContentMode = imageContentMode;
    [self getImageView].contentMode = imageContentMode;
}

-(void)setTextAligment:(NSInteger)textAligment{
    _textAligment = textAligment;
    [self layoutImageAndTitle];
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

-(void)setBadgeStyle:(NSInteger)badgeStyle{
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
    switch (_textAligment) {
        case GZCAlignButtonAlignmentLeft:
        {
            float width = CGRectGetWidth(_titleLabel.frame) + _alignPadding + _imageSize.width;
            _imageView.frame = CGRectMake((rect.size.width - width)/2,(rect.size.height - _imageSize.height)/2,_imageSize.width, _imageSize.height);
            _titleLabel.frame = CGRectMake(CGRectGetMaxX(_imageView.frame) + _alignPadding, 0, CGRectGetWidth(_titleLabel.frame), rect.size.height);
            _badgeLabel.frame = CGRectMake(CGRectGetMaxX(_titleLabel.frame) - CGRectGetWidth(_badgeLabel.frame), CGRectGetMinY(_imageView.frame), CGRectGetWidth(_badgeLabel.frame), CGRectGetHeight(_badgeLabel.frame));
            break;
        }
        case GZCAlignButtonAlignmentRight:
        {
            float width = CGRectGetWidth(_titleLabel.frame) + _alignPadding + _imageSize.width;
            _titleLabel.frame = CGRectMake((rect.size.width - width)/2, 0, CGRectGetWidth(_titleLabel.frame), rect.size.height);
            _imageView.frame = CGRectMake(CGRectGetMaxX(_titleLabel.frame) + _alignPadding, (rect.size.height - _imageSize.height)/2, _imageSize.width, _imageSize.height);
            _badgeLabel.frame = CGRectMake(CGRectGetMaxX(_imageView.frame) - CGRectGetWidth(_badgeLabel.frame), CGRectGetMinY(_imageView.frame), CGRectGetWidth(_badgeLabel.frame), CGRectGetHeight(_badgeLabel.frame));
            break;
        }
        case GZCAlignButtonAlignmentTop:
        {
            float height = CGRectGetHeight(_titleLabel.frame) + _alignPadding + _imageSize.height;
            _imageView.frame = CGRectMake((rect.size.width - _imageSize.width)/2,(rect.size.height - height)/2,_imageSize.width, _imageSize.height);
            _titleLabel.frame = CGRectMake(0, CGRectGetMaxY(_imageView.frame) + _alignPadding, rect.size.width , CGRectGetHeight(_titleLabel.frame));
            _badgeLabel.frame = CGRectMake(CGRectGetMaxX(_imageView.frame) - _badgeRadius * 4, CGRectGetMinY(_imageView.frame), CGRectGetWidth(_badgeLabel.frame), CGRectGetHeight(_badgeLabel.frame));
            break;
        }
        case GZCAlignButtonAlignmentBottom:
        {
            float height = CGRectGetHeight(_titleLabel.frame) + _alignPadding + _imageSize.height;
            _titleLabel.frame = CGRectMake((rect.size.width - CGRectGetWidth(_titleLabel.frame))/2, (rect.size.height - height)/2, CGRectGetWidth(_titleLabel.frame), CGRectGetHeight(_titleLabel.frame));
            _imageView.frame = CGRectMake((rect.size.width - _imageSize.width)/2, CGRectGetMaxY(_titleLabel.frame) + _alignPadding , _imageSize.width, _imageSize.height);
            if (CGRectGetWidth(_titleLabel.frame)) {
                _badgeLabel.frame = CGRectMake(CGRectGetMaxX(_titleLabel.frame), CGRectGetMinY(_titleLabel.frame), CGRectGetWidth(_badgeLabel.frame), CGRectGetHeight(_badgeLabel.frame));
            }else{
                _badgeLabel.frame = CGRectMake(CGRectGetMaxX(_imageView.frame) - CGRectGetWidth(_badgeLabel.frame), CGRectGetMinY(_imageView.frame), CGRectGetWidth(_badgeLabel.frame), CGRectGetHeight(_badgeLabel.frame));
            }
            break;
        }
        case GZCAlignButtonAlignmentBelow:
        {
            _imageView.frame = CGRectMake((rect.size.width - _imageSize.width)/2 ,(rect.size.height - _imageSize.height)/2 , _imageSize.width, _imageSize.height);
            _titleLabel.frame = _imageView.frame;
            _badgeLabel.frame = CGRectMake(CGRectGetMaxX(_imageView.frame) - CGRectGetWidth(_badgeLabel.frame), CGRectGetMinY(_imageView.frame), CGRectGetWidth(_badgeLabel.frame), CGRectGetHeight(_badgeLabel.frame));
            _titleLabel.backgroundColor = _shadowColor;
            _titleLabel.clipsToBounds = YES;
            break;
        }
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
    }
}

#pragma mark - DrawRect
- (void)drawRect:(CGRect)rect {
    [self reloadView];
    [self bringSubviewToFront:_titleLabel];
    [self bringSubviewToFront:_badgeLabel];
}


@end
