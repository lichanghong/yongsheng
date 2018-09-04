//
//  UITableView.m
//  yongshengMusic
//
//  Created by lichanghong on 8/13/18.
//  Copyright © 2018 lichanghong. All rights reserved.
//

#import "UITableView+CHExtension.h"

@implementation UITableView (CHExtension)
- (void)registerClass:(Class)cellClass
{
    [self registerClass:cellClass forCellReuseIdentifier:NSStringFromClass(cellClass)];
}


@end
