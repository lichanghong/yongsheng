//
//  SYCardAnimationContentView.m
//  SYGuessYouLikeAnimationView
//
//  Created by lichanghong on 8/2/18.
//  Copyright © 2018 lichanghong. All rights reserved.
//

#import "CHCardAnimationContentView.h"
#import <UIView+CHFrame.h>
#import <UIColor+Util.h>

@implementation CHCardAnimationContentView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.layer.cornerRadius = 8;
        self.backgroundColor = [UIColor whiteColor];
        self.layer.borderWidth = 0.5;
        self.layer.shadowRadius = 8;
        self.layer.shadowOpacity = 1;
        self.layer.shadowOffset = CGSizeMake(0, 2);
        self.layer.shadowColor = [[UIColor blackColor] colorWithAlphaComponent:0.1].CGColor;
        self.layer.borderColor = [UIColor colorForHex:@"EFEFEF"].CGColor;

        self.portraitImageView = [self portraitImageView];
        self.leftImageView = [self leftImageView];
        self.titleLabel = [self titleLabel];
        self.nickName = [self nickName];
        
        [self addSubview:self.leftImageView];
        [self addSubview:self.titleLabel];
        [self addSubview:self.portraitImageView];
        [self addSubview:self.nickName];
        [self refreshUI];
        
    }
    return self;
}

- (void)refreshUI
{
    self.leftImageView.frame = CGRectMake(0, 0, 129, self.height);
    self.portraitImageView.frame = CGRectMake(self.leftImageView.right+12, self.height-16-10, 16, 16);
    self.nickName.frame = CGRectMake(178, self.portraitImageView.y, 90, 16);
    self.titleLabel.frame = CGRectMake(154, self.nickName.y-8-44, 188, 44);

    UIBezierPath *bezierPath = [UIBezierPath bezierPathWithRoundedRect:_leftImageView.bounds byRoundingCorners:UIRectCornerBottomLeft | UIRectCornerTopLeft cornerRadii:CGSizeMake(8, 8)];
    CAShapeLayer *shapeLayer = [CAShapeLayer layer];
    shapeLayer.path = bezierPath.CGPath;
    shapeLayer.frame = _leftImageView.bounds;
    _leftImageView.layer.mask = shapeLayer;
}


- (UILabel *)nickName
{
    if (!_nickName) {
        UILabel *label = [[UILabel alloc] init];
        label.text = @"氧气迷_sun";
        label.font = [UIFont fontWithName:@"PingFangSC-Light" size:11];
        label.textColor = [UIColor colorWithRed:119/255.0 green:119/255.0 blue:119/255.0 alpha:1/1.0];
        _nickName = label;
    }
    return _nickName;
}



- (UIImageView *)portraitImageView
{
    if (!_portraitImageView) {
        _portraitImageView = [[UIImageView alloc]init];
        [_portraitImageView.layer setCornerRadius:8];
        _portraitImageView.backgroundColor = [UIColor clearColor];
    }
    return _portraitImageView;
}

- (UILabel *)titleLabel
{
    if (!_titleLabel) {
        UILabel *label = [[UILabel alloc] init];
        label.text = @"你以为的减肥很可能是增肥，体脂低动动就有马甲线";
        label.font = [UIFont fontWithName:@"PingFangSC-Regular" size:14];
        label.textColor = [UIColor colorWithRed:51/255.0 green:51/255.0 blue:51/255.0 alpha:1/1.0];
        label.numberOfLines = 2;
        _titleLabel = label;
    }
    return _titleLabel;
}

- (UIImageView *)leftImageView
{
    if (!_leftImageView) {
        _leftImageView = [[UIImageView alloc]init];
        _leftImageView.image = [UIImage imageNamed:@"flip"];
        [_leftImageView.layer setMasksToBounds:YES];
    }
    return _leftImageView;
}


@end
