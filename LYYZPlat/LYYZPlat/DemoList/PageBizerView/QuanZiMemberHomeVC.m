//
//  QuanZiMemberHomeVC.m
//  screenBtnsDemo
//
//  Created by 龙学武 on 15/8/27.
//  Copyright (c) 2015年 林夕. All rights reserved.
//

#import "QuanZiMemberHomeVC.h"
#import "CellQZPostList.h"
#import "QuanZiAddFriendApplySendVC.h"

@interface QuanZiMemberHomeVC ()<UITableViewDataSource,UITableViewDelegate>

@property(nonatomic,strong)UITableView *tableView;

@property(nonatomic,strong)UIView *viewHeader;

@property(nonatomic,strong)UIImageView *imgvIcon;


@end


#define UIColorFromRGB(rgbValue) [UIColor colorWithRed:((float)((rgbValue & 0xFF0000) >> 16))/255.0 green:((float)((rgbValue & 0xFF00) >> 8))/255.0 blue:((float)(rgbValue & 0xFF))/255.0 alpha:1.0]


@implementation QuanZiMemberHomeVC{
    CGRect screenR;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    self.title = @"花千骨";


    screenR = [[UIScreen mainScreen] bounds];
    [self setNavigationConfigure];
    [self tableViewConfigure];

}

-(void)setNavigationConfigure{
    UIBarButtonItem *rBarItem = [[UIBarButtonItem alloc] initWithTitle:@"+ 加好友" style:UIBarButtonItemStylePlain target:self action:@selector(navItemAddFriend)];
    self.navigationItem.rightBarButtonItem = rBarItem;
}
-(void)navItemAddFriend{
    NSLog(@"点击过去添加好友");
    QuanZiAddFriendApplySendVC *_addFriendASVC = [[QuanZiAddFriendApplySendVC alloc] initWithNibName:@"QuanZiAddFriendApplySendVC" bundle:nil];
    [self.navigationController pushViewController:_addFriendASVC animated:YES];
}


-(void)tableViewConfigure{
    _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height-64) style:UITableViewStyleGrouped];
    _tableView.backgroundColor = [UIColor colorWithRed:245.0/255 green:245.0/255 blue:245.0/255 alpha:1];
    _tableView.dataSource = self;
    _tableView.delegate = self;

    _tableView.tableHeaderView = self.viewHeader;

    _tableView.sectionFooterHeight = 0;

    [self.view addSubview:_tableView];
}

-(UIView *)viewHeader{
    if (!_viewHeader) {
        _viewHeader = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, screenR.size.width, 164)];
        _viewHeader.backgroundColor = UIColorFromRGB(0xdfdfdf);


        _imgvIcon = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 65, 65)];
        _imgvIcon.backgroundColor = [UIColor greenColor];
        _imgvIcon.center = CGPointMake(_viewHeader.center.x, 60);
        [_viewHeader addSubview:_imgvIcon];

        UILabel *labelName =[[UILabel alloc] initWithFrame:CGRectMake(_imgvIcon.frame.origin.x, _imgvIcon.frame.origin.y+_imgvIcon.frame.size.height, _imgvIcon.frame.size.width, 30)];
        labelName.text = @"花千骨";
        labelName.font = [UIFont systemFontOfSize:14];
        labelName.textAlignment = NSTextAlignmentCenter;
        [_viewHeader addSubview:labelName];

        UIView *bottomBar = [self viewHeaderBottomBar];
        bottomBar.center = CGPointMake(_viewHeader.center.x, _viewHeader.frame.size.height-20);
        [_viewHeader addSubview:bottomBar];

    }
    return _viewHeader;
}

-(UIView *)viewHeaderBottomBar{
    UIView *bottomBar = [[UIView alloc] initWithFrame:CGRectMake(0, 0, screenR.size.width, 40)];
    bottomBar.backgroundColor = UIColorFromRGB(0x35a8fc);
    NSArray *_arrC = @[@[@"16",@"发帖"],@[@"237",@"回帖"],@[@"80",@"好友"]];
    for (int i=0; i<3; i++) {
        UILabel *labelUP = [[UILabel alloc] initWithFrame:CGRectMake(i*screenR.size.width/3, 5, screenR.size.width/3, 15)];
        UILabel *labelDow = [[UILabel alloc] initWithFrame:CGRectMake(i*screenR.size.width/3, 20, screenR.size.width/3, 20)];
        labelUP.textColor= labelDow.textColor = [UIColor whiteColor];
        labelUP.textAlignment = labelDow.textAlignment = NSTextAlignmentCenter;
        labelUP.font = [UIFont systemFontOfSize:12];
        labelDow.font = [UIFont systemFontOfSize:13];

        labelUP.text = _arrC[i][0];
        labelDow.text = _arrC[i][1];

        [bottomBar addSubview:labelUP];
        [bottomBar addSubview:labelDow];
    }
    return bottomBar;
}


-(CGFloat )tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 10;
}
-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    UIView *view = [[UIView alloc] initWithFrame:CGRectMake(-1, 0, self.view.frame.size.width+2, 10)];
    view.backgroundColor = [UIColor colorWithRed:245.0/255 green:245.0/255 blue:245.0/255 alpha:1];
    view.layer.borderColor = [UIColor colorWithRed:217.0/255 green:217.0/255 blue:217.0/255 alpha:1].CGColor;
    view.layer.borderWidth = 1;
    return view;
}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 10;
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
    return cell;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return [CellQZPostList cellQZPostHeigh];
}


-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
//    QuanZiPostDetailVC *_quanziPDVC = [[QuanZiPostDetailVC alloc] init];
//    [self.navigationController pushViewController:_quanziPDVC animated:YES];
}




@end
