//
//  QuanZiMineListVC.m
//  screenBtnsDemo
//
//  Created by 龙学武 on 15/8/26.
//  Copyright (c) 2015年 林夕. All rights reserved.
//

#import "QuanZiMineListVC.h"
#import "QuanZiCreateVC.h"
#import "QuanZiPostListVC.h"
#import "QuanZiJoinApplyVC.h"
#import "QuanZiDetailVC.h"
#import "CellQZ.h"

@interface QuanZiMineListVC ()<UITableViewDataSource,UITableViewDelegate>

@property(nonatomic,strong)UITableView *tableView;
@property(nonatomic,strong)UIView *viewHeader;
@property(nonatomic,strong)UIButton *btnCreateG;

@end



#define UIColorFromRGB(rgbValue) [UIColor colorWithRed:((float)((rgbValue & 0xFF0000) >> 16))/255.0 green:((float)((rgbValue & 0xFF00) >> 8))/255.0 blue:((float)(rgbValue & 0xFF))/255.0 alpha:1.0]


@implementation QuanZiMineListVC{
    NSMutableArray *_arrQZList;
    UIAlertView *_alertV;
    __block D_QZList *_tempDQZList;
}


-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
}

- (void)viewDidLoad {
    [super viewDidLoad];


    UIBarButtonItem *item = [[UIBarButtonItem alloc] init];
    [item setTitle:@""];
    self.navigationItem.backBarButtonItem = item;


    [self tableViewConfigure];


    [self netWorkGetQZList];
}


#define k_nabBar_h 40
-(void)tableViewConfigure{
    _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0,k_nabBar_h*[UIScreen mainScreen].bounds.size.width/320, self.view.frame.size.width, self.view.frame.size.height-k_nabBar_h*[UIScreen mainScreen].bounds.size.width/320-45-64) style:UITableViewStylePlain];
    _tableView.dataSource = self;
    _tableView.delegate = self;
    _tableView.separatorColor =  UIColorFromRGB(0xd9d9d9);
    _tableView.separatorInset = UIEdgeInsetsMake(1, 1, 1, 1);

    if ([_tableView respondsToSelector:@selector(setSeparatorInset:)]) {
        [_tableView setSeparatorInset:UIEdgeInsetsMake(0,  0, 0, 0)];
    }
    if ([_tableView respondsToSelector:@selector(setLayoutMargins:)]) {
        [_tableView setLayoutMargins:UIEdgeInsetsZero];
    }
    [self.view addSubview:_tableView];
}




#pragma mark - TableViewDatasource and  Delegate


-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 45*k_ratio;
}
-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    if (!_viewHeader) {
        _viewHeader = [[UIView alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, 45*k_ratio)];
        _viewHeader.backgroundColor = [UIColor whiteColor];


        _btnCreateG = [UIButton buttonWithType:UIButtonTypeRoundedRect];
        _btnCreateG.frame = CGRectMake(0, 0, 79*k_ratio,23*k_ratio);
        _btnCreateG.center = _viewHeader.center;
        [_btnCreateG setBackgroundImage:[UIImage imageNamed:@"btn_quanzi_create"] forState:UIControlStateNormal];
        [_btnCreateG addTarget:self action:@selector(groupCreate:) forControlEvents:UIControlEventTouchUpInside];
        [_viewHeader addSubview:_btnCreateG];

        UIView *dLine = [[UIView alloc] initWithFrame:CGRectMake(0, _viewHeader.frame.size.height-1, _viewHeader.frame.size.width, 0.6)];
        dLine.backgroundColor = UIColorFromRGB(0xd9d9d9);
        [_viewHeader addSubview:dLine];
    }
    return _viewHeader;
}

//创建圈子
-(void)groupCreate:(UIButton *)btn{
    NSLog(@"创建圈子");

    QuanZiCreateVC *_quanziCVC = [[QuanZiCreateVC alloc] init];
    [self.navigationController pushViewController:_quanziCVC animated:YES];

}



-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return _arrQZList.count;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *identifier = @"VHOP{";
    CellQZ *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    if (!cell) {
        cell = [[CellQZ alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
    }

    if ([cell respondsToSelector:@selector(setSeparatorInset:)]) {
        [cell setSeparatorInset:UIEdgeInsetsZero];
    }
    if ([cell respondsToSelector:@selector(setLayoutMargins:)]) {
        [cell setLayoutMargins:UIEdgeInsetsZero];
    }

    D_QZList * dQZ = _arrQZList[indexPath.row];
    cell.dQZList = dQZ;

    [cell cellQZClock:^(D_QZList *dQZList) {
        if ([dQZList.is_pwd integerValue]) {
            //申请加入私密圈子
            _tempDQZList = dQZList;
            [self gotoApplyJoinZQ:dQZList];

        }else if ([dQZList.is_circle integerValue]==0) {
            //加入公开圈子
            _tempDQZList = dQZList;
            [self netApplyJoinQZ:[_tempDQZList.ID integerValue]];
        }
    }];

    return cell;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return [CellQZ cellH];
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];

    CellQZ *cell = (CellQZ *)[tableView cellForRowAtIndexPath:indexPath];

    NSLog(@"selected = %@",indexPath);
    QuanZiPostListVC *quanziPLVC = [[QuanZiPostListVC alloc] init];
    //    quanziPLVC.hidesBottomBarWhenPushed =YES;
    quanziPLVC.view.backgroundColor = [UIColor whiteColor];
    quanziPLVC.dQZList = cell.dQZList;
    [self.navigationController pushViewController:quanziPLVC animated:YES];
}


-(void)gotoApplyJoinZQ:(D_QZList *)d_QZList{
    QuanZiJoinApplyVC *_quanziJAVC = [[QuanZiJoinApplyVC alloc] initWithNibName:@"QuanZiJoinApplyVC" bundle:nil];
    _quanziJAVC.dQZList = d_QZList;
    _quanziJAVC.title = @"申请加入圈子";
    [self.navigationController pushViewController:_quanziJAVC animated:YES];
}

#pragma mark -  网络处理

//获取圈子列表
-(void)netWorkGetQZList{
    if (!_arrQZList) _arrQZList = [NSMutableArray array];
    [_arrQZList removeAllObjects];
    for (int i=0; i< arc4random()%10+2; i++) {
        D_QZList *dQZ = [D_QZList new];
        dQZ.con_num         = [NSString stringWithFormat:@"%d",i];
        dQZ.content         = [NSString stringWithFormat:@"%d",i];
        dQZ.create_time     = [NSString stringWithFormat:@"%d",i];
        dQZ.id              = [NSString stringWithFormat:@"%d",i];
        dQZ.img             = [NSString stringWithFormat:@"%d",i];
        dQZ.img_str         = [NSString stringWithFormat:@"%d",i];
        dQZ.name            = [NSString stringWithFormat:@"%d",i];
        dQZ.uid             = [NSString stringWithFormat:@"%d",i];
        dQZ.is_circle       = [NSString stringWithFormat:@"%d",i];
        dQZ.is_pwd          = [NSString stringWithFormat:@"%d",i];
        dQZ.user_img        = [NSString stringWithFormat:@"%d",i];
        dQZ.user_num        = [NSString stringWithFormat:@"%d",i];
        dQZ.username        = [NSString stringWithFormat:@"%d",i];
        [_arrQZList addObject:dQZ];
    }
    [self.tableView reloadData];
}

//申请加入圈子
-(void)netApplyJoinQZ:(NSInteger)cid{
//    DataInterface *_dIF = [[DataInterface alloc] initWithDelegate:self];
//    [_dIF CircleUserAddWithCid:cid];
}

#if 0
-(void)dataInterfaceRequestFinishedWithReturnStatus:(NSInteger)status andResult:(NSDictionary *)result andType:(NSString *)type{

    NSLog(@"type = %@,%@",type,[result objectForKey:@"msg"]);
    NSInteger netStatus = [[result objectForKey:@"status"] integerValue];

    if (netStatus) {
        NSLog(@"获取数据成功");
    }

    if ([type isEqualToString:CIRCLE_GETLIST])
    {
        if (netStatus==0) {
            return;
        }

        NSArray *arrData = [result objectForKey:@"data"];
        if (arrData.count)
        {
            if (!_arrQZList) _arrQZList = [NSMutableArray array];
            [_arrQZList removeAllObjects];
            for (NSDictionary *qzDict in arrData)
            {
                D_QZList *dQZ = [D_QZList new];
                [dQZ setValuesForKeysWithDictionary:qzDict];

                [_arrQZList addObject:dQZ];
            }

            [self.tableView reloadData];
        }
    }

    if ([type isEqualToString:CIRCLE_USERADD])
    {
        if (netStatus==0 ) {
            UIAlertView *alertV = [[UIAlertView alloc] initWithTitle:[result objectForKey:@"msg"] message:nil delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil];
            [alertV show];
            return;
        }
        NSArray *arrData = [result objectForKey:@"data"];
        if (arrData.count) {

        }
        _alertV = [[UIAlertView alloc] initWithTitle:@"恭喜您，已经成功加入" message:nil delegate:nil cancelButtonTitle:nil otherButtonTitles:nil, nil];
        [_alertV show];

        [self performSelector:@selector(alertViewDismiss) withObject:self afterDelay:2.0];
    }

}
#endif

-(void)alertViewDismiss{
    [_alertV dismissWithClickedButtonIndex:0 animated:YES];

    _tempDQZList.is_circle = @"1";

    [self.tableView reloadData];
    QuanZiDetailVC *quanziDVC = [[QuanZiDetailVC alloc] init];
    quanziDVC.dQZList = _tempDQZList;
    [self.navigationController pushViewController:quanziDVC animated:YES];
    
}



@end
