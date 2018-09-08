//
//  CHStudyViewController.m
//  yongshengMusic
//
//  Created by 李长鸿 on 2018/9/6.
//  Copyright © 2018 lichanghong. All rights reserved.
//

#import "CHStudyViewController.h"
#import "UITableView+CHExtension.h"
#import "CHNewsTableViewCell.h"
#import "CHHomeRouterModule.h"
#import "CHNetRequest.h"
#import "HomeCourceModel.h"
#import <YYModel.h>
#import <UIImageView+WebCache.h>

#define WEAKSELF __weak typeof(self) weakSelf = self;

@interface CHStudyViewController ()<UITableViewDataSource,UITableViewDelegate>
@property (nonatomic,strong)UITableView *tableView;
@property (nonatomic,copy)NSArray *tableViewCellNames;
@property (nonatomic,strong)HomeCourceModel *courceModel;

@end

@implementation CHStudyViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.tableViewCellNames = @[
                                @"CHNewsTableViewCell"
                                ];
    self.tableView = [[UITableView alloc]initWithFrame:self.view.bounds style:UITableViewStylePlain];
    [self.tableView setContentInsetAdjustmentBehavior:UIScrollViewContentInsetAdjustmentAutomatic];
    [self.view addSubview:self.tableView];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    for (NSString *cellclass in self.tableViewCellNames) {
        Class cell = NSClassFromString(cellclass);
        [self.tableView registerClass:cell];
    }
    
    WEAKSELF
    [CHNetRequest requestWithURL:API_Home_study Success:^(id result) {
        weakSelf.courceModel = [HomeCourceModel yy_modelWithJSON:result];
        [weakSelf.tableView reloadData];
    } failure:^(NSError *error) {
        
    }];
    
    // Do any additional setup after loading the view.
}

-  (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return CHStudyViewControllerCellTypeSectionAll;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    switch (section) {
        case CHStudyViewControllerCellTypeSectionType:
            return  self.courceModel.cource.count;
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
        case CHStudyViewControllerCellTypeSectionType:
            height =  self.courceModel.cource.count>0?90:0;
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
        case CHStudyViewControllerCellTypeSectionType:
        {
            HomeCourceItem *item = [self.courceModel.cource objectAtIndex:indexPath.row];
            CHNewsTableViewCell *workCell = (CHNewsTableViewCell *)cell;
            workCell.title.text = item.title;
            workCell.subTitle.text = item.subtitle;
            [workCell.mImageView sd_setImageWithURL:[NSURL URLWithString:item.img]];
            
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

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
