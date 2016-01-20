//
//  PartOneViewController.m
//  LYYZPlat
//
//  Created by xw.long on 16/1/16.
//  Copyright © 2016年 xw.long. All rights reserved.
//

#import "PartOneViewController.h"
#import "WeatherHomeViewController.h"
#import "HudDemoViewController.h"

@interface PartOneViewController ()<UITableViewDataSource,UITableViewDelegate>

@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) NSMutableArray *arraySoure;

@end

@implementation PartOneViewController


-(void)viewWillAppear:(BOOL)animated{
    [self.tabBarController.tabBar setHidden:NO];
}
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor =  RGBCOLOR(120,210,100);


    [self.view addSubview:self.tableView];


   
}

-(NSMutableArray *)arraySoure{
    if (!_arraySoure) {
        _arraySoure = [NSMutableArray array];
        [_arraySoure insertObject:@"WeatherForcast" atIndex:0];
        [_arraySoure insertObject:@"MBProgress" atIndex:1];
    }
    return _arraySoure;
}


-(UITableView *)tableView{
    if (!_tableView) {
        _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, k_SizeScreen.width,k_SizeScreen.height) style:UITableViewStylePlain];
        _tableView.dataSource   = self;
        _tableView.delegate     = self;
    }
    return _tableView;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.arraySoure.count;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *identifier = @"itemIdentifier";
    UITableViewCell *cell = [tableView cellForRowAtIndexPath:indexPath];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
    }
    cell.accessoryType = UITableViewCellAccessoryDetailDisclosureButton;
    

    cell.textLabel.text = self.arraySoure[indexPath.row];

    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    if (indexPath.row == 0) {
        WeatherHomeViewController *weatherHomeVC = [[WeatherHomeViewController alloc] init];
        [self.navigationController pushViewController:weatherHomeVC animated:YES];
    }else if (indexPath.row == 1){
        HudDemoViewController *hudDemoVC = [[HudDemoViewController alloc] initWithNibName:@"HudDemoViewController" bundle:nil];
        [self.navigationController pushViewController:hudDemoVC animated:YES];
    }
}






@end
