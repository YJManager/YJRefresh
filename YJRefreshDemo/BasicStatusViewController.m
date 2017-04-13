//
//  BasicStatusViewController.m
//  YJRefreshDemo
//
//  Created by YJHou on 2017/4/11.
//  Copyright © 2017年 Houmanager. All rights reserved.
//

#import "BasicStatusViewController.h"

@interface BasicStatusViewController () <UITableViewDataSource, UITableViewDelegate>

@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) NSMutableArray *dataSources; /**< 数据源 */

@end

@implementation BasicStatusViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    [self _setUpBasicStatusNavgationView];
    [self _setUpBasicStatusMainView];
    [self _loadBasicStatusFormServer];
}

- (void)_setUpBasicStatusNavgationView{
    self.navigationItem.title = @"YJRefreshDemo";
}

- (void)_setUpBasicStatusMainView{
    [self.view addSubview:self.tableView];
    
    self.tableView.header_Refresh = [YJRefreshNormalHeader headerWithRefreshingBlock:^{
        [self refreshingData];
    }];
    
//    tableView.header_Refresh = [YJRefreshNormalHeader headerWithRefreshingTarget:self refreshingAction:@selector(refreshingData)];
    self.tableView.header_Refresh.automaticallyChangeAlpha = YES;
    
    self.tableView.yj_reloadDataBlock = ^(NSInteger total){
        NSLog(@"-->%ld", total);
    };
    


}

- (void)refreshingData{
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        
        for (NSInteger i = 0; i < 10; i++) {
            [self.dataSources addObject:[NSString stringWithFormat:@"第%ld行", i]];
        }
        
        [self.tableView reloadData];
        [self.tableView.header_Refresh stopRefreshing];
    });
}

-(void)_loadBasicStatusFormServer{
    
    [self.dataSources addObject:@"Demo"];
    
    [self.tableView reloadData];
}

#pragma mark - DataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.dataSources.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *cellId = @"cellId";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellId];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellId];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    
    cell.textLabel.text = [self.dataSources objectAtIndex:indexPath.row];
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
//    if (indexPath.row == 0) {
//        BasicStatusViewController *vc = [[BasicStatusViewController alloc] init];
//        [self.navigationController pushViewController:vc animated:YES];
//    }
    
}

#pragma mark - Lazy
- (UITableView *)tableView{
    if (!_tableView) {
        _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, kScreenHeight) style:UITableViewStylePlain];
        _tableView.dataSource = self;
        _tableView.delegate = self;
        _tableView.tableFooterView = [UIView new];
    }
    return _tableView;
}

- (NSMutableArray *)dataSources{
    if (!_dataSources) {
        _dataSources = [NSMutableArray array];
    }
    return _dataSources;
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
