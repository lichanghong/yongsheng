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
#import "UITableView+CHExtension.h"
#import "CHNetRequest.h"
#import "HomePageModel.h"
#import <YYModel.h>

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
                                @"CHCardAnimationTableViewCell"
                                ];
    self.tableView = [[UITableView alloc]initWithFrame:self.view.bounds style:UITableViewStylePlain];
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
            return  1;
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
            height = self.homePageModel.iconList.count>0?110:0;
            break;
        case CHViewControllerCellTypeSectionWorks:
            height = 180;
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
        default:
            break;
    }
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
