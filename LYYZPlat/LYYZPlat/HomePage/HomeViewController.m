//
//  HomeViewController.m
//  LYYZPlat
//
//  Created by xw.long on 16/1/15.
//  Copyright © 2016年 xw.long. All rights reserved.
//

#import "HomeViewController.h"
#import "LYYZPlat-Swift.h"
#import "StructViewController.h"

@interface HomeViewController ()<UITableViewDataSource,UITableViewDelegate>

@property (nonatomic, strong) UIAlertController *alertController;
@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) NSMutableArray *arraySource;
@end


@implementation HomeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor redColor];
    
    

    [self.view addSubview:self.tableView];
    
    
    UIBarButtonItem *oneBarItem = [[UIBarButtonItem alloc] initWithTitle:@"SFT" style:UIBarButtonItemStylePlain target:self action:@selector(gotoSFTPage)];
    self.navigationItem.rightBarButtonItem = oneBarItem;
    
}

-(void)gotoSFTPage{
    SFTListViewController *sftLVC = [[SFTListViewController alloc] init];
    [self.navigationController pushViewController:sftLVC animated:YES];
}

-(void)viewWillAppear:(BOOL)animated{
    [self presentViewController:self.alertController animated:YES completion:nil];
    
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(2 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [self.alertController dismissViewControllerAnimated:YES completion:nil];
    });
}

-(UIAlertController *)alertController{
    if (!_alertController) {
        
        UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"起航的时候，你从最简单的页面，一夜一页翻阅，愿后浪破风沉，留得宁静在林夕" message:nil preferredStyle:UIAlertControllerStyleAlert];
        UIAlertAction *okAction = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
            
        }];
        [alertController addAction:okAction];
        _alertController = alertController;
    }
    
    return _alertController;
}







-(NSMutableArray *)arraySource{
    if (!_arraySource) {
        _arraySource = [NSMutableArray new];
        [_arraySource addObject:@"Struct-01"];
    }
    return _arraySource;
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
    return self.arraySource.count;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *identifier = @"itemIdentifier";
    UITableViewCell *cell = [tableView cellForRowAtIndexPath:indexPath];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
    }
    cell.accessoryType = UITableViewCellAccessoryDetailDisclosureButton;
    
    
    cell.textLabel.text = self.arraySource[indexPath.row];
    
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    if (indexPath.row == 0) {
       
        
        StructViewController *structvc = [[StructViewController alloc] init];
        [self presentViewController:structvc animated:YES completion:nil];


    }else if (indexPath.row == 1){

    }else if (indexPath.row == 2){

    }else if (indexPath.row == 3){

    }
}




@end
