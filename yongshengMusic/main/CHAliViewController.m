//
//  CHAliViewController.m
//  yongshengMusic
//
//  Created by 李长鸿 on 2018/9/6.
//  Copyright © 2018 lichanghong. All rights reserved.
//

#import "CHAliViewController.h"
#import "UITableView+CHExtension.h"
#import "CHNewsTableViewCell.h"
#import "CHHomeRouterModule.h"
#import "CHNetRequest.h"
#import "HomeAliModel.h"
#import <YYModel.h>
#import <UIImageView+WebCache.h>
#import "CHAliProductTableViewCell.h"

#define WEAKSELF __weak typeof(self) weakSelf = self;

@interface CHAliViewController ()<UITableViewDataSource,UITableViewDelegate>
@property (nonatomic,strong)UITableView *tableView;
@property (nonatomic,copy)NSArray *tableViewCellNames;
@property (nonatomic,strong)HomeAliModel *homeAliModel;

@end

@implementation CHAliViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    
    self.tableViewCellNames = @[
                                @"CHAliProductTableViewCell"
                                ];
    self.tableView = [[UITableView alloc]initWithFrame:self.view.bounds style:UITableViewStylePlain];
    [self.tableView setContentInsetAdjustmentBehavior:UIScrollViewContentInsetAdjustmentNever];
    [self.view addSubview:self.tableView];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    for (NSString *cellclass in self.tableViewCellNames) {
        Class cell = NSClassFromString(cellclass);
        [self.tableView registerClass:cell];
    }
    
    WEAKSELF
    [CHNetRequest requestWithURL:API_Home_ali Success:^(id result) {
        weakSelf.homeAliModel = [HomeAliModel yy_modelWithJSON:result];
        [weakSelf.tableView reloadData];
    } failure:^(NSError *error) {
        
    }];
    
    // Do any additional setup after loading the view.
}


-  (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
   return  self.homeAliModel.aliModel.count;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
  return  self.homeAliModel.aliModel.count>0?80:0;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSString *identifier = [self.tableViewCellNames objectAtIndex:indexPath.section];
    return [tableView dequeueReusableCellWithIdentifier:identifier forIndexPath:indexPath];
}

- (void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath
{
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    
    CHAliProductTableViewCell *aliCell = (CHAliProductTableViewCell *)cell;
    //赋值
    aliCell.aliItemEntity = [self.homeAliModel.aliModel objectAtIndex:indexPath.row];
    
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
