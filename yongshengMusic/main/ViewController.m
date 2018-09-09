//
//  ViewController.m
//  yongshengMusic
//
//  Created by lichanghong on 8/12/18.
//  Copyright © 2018 lichanghong. All rights reserved.
//

#import "ViewController.h"
#import "CHBannerTableViewCell.h"
#import "CHToolsTableViewCell.h"
#import "CHCardAnimationTableViewCell.h"
#import "CHNewsTableViewCell.h"
#import "UITableView+CHExtension.h"
#import "CHNetRequest.h"
#import "HomePageModel.h"
#import <YYModel.h>
#import <UIImageView+WebCache.h>
#import "CHHomeRouterModule.h"
#import <UIView+CHFrame.h>

#define WEAKSELF __weak typeof(self) weakSelf = self;

@interface ViewController ()<UITableViewDataSource,UITableViewDelegate>
@property (nonatomic,strong)UITableView *tableView;
@property (nonatomic,copy)NSArray *tableViewCellNames;
@property (nonatomic,strong)HomePageModel *homePageModel;

@end

@implementation ViewController


- (void)viewDidLoad {
    [super viewDidLoad];
   
    [self.navigationController setNavigationBarHidden:YES];
    self.tableViewCellNames = @[
                                @"CHBannerTableViewCell",
                                @"CHToolsTableViewCell",
                                @"CHCardAnimationTableViewCell",
                                @"CHNewsTableViewCell"
                                ];
    CGRect rect = CGRectMake(0, 0, KScreenWidth, KScreenHeight-self.tabBarController.tabBar.height);
    self.tableView = [[UITableView alloc]initWithFrame:rect style:UITableViewStylePlain];
//    [self.tableView setContentInsetAdjustmentBehavior:UIScrollViewContentInsetAdjustmentNever];
    [self.view addSubview:self.tableView];
    if (@available(iOS 11.0, *)) {
        self.tableView.contentInsetAdjustmentBehavior = UIScrollViewContentInsetAdjustmentNever;
        // est和代理 可选1个
        self.tableView.estimatedSectionFooterHeight = 0;
        self.tableView.estimatedSectionHeaderHeight = 0;
    } else {
        self.automaticallyAdjustsScrollViewInsets = NO;
    }
   
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    for (NSString *cellclass in self.tableViewCellNames) {
        Class cell = NSClassFromString(cellclass);
        [self.tableView registerClass:cell];
    }

    WEAKSELF
    [CHNetRequest requestWithURL:API_Home Success:^(id result) {
        weakSelf.homePageModel = [HomePageModel yy_modelWithJSON:result];
        [weakSelf.tableView reloadData];
    } failure:^(NSError *error) {
        
    }];
    // Do any additional setup after loading the view, typically from a nib.
    
}


-  (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return CHViewControllerCellTypeSectionAll;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    switch (section) {
        case CHViewControllerCellTypeSectionBanner:
            return self.homePageModel.banners.count>0? 1:0;
            break;
        case CHViewControllerCellTypeSectionTools:
            return self.homePageModel.iconList.count>0? 1:0;
            break;
        case CHViewControllerCellTypeSectionWorks:
            return  self.homePageModel.studentWork.count > 0?1:0;
            break;
        case CHViewControllerCellTypeSectionNews:
            return self.homePageModel.schoolNews.count>0?self.homePageModel.schoolNews.count:0;
            break;
        default:
            break;
    }
    return 0;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    CGFloat height = 0;
    switch (indexPath.section) {
        case CHViewControllerCellTypeSectionBanner:
            height = self.homePageModel.banners.count>0?180:0;
            break;
        case CHViewControllerCellTypeSectionTools:
            if (self.homePageModel.iconList.count<=5 && self.homePageModel.iconList.count>0) {
                height = 90;
            }
            else if(self.homePageModel.iconList.count>5)
                height = [CHToolsTableViewCell cellHeight:self.homePageModel.iconList bottomViewShow:NO];
            else height = 0;
            break;
        case CHViewControllerCellTypeSectionWorks:
            height = self.homePageModel.studentWork.count>0?180:0;
            break;
        case CHViewControllerCellTypeSectionNews:
            height = self.homePageModel.schoolNews.count>0?80:0;
            break;
        default:
            break;
    }
    return height;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSString *identifier = [self.tableViewCellNames objectAtIndex:indexPath.section];
    return [tableView dequeueReusableCellWithIdentifier:identifier forIndexPath:indexPath];
}

- (void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath
{
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    switch (indexPath.section) {
        case CHViewControllerCellTypeSectionBanner:
        {
            CHBannerTableViewCell *banner = (CHBannerTableViewCell *)cell;
            banner.banners = self.homePageModel.banners;
            //赋值
            break;
        }
        case CHViewControllerCellTypeSectionTools:{
            CHToolsTableViewCell *tools = (CHToolsTableViewCell *)cell;
            tools.itemList = self.homePageModel.iconList;
            break;
        }
        case CHViewControllerCellTypeSectionWorks:{
            CHCardAnimationTableViewCell *workCell = (CHCardAnimationTableViewCell *)cell;
            workCell.titleLabel.text = @"学生作品";
            workCell.cardAnimationView.cardViewEntityList = [self.homePageModel.studentWork mutableCopy];
            break;
        }
        case CHViewControllerCellTypeSectionNews:{
            HomeStudentWorkEntity*entity = [self.homePageModel.schoolNews objectAtIndex:indexPath.row];
            CHNewsTableViewCell *workCell = (CHNewsTableViewCell *)cell;
            workCell.title.text = entity.title;
            workCell.subTitle.text = entity.nick_name;
            [workCell.mImageView sd_setImageWithURL:[NSURL URLWithString:entity.img]];
            break;
        }
        default:
            break;
    }
}


- (nullable UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section;   // custom view for header. will be adjusted to default or specified header height
{
    if (section == CHViewControllerCellTypeSectionNews && self.homePageModel.schoolNews.count>0) {
        UIView *view = [[UIView alloc]initWithFrame:CGRectMake(0, 5, 100, 20)];
        UILabel *label = [[UILabel alloc]initWithFrame:CGRectMake(12, 0, 100, 20)];
        label.text = @"校内新闻";
        label.font = [UIFont systemFontOfSize:16];
        [view addSubview:label];
        return view;
    }
    else return [[UIView alloc]initWithFrame:CGRectMake(0, 0, 0, 0)];
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section;
{
    if (section == CHViewControllerCellTypeSectionNews && self.homePageModel.schoolNews.count>0) {
        return 20;
    }
    else return 0;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
