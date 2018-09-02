//
//  SYCardAnimationTableViewCell.m
//  SYGuessYouLikeAnimationView
//
//  Created by lichanghong on 8/2/18.
//  Copyright © 2018 lichanghong. All rights reserved.
//

#import "CHCardAnimationTableViewCell.h"
#import <UIView+CHFrame.h>

@implementation CHCardAnimationTableViewCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self.titleLabel = [self titleLabel];
        [self.contentView addSubview:self.titleLabel];
        
        CHCardAnimationView *customXxx = [CHCardAnimationView new];
        self.cardAnimationView = customXxx;
        [self.contentView addSubview:customXxx];
        
//        float h = 180.0;
        CGFloat width = UIScreen.mainScreen.bounds.size.width;
        //100+h+5
        customXxx.frame = CGRectMake(0, 14+self.titleLabel.bottom, width, (width-30)/345*88);
        [customXxx show];
    }
    return self;
}

- (UILabel *)titleLabel
{
    if (!_titleLabel) {
        UILabel *label = [[UILabel alloc] init];
        label.frame = CGRectMake(15, 20, 64, 22);
        label.text = @"学生作品";
        label.font = [UIFont fontWithName:@"PingFangSC-Semibold" size:16];
        label.textColor = [UIColor colorWithRed:51/255.0 green:51/255.0 blue:51/255.0 alpha:1/1.0];
        _titleLabel = label;
    }
    return _titleLabel;
}
 

@end
