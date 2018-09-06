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

#define WEAKSELF __weak typeof(self) weakSelf = self;

@interface CHAliViewController ()<UITableViewDataSource,UITableViewDelegate>
@property (nonatomic,strong)UITableView *tableView;
@property (nonatomic,copy)NSArray *tableViewCellNames;

@end

@implementation CHAliViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    
    self.tableViewCellNames = @[
                                @"CHNewsTableViewCell"
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
    
    [CHNetRequest requestWithURL:API_Home_ali Success:^(id result) {
        //        weakSelf.homePageModel = [HomePageModel yy_modelWithJSON:result];
        //        [weakSelf.tableView reloadData];
    } failure:^(NSError *error) {
        
    }];
    
    // Do any additional setup after loading the view.
}


-  (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return CHAliViewControllerCellTypeSectionAll;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    switch (section) {
        case CHAliViewControllerCellTypeSectionType:
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
        case CHAliViewControllerCellTypeSectionType:
            height =  180;
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
        case CHAliViewControllerCellTypeSectionType:
        {
            CHNewsTableViewCell *news = (CHNewsTableViewCell *)cell;
            //赋值
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
