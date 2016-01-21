//
//  QuanZiPostListVC.m
//  screenBtnsDemo
//
//  Created by 龙学武 on 15/8/26.
//  Copyright (c) 2015年 林夕. All rights reserved.
//

#import "QuanZiPostListVC.h"
#import "CellQZPostList.h"
#import "QuanZiPostDetailVC.h"
#import "QuanZiPostVC.h"
#import "QuanZiDetailVC.h"
#import "QuanZiJoinApplyVC.h"
#import "D_QZPostList.h"

@interface QuanZiPostListVC ()<UITableViewDataSource,UITableViewDelegate>

@property(nonatomic,strong)UITableView *tableView;

@property(nonatomic,strong)UIView *viewHeader;
@property(nonatomic,strong)UIImageView *imgvIcon;//头像


@property(nonatomic,strong)UILabel *labelMemberNo;//圈子人数
@property(nonatomic,strong)UILabel *labelPostNo;//帖子数
@property(nonatomic,strong)UIButton *btnRightUP;//右上角操作按钮

@end

@implementation QuanZiPostListVC{
    UIAlertView *_alertV;
    NSMutableArray *_arrPostList;
}


-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [self.tabBarController.tabBar setHidden:YES];
}
-(void)viewWillDisappear:(BOOL)animated{
    [self.tabBarController.tabBar setHidden:NO];
}


- (void)viewDidLoad {
    [super viewDidLoad];

    [self setNavigationConfigure];

    [self tableViewConfigure];


    [self netGetPostList];
}

-(void)setNavigationConfigure{
    UIBarButtonItem *rBarItem = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemEdit target:self action:@selector(navItemSearch)];
    self.navigationItem.rightBarButtonItem = rBarItem;
}
-(void)navItemSearch{
    NSLog(@"点击发布帖子");
    QuanZiPostVC *_quanziPVC = [[QuanZiPostVC alloc] init];
    [self.navigationController pushViewController:_quanziPVC animated:YES];
}


-(void)tableViewConfigure{
    _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height-64) style:UITableViewStyleGrouped];
    _tableView.backgroundColor = [UIColor colorWithRed:245.0/255 green:245.0/255 blue:245.0/255 alpha:1];
    _tableView.dataSource = self;
    _tableView.delegate = self;
    _tableView.separatorStyle = UITableViewCellSelectionStyleNone;

    _tableView.tableHeaderView = self.viewHeader;

    _tableView.sectionFooterHeight = 0;

    [self.view addSubview:_tableView];
}


-(UIView *)viewHeader{
    if (!_viewHeader) {
        _viewHeader = [[UIView alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, 27+k_SizeIconBig_60)];
        _viewHeader.backgroundColor = [UIColor whiteColor];

        _imgvIcon = [[UIImageView alloc] initWithFrame:CGRectMake(15, 12, k_SizeIconBig_60, k_SizeIconBig_60)];
        _imgvIcon.backgroundColor = [UIColor greenColor];
        _imgvIcon.image = [UIImage imageNamed:@"faceImg"];
        [_viewHeader addSubview:_imgvIcon];


//        圈子人数
        UIImageView *imgvNumberPerson = [[UIImageView alloc] initWithFrame:CGRectMake(_imgvIcon.frame.origin.x+_imgvIcon.frame.size.width+10, _imgvIcon.center.y-25*k_ratio, k_SizeIconSmall_14, k_SizeIconSmall_14)];
        imgvNumberPerson.image = [UIImage imageNamed:@"icon_quanzi_member"];
        [_viewHeader addSubview:imgvNumberPerson];

        UILabel *labelNumberPerson = [[UILabel alloc] initWithFrame:CGRectMake(imgvNumberPerson.frame.origin.x+imgvNumberPerson.frame.size.width+2, imgvNumberPerson.frame.origin.y, 80, 12)];
        labelNumberPerson.textColor = k_FontColor_66;
        labelNumberPerson.font = [UIFont systemFontOfSize:k_CellFontSmall_13];
        labelNumberPerson.text = [NSString stringWithFormat:@"%@ 人",_dQZList.user_num];
        self.labelMemberNo = labelNumberPerson;
        [_viewHeader addSubview:labelNumberPerson];

        UIImageView *imgvNumberPost = [[UIImageView alloc] initWithFrame:CGRectMake(_viewHeader.frame.size.width/2, imgvNumberPerson.frame.origin.y, 12, 12)];
        imgvNumberPost.image = [UIImage imageNamed:@"icon_quanzi_post"];
        [_viewHeader addSubview:imgvNumberPost];
        UILabel *labelNumberPost = [[UILabel alloc] initWithFrame:CGRectMake(_viewHeader.frame.size.width/2+imgvNumberPerson.frame.size.width+2, imgvNumberPost.frame.origin.y, 80, 12)];
        labelNumberPost.textColor = k_FontColor_66;
        labelNumberPost.font = [UIFont systemFontOfSize:k_CellFontSmall_13];
        self.labelPostNo = labelNumberPost;
        labelNumberPost.text =[NSString stringWithFormat:@"%@",_dQZList.con_num];
        [_viewHeader addSubview:labelNumberPost];


        //        圈子详情按钮
        UIButton *btnDetail = [UIButton buttonWithType:UIButtonTypeRoundedRect];
        [btnDetail setFrame:CGRectMake(_imgvIcon.frame.origin.x+_imgvIcon.frame.size.width+10,_imgvIcon.center.y+5, _imgvIcon.center.y+8*k_ratio, 22*k_ratio)];
        btnDetail.layer.cornerRadius = btnDetail.frame.size.height*0.2;
        btnDetail.layer.borderColor = k_FontColor_35a8fc.CGColor;
        btnDetail.layer.borderWidth = 1;
        btnDetail.titleLabel.text = @"圈详情";
        [btnDetail setTitle:@"圈详情" forState:UIControlStateNormal];
        btnDetail.titleLabel.font = [UIFont systemFontOfSize:k_CellFontSmall_13];
        [btnDetail setTitleColor:k_FontColor_35a8fc forState:UIControlStateNormal];
        [btnDetail addTarget:self action:@selector(btnQuanziDetail:) forControlEvents:UIControlEventTouchUpInside];
        [_viewHeader addSubview:btnDetail];


//        如果没有加入圈子，显示的加入圈子图标
        UIButton *btnJoin = [UIButton buttonWithType:UIButtonTypeRoundedRect];
        _btnRightUP = btnJoin;
//        btnJoin.layer.borderColor = [UIColor lightGrayColor].CGColor;
//        btnJoin.layer.borderWidth = 1;
//        btnJoin.layer.cornerRadius = 2;
        btnJoin.frame = CGRectMake(_viewHeader.frame.size.width-10-22, 15, 22, 22);
//        [btnJoin setContentEdgeInsets:UIEdgeInsetsMake(2, 2, 6, 2)];
        [btnJoin addTarget:self action:@selector(btnJoinQuanzi:) forControlEvents:UIControlEventTouchUpInside];
//        [btnJoin setTitle:@"+" forState:UIControlStateNormal];
        [_viewHeader addSubview:btnJoin];

    }
    return _viewHeader;
}


-(void)btnQuanziDetail:(UIButton *)btn{
    NSLog(@"点击进入圈子详情");
    QuanZiDetailVC *quanziDVC = [[QuanZiDetailVC alloc] init];
    quanziDVC.dQZList = _dQZList;
    [self.navigationController pushViewController:quanziDVC animated:YES];
}

-(void)btnJoinQuanzi:(UIButton *)btn{
//    NSLog(@"点击加入圈子");
    if ([_dQZList.is_pwd integerValue]) {
        //申请加入私密圈子
        [self gotoApplyJoinZQ:_dQZList];

    }else if ([_dQZList.is_circle integerValue]==0) {
        //加入公开圈子
        [self netApplyJoinQZ:[_dQZList.ID integerValue]];
    }
}



-(CGFloat )tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 10;
}
-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    UIView *view = [[UIView alloc] initWithFrame:CGRectMake(-1, 0, self.view.frame.size.width+2, 10)];
    view.backgroundColor = RGBCOLOR_HEX(0xf5f5f5);
    view.layer.borderColor = RGBCOLOR_HEX(0xd9d9d9).CGColor;
    view.layer.borderWidth = 1;
    return view;
}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return _arrPostList.count;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 1;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *identifier = @"VGIOP";
    CellQZPostList *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    if (!cell) {
        cell = [[CellQZPostList alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
    }
    cell.dqzPost = _arrPostList[indexPath.section];


    return cell;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return [CellQZPostList cellQZPostHeigh];
}


-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    QuanZiPostDetailVC *_quanziPDVC = [[QuanZiPostDetailVC alloc] init];
    [self.navigationController pushViewController:_quanziPDVC animated:YES];
}


-(void)setDQZList:(D_QZList *)dQZList{
    _dQZList = dQZList;
    self.title =_dQZList.name;
    self.labelMemberNo.text = [NSString stringWithFormat:@"%@ 人",_dQZList.user_num];
    self.labelPostNo.text = [NSString stringWithFormat:@"%@",_dQZList.con_num];
    
    if ([_dQZList.is_pwd integerValue]) {
        [_btnRightUP setBackgroundImage:[UIImage imageNamed:@"icon_quanzi_lock"] forState:UIControlStateNormal];
    }else if([_dQZList.is_circle integerValue]==0){
        [_btnRightUP setBackgroundImage:[UIImage imageNamed:@"icon_quanzi_add"] forState:UIControlStateNormal];
    }else{
        [_btnRightUP setHidden:YES];
    }
}



-(void)gotoApplyJoinZQ:(D_QZList *)d_QZList{
    QuanZiJoinApplyVC *_quanziJAVC = [[QuanZiJoinApplyVC alloc] init];
    _quanziJAVC.dQZList = d_QZList;
    _quanziJAVC.title = @"申请加入圈子";
    [self.navigationController pushViewController:_quanziJAVC animated:YES];
}


//申请加入圈子
-(void)netApplyJoinQZ:(NSInteger)cid{
//    DataInterface *_dIF = [[DataInterface alloc] initWithDelegate:self];
//    [_dIF CircleUserAddWithCid:cid];
}

/*
 请求参数：
	cid ：圈子id必填参数
*/
-(void)netGetPostList{

//    DataInterface *_dIF = [[DataInterface alloc] initWithDelegate:self];
//    if (![self.dQZList.ID integerValue]) {
//        self.dQZList.ID = @"1";
//        [_dIF CircleConListWithCid:1];
//    }else{
//        [_dIF CircleConListWithCid:[_dQZList.ID integerValue]];
//    }
}

#if 0
-(void)dataInterfaceRequestFinishedWithReturnStatus:(NSInteger)status andResult:(NSDictionary *)result andType:(NSString *)type{

    NSLog(@"type = %@,%@",type,[result objectForKey:@"msg"]);
    NSInteger netStatus = [[result objectForKey:@"status"] integerValue];

    if (netStatus) {
        NSLog(@"获取数据成功");
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


    if ([type isEqualToString:CIRCLE_CONLIST]) {
        if (netStatus == 0) {

        }
        NSDictionary *dictData = [result objectForKey:@"data"];
        if ([dictData isKindOfClass:[NSDictionary class]]) {
            NSArray *con_list = [dictData objectForKey:@"con_list"];
            if(!_arrPostList) _arrPostList = [NSMutableArray array];

            for (NSDictionary *dictPost in con_list) {
                D_QZPostList *dqzPost = [D_QZPostList new];
                [dqzPost setValuesForKeysWithDictionary:dictPost];

                [_arrPostList addObject:dqzPost];
            }

            [self.tableView reloadData];
        }
    }
}

#endif

-(void)alertViewDismiss{
    [_alertV dismissWithClickedButtonIndex:0 animated:YES];

    _dQZList.is_circle = @"1";

    [self.tableView reloadData];
    QuanZiDetailVC *quanziDVC = [[QuanZiDetailVC alloc] init];
    quanziDVC.dQZList = _dQZList;
    [self.navigationController pushViewController:quanziDVC animated:YES];

}





@end




