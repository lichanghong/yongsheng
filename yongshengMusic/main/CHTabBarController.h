 

#import <UIKit/UIKit.h>

@class CHTabBarController;

@protocol CHTabBarControllerDelegate <NSObject>
@optional
- (BOOL)tabBarController:(CHTabBarController *)tabBarController shouldSelectViewController:(UIViewController *)viewController;
- (void)tabBarController:(CHTabBarController *)tabBarController didSelectViewController:(UIViewController *)viewController;

@end


@interface CHTabBarController : UITabBarController

// 后台请求参数动态配置
@property (nonatomic, weak) id<CHTabBarControllerDelegate> sy_delegate;


@end
