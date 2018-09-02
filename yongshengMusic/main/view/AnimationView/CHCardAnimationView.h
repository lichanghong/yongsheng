//
//  CHCardAnimationView.h
//  SYGuessYouLikeAnimationView
//
//  Created by lichanghong on 8/1/18.
//  Copyright © 2018 lichanghong. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "HomePageModel.h"


@interface CHCardAnimationView : UIView

@property (nonatomic, copy) NSMutableArray<HomeStudentWorkEntity *> *cardViewEntityList;

@property (nonatomic, assign) NSInteger showOverlayCount;

- (void)show;

@end
