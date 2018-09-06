


#import "CHTabBarController.h"
#import "ViewController.h"
#import "CHAliViewController.h"
#import "CHStudyViewController.h"

@interface CHTabBarController () <UITabBarControllerDelegate>

@property (nonatomic, strong) ViewController *homeVC;
@property (nonatomic, strong) CHAliViewController *aliVC;
@property (nonatomic, strong) CHStudyViewController *studyVC;

@end

@implementation CHTabBarController

- (instancetype)init
{
    self = [super init];
    if (self) {
        [self initTabBar];
    }
    return self;
}

- (void)dealloc
{
    NSLog(@"%@ --- dealloc",NSStringFromClass(self.class));
}

- (void)initTabBar
{
    [self addChildViewControllers];
    [self setChildControllersCustomTabItem];
    self.delegate = self;
    [self setTabbarNormalTitleColor:[UIColor blackColor] selectedTitleColor:[UIColor greenColor]];
}

- (void)addChildViewControllers
{
    _homeVC = [[ViewController alloc] init];
    [self addChildVc:_homeVC];
    _aliVC = [[CHAliViewController alloc] init];
    [self addChildVc:_aliVC];
    _studyVC = [[CHStudyViewController alloc] init];
    [self addChildVc:_studyVC];
  
}

- (void)setChildControllersCustomTabItem
{
    [self setChildVc:_homeVC Title:@"首页" image:[UIImage imageNamed:@"tab_home"] selectedImage:[UIImage imageNamed:@"tab_home_selected"]];
    
    [self setChildVc:_aliVC Title:@"选购" image:[UIImage imageNamed:@"tab_gou"] selectedImage:[UIImage imageNamed:@"tab_gou_selected"]];
    
    [self setChildVc:_studyVC Title:@"学习" image:[UIImage imageNamed:@"homepage_bottom_me"] selectedImage:[UIImage imageNamed:@"homepage_bottom_me_selected"]];
    
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.tabBar.itemPositioning = UITabBarItemPositioningCentered;
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
}

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
 
}



// 设置title颜色
- (void)setTabbarNormalTitleColor:(UIColor *)normalColor selectedTitleColor:(UIColor *)selectedColor
{
    [[UITabBarItem appearance] setTitleTextAttributes:@{NSForegroundColorAttributeName : normalColor} forState:UIControlStateNormal];
    [[UITabBarItem appearance] setTitleTextAttributes:@{NSForegroundColorAttributeName : selectedColor} forState:UIControlStateSelected];
}

// 添加子控制器
- (void)addChildVc:(UIViewController *)childVc
{
    // 先给外面传进来的小控制器包装一个导航控制器
    UINavigationController *nav = [[UINavigationController alloc] initWithRootViewController:childVc];
    nav.navigationBar.barTintColor = [UIColor whiteColor];
    
    childVc.tabBarItem.imageInsets = UIEdgeInsetsMake(-0.5, 0, 0.5, 0);
    
    [childVc.tabBarItem setTitlePositionAdjustment:UIOffsetMake(0, -3.5)];
    
    [self addChildViewController:nav];
}

// 设置子控制器
- (void)setChildVc:(UIViewController *)childVc Title:(NSString *)title image:(UIImage *)image selectedImage:(UIImage *)selectedImage
{
    childVc.title = title;
    // 设置图片和图片保持原样不被渲染
    childVc.tabBarItem.image = [image imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    childVc.tabBarItem.selectedImage = [selectedImage imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
}



- (void)tabBarController:(UITabBarController *)tabBarController didSelectViewController:(UIViewController *)viewController
{
 
}
 

#pragma mark - 播放器屏幕旋转
- (BOOL)shouldAutorotate{
    return NO;
}
- (UIInterfaceOrientationMask)supportedInterfaceOrientations{
    return UIInterfaceOrientationMaskPortrait;
}
@end
