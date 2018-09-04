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

#define WEAKSELF __weak typeof(self) weakSelf = self;

@interface ViewController ()<UITableViewDataSource,UITableViewDelegate>
@property (nonatomic,strong)UITableView *tableView;
@property (nonatomic,copy)NSArray *tableViewCellNames;
@property (nonatomic,strong)HomePageModel *homePageModel;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.tableViewCellNames = @[
                                @"CHBannerTableViewCell",
                                @"CHToolsTableViewCell",
                                @"CHCardAnimationTableViewCell",
                                @"CHNewsTableViewCell"
                                ];
    self.tableView = [[UITableView alloc]initWithFrame:self.view.bounds style:UITableViewStylePlain];
    [self.tableView setScrollIndicatorInsets:UIEdgeInsetsZero];
    [self.tableView setContentInsetAdjustmentBehavior:UIScrollViewContentInsetAdjustmentNever];
    [self.view addSubview:self.tableView];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    for (NSString *cellclass in self.tableViewCellNames) {
        Class cell = NSClassFromString(cellclass);
        [self.tableView registerClass:cell];
    }

    WEAKSELF
    [CHNetRequest requestSuccess:^(id result) {
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
            return  10;
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
            height = 180;
            break;
        case CHViewControllerCellTypeSectionNews:
            height = 80;
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
            CHNewsTableViewCell *workCell = (CHNewsTableViewCell *)cell;
            workCell.title.text = @"学生作品sadfsadfsdaf";
            workCell.subTitle.text = @"sub zuopin";
            [workCell.mImageView sd_setImageWithURL:[NSURL URLWithString:@"https://timgsa.baidu.com/timg?image&quality=80&size=b9999_10000&sec=1536079410591&di=25c321a3c7fd74e561900dd038d42747&imgtype=0&src=http%3A%2F%2Fimgsrc.baidu.com%2Fimage%2Fc0%253Dshijue1%252C0%252C0%252C294%252C40%2Fsign%3Dcbd7355ba74bd11310c0bf7132c6ce7a%2F72f082025aafa40f48b91ff5a164034f78f0199e.jpg"]];
//            workCell.cardAnimationView.cardViewEntityList = [self.homePageModel.studentWork mutableCopy];
            break;
        }
        default:
            break;
    }
}


- (nullable UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section;   // custom view for header. will be adjusted to default or specified header height
{
    if (section == CHViewControllerCellTypeSectionNews) {
        UIView *view = [[UIView alloc]initWithFrame:CGRectMake(0, 5, 100, 20)];
        UILabel *label = [[UILabel alloc]initWithFrame:CGRectMake(12, 0, 100, 20)];
        label.text = @"校内新闻";
        label.font = [UIFont systemFontOfSize:16];
        [view addSubview:label];
        return view;
    }
    else return [[UIView alloc]initWithFrame:CGRectMake(0, 0, 0, 0)];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
