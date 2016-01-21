//
//  QuanZiSearchListVC.m
//  screenBtnsDemo
//
//  Created by 龙学武 on 15/8/26.
//  Copyright (c) 2015年 林夕. All rights reserved.
//

#import "QuanZiSearchListVC.h"

#import "DropDownDelegate.h"
#import "LDropDown.h"

#import "CellSocialCircle.h"
#import "SocialCircleVC.h"


@interface QuanZiSearchListVC ()<UISearchBarDelegate,UITableViewDataSource,UITableViewDelegate,DropDownChooseDataSource,DropDownDelegate>

@property(nonatomic,strong)UISearchBar *searchBar;

@property(nonatomic,strong)LDropDown *lDropDown;

@property(nonatomic,strong)UITableView *tableView;

@end

@implementation QuanZiSearchListVC{
    NSMutableArray *_arrChecKey;
}

- (void)viewDidLoad {
    [super viewDidLoad];

    self.view.backgroundColor = [UIColor redColor];

    [self navigationConfigure];

    [self dropDownConfigure];

    [self tableViewConfigure];

}

#define k_NabBar_H 40

-(void)dropDownConfigure{
    _arrChecKey = [NSMutableArray arrayWithArray:@[
                                                   @[@"羽毛球",@"乒乓球",@"篮球",@"足球",@"网球",@"排球",@"橄榄球",@"铅球",@"跑马场",@"其它",@"所有"],
                                                   @[@"雄霸",@"断浪",@"猎人王",@"聂风",@"步惊云",@"无名",@"剑圣"],
                                                   @[@"张居正",@"徐阶",@"严嵩",@"严世藩",@"王守仁"]
                                                   ]];

    _lDropDown = [[LDropDown alloc] initWithFrame:CGRectMake(0,0, self.view.frame.size.width,k_NabBar_H) dataSource:self delegate:self];
    _lDropDown.mSuperView = self.view;
    [_lDropDown setTitle:@"所有标签" inSection:0];
    [_lDropDown setTitle:@"所有分类" inSection:1];
    [_lDropDown setTitle:@"全部" inSection:2];

    [self.view addSubview:_lDropDown];
}

#pragma mark -- dropDownListDelegate
-(void) chooseAtSection:(NSInteger)section index:(NSInteger)index
{
    NSLog(@"选了section:%ld ,index:%ld ：%@",(long)section,(long)index,_arrChecKey[section][index]);
}

#pragma mark -- dropdownList DataSource
-(NSInteger)numberOfSections
{
    return [_arrChecKey count];
}

-(NSInteger)numberOfRowsInSection:(NSInteger)section
{
    if (section == 2) {
        return 0;
    }
    NSArray *arry =_arrChecKey[section];
    return [arry count];
}

-(NSString *)titleInSection:(NSInteger)section index:(NSInteger) index
{
    return _arrChecKey[section][index];
}

-(NSInteger)defaultShowSection:(NSInteger)section
{
    return 0;
}



-(void)navigationConfigure{
    _searchBar = [[UISearchBar alloc] initWithFrame:CGRectMake(0, 0, 250, 40)];
    _searchBar.barStyle = UISearchBarStyleDefault;
    _searchBar.delegate = self;
    _searchBar.placeholder = @"请输入关键词";
    self.navigationItem.titleView = _searchBar;

    UIBarButtonItem *lBarItem = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemUndo target:self action:@selector(navItemBack)];
    UIBarButtonItem *rBarItem = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemSearch target:self action:@selector(navItemSearch)];
    self.navigationItem.rightBarButtonItem = rBarItem;
    self.navigationItem.leftBarButtonItem = lBarItem;
}

-(void)navItemBack{
    [self.navigationController popToRootViewControllerAnimated:YES];
}

-(void)navItemSearch{
    NSLog(@"开始进行搜索");
}

#pragma UISearchBarDelegate
-(void)searchBar:(UISearchBar *)searchBar textDidChange:(NSString *)searchText{
    NSLog(@"%@",searchText);
}

-(BOOL)searchBarShouldBeginEditing:(UISearchBar *)searchBar{
    [self setSearchCancelTitle:@"取消"];
    return YES;
}

-(void)searchBarCancelButtonClicked:(UISearchBar *)searchBar{
    [searchBar resignFirstResponder];
    [self.navigationController popViewControllerAnimated:YES];
}

-(void)setSearchCancelTitle:(NSString *)title{
    for (UIView *view in [[_searchBar.subviews lastObject] subviews]) {
        if ([view isKindOfClass:[UIButton class]]) {
            UIButton *cancelBtn = (UIButton *)view;
            [cancelBtn setTitle:title forState:UIControlStateNormal];
            [cancelBtn setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
        }
    }
}


-(void)searchBarSearchButtonClicked:(UISearchBar *)searchBar{
    NSLog(@"searchBarSearchButtonClicked");
    [self.navigationController.view endEditing:YES];

}

-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event{
    [self.navigationController.view endEditing:YES];
}






#pragma mark - TableView;
static NSString *identifier = @"VHOP{";
-(void)tableViewConfigure{
    _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0,k_NabBar_H, self.view.frame.size.width, self.view.frame.size.height-k_NabBar_H-45-64) style:UITableViewStylePlain];
    _tableView.dataSource = self;
    _tableView.delegate = self;
    if ([_tableView respondsToSelector:@selector(setSeparatorInset:)]) {
        [_tableView setSeparatorInset:UIEdgeInsetsMake(0,  0, 0, 0)];
    }
    if ([_tableView respondsToSelector:@selector(setLayoutMargins:)]) {
        [_tableView setLayoutMargins:UIEdgeInsetsZero];
    }


    [_tableView registerNib:[UINib nibWithNibName:@"CellSocialCircle" bundle:nil] forCellReuseIdentifier:identifier];
    [self.view addSubview:_tableView];

}


-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 15;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    CellSocialCircle *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    cell.labelSubTitle.text = [NSString stringWithFormat:@"row->%ld",indexPath.row];
    if ([cell respondsToSelector:@selector(setSeparatorInset:)]) {
        [cell setSeparatorInset:UIEdgeInsetsZero];
    }
    if ([cell respondsToSelector:@selector(setLayoutMargins:)]) {
        [cell setLayoutMargins:UIEdgeInsetsZero];
    }

    return cell;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 100;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    NSLog(@"selected = %@",indexPath);
    SocialCircleVC *SVC = [[SocialCircleVC alloc] init];
    SVC.view.backgroundColor = [UIColor whiteColor];
    SVC.title = @"恒嗖++健康圈子";
    [self.navigationController pushViewController:SVC animated:YES];
    
}















@end
