//
//  SYNewToolsTableViewCell.h
//  SoYoungMobile40
//
//  Created by Jeakon on 2017/7/10.
//  Copyright © 2017年 soyoung. All rights reserved.
//

#import "CHBaseTableViewCell.h"

@class CHToolsTableViewCell;

@protocol CHToolsTableViewCellDelegate <NSObject>

- (void)newToolsTableViewCell:(CHToolsTableViewCell *)newToolsTableViewCell
                itemDidSelect:(id)item
                      atIndex:(NSInteger)index;

@end

@interface CHToolsTableViewCell : CHBaseTableViewCell

@property (nonatomic, copy) UIColor *titleColor;

+ (CGFloat)cellHeight:(id)itemList
       bottomViewShow:(BOOL)bottomViewShow;

@property (nonatomic, copy) NSArray *itemList;

@property (nonatomic, weak) id<CHToolsTableViewCellDelegate> delegate;

- (void)setBackgroundImageWithImageUrl:(NSString *)imageUrl;

- (void)setBottomViewShow:(BOOL)show;


@end
