//
//  SYNewToolsTableViewCell.m
//  SoYoungMobile40
//
//  Created by Jeakon on 2017/7/10.
//  Copyright © 2017年 soyoung. All rights reserved.
//

#import "StyledPageControl.h"
#import <Masonry/Masonry.h>
#import "CHToolsTableViewCell.h"
#import <CHBaseUtil/UIView+CHFrame.h>
#import <CHBaseUtil_Safe.h>
#import <UIImageView+WebCache.h>
#import "HomePageModel.h"

#define SY_CHANGEWIDTH(sy_width) sy_width * KScreenWidth / 375
#define kTopMargin SY_CHANGEWIDTH(10)
#define kLeftMargin 14
#define kItemSpacing SY_CHANGEWIDTH(10)
#define kItemWidth SY_CHANGEWIDTH(55)
#define kItemHeight (kItemWidth + SY_CHANGEWIDTH(2) + 13)
#define kPageViewHeight SY_CHANGEWIDTH(5)
#define kPageViewSpacingToItem SY_CHANGEWIDTH(10)
#define WEAKSELF __weak typeof(self) weakSelf = self;

#pragma mark - 每一个item的view
@interface CHToolItemView : UIView

@property (nonatomic, strong) UIImageView * iconView;
@property (nonatomic, strong) UILabel * nameLabel;

+ (instancetype)createItemView;

@end

@implementation CHToolItemView

+ (instancetype)createItemView
{
    CHToolItemView * itemView = [[CHToolItemView alloc] init];
    itemView.size = CGSizeMake(kItemWidth, kItemHeight);
    [itemView setupViews];
    return itemView;
}

- (void)setupViews
{
    [self addSubview:self.iconView];
    [self addSubview:self.nameLabel];
    [self.iconView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.top.equalTo(self);
        make.height.mas_equalTo(kItemWidth);
    }];
    [self.nameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.bottom.equalTo(self);
        make.top.mas_equalTo(kItemWidth+7);
    }];
}

- (UIImageView *)iconView
{
    if (_iconView == nil) {
        _iconView = [[UIImageView alloc] init];
        _iconView.layer.cornerRadius = kItemWidth/2.0;
        [_iconView.layer setMasksToBounds:YES];
    }
    return _iconView;
}

- (UILabel *)nameLabel
{
    if (_nameLabel == nil) {
        _nameLabel = [[UILabel alloc] init];
        _nameLabel.textColor = [UIColor blackColor];
        _nameLabel.font = [UIFont systemFontOfSize:13];
        _nameLabel.textAlignment = NSTextAlignmentCenter;
    }
    return _nameLabel;
}

@end

#pragma mark - 每一页的view
@interface SYNewToolView : UIView

@property (nonatomic, copy) NSArray* itemList;
@property (nonatomic, copy) void(^itemDidSelect)(SYNewToolView * toolView,id item, NSInteger index);
@property (nonatomic, copy) UIColor *titleColor;

+ (instancetype)createNewToolView;

@end

@implementation SYNewToolView

+ (instancetype)createNewToolView
{
    SYNewToolView * toolView = [[SYNewToolView alloc] init];
    toolView.size = CGSizeMake(KScreenWidth, kItemHeight * 2 + kItemSpacing);
    [toolView setupViews];
    return toolView;
}

- (void)setupViews
{
    CGFloat spacing = (KScreenWidth - kItemWidth * 5 - kLeftMargin * 2) / 4;
    for (NSInteger i = 0; i < 10; i++) {
        CHToolItemView * itemView = [CHToolItemView createItemView];
        if (self.titleColor) {
            itemView.nameLabel.textColor = self.titleColor;
        }
        itemView.origin = CGPointMake(kLeftMargin + (kItemWidth + spacing) * (i % 5), (kItemSpacing + kItemHeight) * (i / 5));
        itemView.tag = 100 + i;
        itemView.userInteractionEnabled = YES;
        [itemView addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(itemClicked:)]];
        [self addSubview:itemView];
    }
}

- (void)setTitleColor:(UIColor *)titleColor
{
    _titleColor = titleColor;
    UIColor *color;
    if (_titleColor) {
        color = _titleColor;
    } else {
        color = [UIColor blackColor];
    }
    for (NSInteger i = 0; i < 10; i++) {
        CHToolItemView * itemView = [self viewWithTag:100 + i];
        itemView.nameLabel.textColor = color;
    }
}

- (void)setItemList:(NSArray *)itemList
{
    _itemList = itemList;
    for (NSInteger i = 0; i < 10; i++) {
        HomeBannerItem* item = [itemList safeObjectAtIndex:i];
        CHToolItemView * itemView = [self viewWithTag:100 + i];
        if (item) {
            itemView.hidden = NO;
            [itemView.iconView sd_setImageWithURL:[NSURL URLWithString:item.img]];
            itemView.nameLabel.text = item.title;
        } else {
            itemView.hidden = YES;
        }
    }
}

- (void)itemClicked:(UITapGestureRecognizer *)tap
{
    NSInteger index = tap.view.tag - 100;
    id item = [self.itemList safeObjectAtIndex:index];
    if (item) {
        if (self.itemDidSelect) {
            self.itemDidSelect(self, item, index);
        }
    }
}

@end


#pragma mark - cell
@interface CHToolsTableViewCell() <UIScrollViewDelegate>

@property (nonatomic, strong) StyledPageControl * pageControl;
@property (nonatomic, strong) UIScrollView * scrollView;
@property (nonatomic, strong) UIView * bottomView;

@property (nonatomic, copy) UIImageView *bgView;

@end

@implementation CHToolsTableViewCell

+ (CGFloat)cellHeight:(NSArray *)dataList
       bottomViewShow:(BOOL)bottomViewShow
{
    CGFloat height;
    if (dataList == 0) {
        return 0;
    } else if (dataList.count <= 10) {
        height = SY_CHANGEWIDTH(180) - 20;//kItemHeight * 2 + kTopMargin * 2 + kItemSpacing + 5;
    } else {
        height = SY_CHANGEWIDTH(180);//kItemHeight * 2 + kTopMargin + kItemSpacing + kPageViewHeight + kPageViewSpacingToItem * 2 + 5;
    }
    if (bottomViewShow) {
        height += 5;
    }
    return height;
}

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        [self setupViews];
    }
    return self;
}

- (void)setupViews
{
    self.clipsToBounds = YES;
    self.contentView.backgroundColor = [UIColor whiteColor];
    self.selectionStyle = UITableViewCellSelectionStyleNone;
    [self.contentView addSubview:self.bgView];
    [self.contentView addSubview:self.scrollView];
    [self.contentView addSubview:self.pageControl];
    [self.contentView addSubview:self.bottomView];
    [self.bgView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.top.equalTo(self.contentView);
        make.height.mas_equalTo(SY_CHANGEWIDTH(180));
    }];
    
    [self.bottomView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.bottom.equalTo(self.contentView);
        make.height.mas_equalTo(5);
    }];
}

- (void)setBackgroundImageWithImageUrl:(NSString *)imageUrl
{
    
//    [self.bgView sy_setImageWithURL:[NSURL URLWithString:imageUrl]
//                            placeholderImage:nil
//                                cornerRadius:0.0f
//                                     success:^(HTTPDetails *result)
//    {
//
//    }
//    failure:^(HTTPDetails *result)
//    {
//
//    }];
}

- (void)setBottomViewShow:(BOOL)show
{
    self.bottomView.hidden = !show;
}

- (void)setItemList:(NSArray *)itemList
{
    if ([_itemList isEqualToArray:itemList] == NO) {
        _itemList = itemList;
        [self configUI];
    }
}

- (void)configUI
{
    NSInteger page;
    if (self.itemList.count <= 10) {
        page = 1;
    } else {
        if (self.itemList.count % 10 == 0) {
            page = self.itemList.count / 10;
        } else {
            page = self.itemList.count / 10 + 1;
        }
    }
    self.pageControl.numberOfPages = (int)page;
    self.pageControl.currentPage = 0;
    
    while (self.scrollView.subviews.count) {
        UIView* child = self.subviews.lastObject;
        [child removeFromSuperview];
    }
    CGPoint contentOffset = self.scrollView.contentOffset;
    contentOffset.x = 0;
    self.scrollView.contentOffset = contentOffset;
    
    self.scrollView.contentSize = CGSizeMake(page * self.scrollView.width + 2 * 1, 0);
    [self.scrollView setContentOffset:CGPointMake(1, 0) animated:NO];
    for (NSInteger i = 0; i < page; i++) {
        SYNewToolView * toolView = [SYNewToolView createNewToolView];
        toolView.titleColor = self.titleColor;
        toolView.origin = CGPointMake(KScreenWidth * i, 0);
        toolView.tag = 1000 + i;
        NSMutableArray * subItemList = [NSMutableArray array];
        for (NSInteger j = i * 10; j < (i + 1) * 10; j++) {
            id item = [self.itemList safeObjectAtIndex:j];
            if (item == nil) {
                break;
            }
            [subItemList addObject:item];
        }
        toolView.itemList = subItemList;
        WEAKSELF
        toolView.itemDidSelect = ^(SYNewToolView* toolView, id item, NSInteger index) {
            NSInteger page = toolView.tag - 1000;
            [weakSelf itemClicked:item atIndex:index + page * 10];
        };
        [self.scrollView addSubview:toolView];
    }
}

- (void)itemClicked:(id)item
            atIndex:(NSInteger)index
{
    if ([self.delegate respondsToSelector:@selector(newToolsTableViewCell:itemDidSelect:atIndex:)]) {
        [self.delegate newToolsTableViewCell:self itemDidSelect:item atIndex:index];
    }
}


- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    NSInteger index = scrollView.contentOffset.x / scrollView.width;
    self.pageControl.currentPage = (int)index;
}

- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView
{
    CGFloat contentMaxLeftInset = scrollView.contentSize.width - scrollView.width;
    if (scrollView == self.scrollView && scrollView.contentOffset.x == contentMaxLeftInset) {
        CGFloat contentOffsetX = contentMaxLeftInset - 1;
        [scrollView setContentOffset:CGPointMake(contentOffsetX, 0) animated:NO];
    } else if (scrollView == self.scrollView && scrollView.contentOffset.x == 0) {
        [scrollView setContentOffset:CGPointMake(1, 0) animated:NO];
    }
}

#pragma mark - getter
- (StyledPageControl *)pageControl
{
    if (_pageControl == nil) {
        _pageControl = [[StyledPageControl alloc] initWithFrame:CGRectMake(0, SY_CHANGEWIDTH(180) - kPageViewSpacingToItem - kPageViewHeight, KScreenWidth, kPageViewHeight)];
        _pageControl.coreNormalColor = [UIColor clearColor];
        _pageControl.coreSelectedColor = [UIColor clearColor];
        _pageControl.gapWidth = 5;
        _pageControl.diameter = 8;
        _pageControl.hidesForSinglePage = YES;
        _pageControl.userInteractionEnabled = NO;
    }
    return _pageControl;
}

- (UIScrollView *)scrollView
{
    if (_scrollView == nil) {
        _scrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, kTopMargin, KScreenWidth, SY_CHANGEWIDTH(180))];//kItemHeight * 2 + kItemSpacing)];
        _scrollView.pagingEnabled = YES;
        //        _scrollView.bounces = NO;
        _scrollView.showsVerticalScrollIndicator = NO;
        _scrollView.showsHorizontalScrollIndicator = NO;
        _scrollView.delegate = self;
        _scrollView.scrollsToTop = NO;
    }
    return _scrollView;
}

- (UIView *)bottomView
{
    if (_bottomView == nil) {
        _bottomView = [[UIView alloc] init];
        _bottomView.backgroundColor = [UIColor clearColor];
    }
    return _bottomView;
}

- (UIImageView *)bgView
{
    if (_bgView == nil) {
        _bgView = [[UIImageView alloc] init];
        //_bgView.contentMode = UIViewContentModeScaleAspectFit;
        //_bgView.clipsToBounds = YES;
    }
    return _bgView;
}

@end
