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
#import "UITableView+CHExtension.h"

@interface ViewController ()<UITableViewDataSource,UITableViewDelegate>
@property (nonatomic,strong)UITableView *tableView;
@property (nonatomic,copy)NSArray *tableViewCellNames;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.tableViewCellNames = @[
                                @"CHBannerTableViewCell",
                                @"CHToolsTableViewCell"
                                ];
    self.tableView = [[UITableView alloc]initWithFrame:self.view.bounds];
    [self.view addSubview:self.tableView];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    for (NSString *cellclass in self.tableViewCellNames) {
        Class cell = NSClassFromString(cellclass);
        [self.tableView registerClass:cell];
    }


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
            return 1;
            break;
        case CHViewControllerCellTypeSectionTools:
            return 1;
//            return self.categoryModel.live.list.count ? 1 : 0;
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
            height = 180;
            break;
        case CHViewControllerCellTypeSectionTools:
            height = 130;
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
//            SYHomeBannerTableViewCell * bannerCell = (SYHomeBannerTableViewCell *)cell;
            //赋值
            break;
        }
        case CHViewControllerCellTypeSectionTools:{
            CHToolsTableViewCell *tools = (CHToolsTableViewCell *)cell;
            tools.itemList = @[@"1",@"2"];
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
