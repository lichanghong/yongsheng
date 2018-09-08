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
    [self.tableView setContentInsetAdjustmentBehavior:UIScrollViewContentInsetAdjustmentNever];
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
            height =  self.courceModel.cource.count>0?180:0;
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
            CHNewsTableViewCell *workCell = (CHNewsTableViewCell *)cell;
            workCell.title.text = @"学生作品sadfsadfsdaf";
            workCell.subTitle.text = @"sub zuopin";
            [workCell.mImageView sd_setImageWithURL:[NSURL URLWithString:@"https://timgsa.baidu.com/timg?image&quality=80&size=b9999_10000&sec=1536079410591&di=25c321a3c7fd74e561900dd038d42747&imgtype=0&src=http%3A%2F%2Fimgsrc.baidu.com%2Fimage%2Fc0%253Dshijue1%252C0%252C0%252C294%252C40%2Fsign%3Dcbd7355ba74bd11310c0bf7132c6ce7a%2F72f082025aafa40f48b91ff5a164034f78f0199e.jpg"]];
            
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
