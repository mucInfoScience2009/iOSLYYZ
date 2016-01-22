//
//  QuanZiMainListVC.m
//  screenBtnsDemo
//
//  Created by 龙学武 on 15/8/26.
//  Copyright (c) 2015年 林夕. All rights reserved.
//

#import "QuanZiMainListVC.h"
#import "QuanZiPostListVC.h"
#import "CellQZ.h"
#import "D_QZList.h"
#import "QuanZiDetailVC.h"
#import "QuanZiJoinApplyVC.h"

@interface QuanZiMainListVC ()<UITableViewDataSource,UITableViewDelegate>

@property(nonatomic,strong)UITableView *tableView;

@end

@implementation QuanZiMainListVC{
    NSMutableArray *_arrQZList;
    UIAlertView *_alertV;
    __block D_QZList *_tempDQZList;
}



-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];

    [self.tabBarController.tabBar setHidden:NO];
}

- (void)viewDidLoad {
    [super viewDidLoad];


    [self tableViewConfigure];


    [self netWorkGetQZList];

}

#define  k_nabBar_h 40

-(void)tableViewConfigure{
    _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0,k_nabBar_h*[UIScreen mainScreen].bounds.size.width/320, self.view.frame.size.width, self.view.frame.size.height-k_nabBar_h*[UIScreen mainScreen].bounds.size.width/320-45-64) style:UITableViewStylePlain];
    _tableView.dataSource = self;
    _tableView.delegate = self;
    if ([_tableView respondsToSelector:@selector(setSeparatorInset:)]) {
        [_tableView setSeparatorInset:UIEdgeInsetsMake(0,  0, 0, 0)];
    }
    if ([_tableView respondsToSelector:@selector(setLayoutMargins:)]) {
        [_tableView setLayoutMargins:UIEdgeInsetsZero];
    }
    [self.view addSubview:_tableView];


}


-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return _arrQZList.count;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *identifier = @"CFGYUIOL:M";
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
    QuanZiJoinApplyVC *_quanziJAVC = [[QuanZiJoinApplyVC alloc] init];
    _quanziJAVC.dQZList = d_QZList;
    _quanziJAVC.title = @"申请加入圈子";
    [self.navigationController pushViewController:_quanziJAVC animated:YES];
}


#pragma mark -  网络处理
//获取圈子列表
-(void)netWorkGetQZList{
//    DataInterface *_dIF = [[DataInterface alloc] initWithDelegate:self];
//    [_dIF CircleGetlistWithName:@"" andTag:@""];
    
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







