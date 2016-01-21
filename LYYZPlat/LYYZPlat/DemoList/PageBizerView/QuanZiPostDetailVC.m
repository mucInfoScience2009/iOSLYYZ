//
//  QuanZiPostDetailVC.m
//  screenBtnsDemo
//
//  Created by 龙学武 on 15/8/26.
//  Copyright (c) 2015年 林夕. All rights reserved.
//

#import "QuanZiPostDetailVC.h"
#import "CellQZPostContent.h"
#import "ViewMenuChild.h"
#import "QuanZiMemberHomeVC.h"

@interface QuanZiPostDetailVC ()<UITableViewDataSource,UITableViewDelegate>

@property(nonatomic,strong)UITableView *tableView;
@property(nonatomic,strong)UIView *viewHeader;

@property(nonatomic,strong)ViewMenuChild *viewMenuChild;

@end

#define UIColorFromRGB(rgbValue) [UIColor colorWithRed:((float)((rgbValue & 0xFF0000) >> 16))/255.0 green:((float)((rgbValue & 0xFF00) >> 8))/255.0 blue:((float)(rgbValue & 0xFF))/255.0 alpha:1.0]


@implementation QuanZiPostDetailVC{
    NSMutableArray *_arrTemp;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"帖子详情";
    self.view.backgroundColor = [UIColor whiteColor];

    [self navigationItemConfigure];

    [self viewMenuChildConfigure];

    [self tableViewConfigure];

    _arrTemp = [NSMutableArray arrayWithArray:@[@"我们都有一个家",@"我们名字叫中国hello你好，你好吗，你真的好吗我想知道你好吗，将看需要运动的插板报道",@"我们名字叫中国hello你好，你好吗，你真的好吗我想知道你好吗，将看需要运动的插板报道我们名字叫中国hello你好，你好吗，你真的好吗我想知道你好吗，将看需要运动的插板报道",@"我们名字叫中国hello你好，你好吗，你真的好吗我想知道你好吗，将看需要运动的插板报道我们名字叫中国hello你好，你好吗，你真的好吗我想知道你好吗，将看需要运动的插板报道我们名字叫中国hello你好，你好吗，你真的好吗我想知道你好吗，将看需要运动的插板报道",@"我们名字叫中国hello你好，你好吗，你真的好吗我想知道你好吗，将看需要运动的插板报道我们名字叫中国hello你好，你好吗，你真的好吗我想知道你好吗，将看需要运动的插板报道我们名字叫中国hello你好，你好吗，你真的好吗我想知道你好吗，将看需要运动的插板报道我们名字叫中国hello你好，你好吗，你真的好吗我想知道你好吗，将看需要运动的插板报道"]];
}


-(void)viewMenuChildConfigure{
    _viewMenuChild = [[ViewMenuChild alloc] initWithFrame:CGRectMake(self.view.frame.size.width-150, 0, 150, 132)];
    _viewMenuChild.arrItems = @[@"只看楼主",@"收藏贴子",@"举报帖子"];
    _viewMenuChild.hidden = YES;
    [self.view addSubview:_viewMenuChild];

    __block ViewMenuChild *weekVMC = _viewMenuChild;
    _viewMenuChild.VMenuCClock = ^(NSInteger index){
        NSLog(@"%@",weekVMC.arrItems[index]);
    };
}

-(void)navigationItemConfigure{
    UIBarButtonItem *rItemOne = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemRewind target:self action:@selector(navigationBarItemClick:)];
    rItemOne.tag = 2;
    UIBarButtonItem *rItemTwo = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemOrganize target:self action:@selector(navigationBarItemClick:)];
    rItemTwo.tag = 1;

    self.navigationItem.rightBarButtonItems = @[rItemOne,rItemTwo];
}


-(void)navigationBarItemClick:(UIBarButtonItem *)bItem{
    if (bItem.tag == 1) {
        NSLog(@"分享");
    }else if (bItem.tag == 2){
        NSLog(@"查看更多");
        if (_viewMenuChild.hidden) {
            [self.view bringSubviewToFront:_viewMenuChild];
            _viewMenuChild.hidden = NO;
        }else{
            _viewMenuChild.hidden = YES;
        }
    }
}


-(void)tableViewConfigure{
    _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height-64) style:UITableViewStyleGrouped];
    _tableView.backgroundColor = [UIColor colorWithRed:245.0/255 green:245.0/255 blue:245.0/255 alpha:1];
    _tableView.dataSource = self;
    _tableView.delegate = self;
    _tableView.tableHeaderView = self.viewHeader;
    _tableView.sectionFooterHeight = 0;
    _tableView.separatorColor = UIColorFromRGB(0xd9d9d9);
    if ([_tableView respondsToSelector:@selector(setSeparatorInset:)]) {
        [_tableView setSeparatorInset:UIEdgeInsetsZero];
    }
    if ([_tableView respondsToSelector:@selector(setLayoutMargins:)]) {
        [_tableView setLayoutMargins:UIEdgeInsetsZero];
    }

    [self.view addSubview:_tableView];
}

-(UIView *)viewHeader{
    if (!_viewHeader) {
        _viewHeader = [[UIView alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, 66)];
        _viewHeader.backgroundColor = [UIColor whiteColor];

        UILabel *labelTitle = [[UILabel alloc] initWithFrame:CGRectMake(10,0,50, 33)];
        labelTitle.textColor = [UIColor grayColor];
        labelTitle.font = [UIFont systemFontOfSize:15];
        labelTitle.text = @"来自：";
        [_viewHeader addSubview:labelTitle];

        UILabel *label_QuanZi = [[UILabel alloc] initWithFrame:CGRectMake(labelTitle.frame.origin.x+labelTitle.frame.size.width, 0, 234, 33)];
        label_QuanZi.textColor = [UIColor darkTextColor];
        label_QuanZi.text = @"北大社交圈";
        [_viewHeader addSubview:label_QuanZi];

        UIView *cLine = [[UIView alloc] initWithFrame:CGRectMake(0, 33, _viewHeader.frame.size.width, 0.5)];
        cLine.backgroundColor = UIColorFromRGB(0xd9d9d9);
        [_viewHeader addSubview:cLine];

        UILabel *label_Desc = [[UILabel alloc] initWithFrame:CGRectMake(10, 34, _viewHeader.frame.size.width-20, 30)];
        label_Desc.textColor =[UIColor darkGrayColor];
        label_Desc.text = @"北大青鸟中关村学士后本部：全力打造复合型IT人";
        [_viewHeader addSubview:label_Desc];

//        UIView *dLine = [[UIView alloc] initWithFrame:CGRectMake(0, 62, _viewHeader.frame.size.width, 1)];
//        dLine.backgroundColor = [UIColor lightGrayColor];
//        [_viewHeader addSubview:dLine];

    }
    return _viewHeader;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return _arrTemp.count;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString * identifer = @"VIOP:";
    CellQZPostContent *cell = [tableView dequeueReusableCellWithIdentifier:identifer];
    if (!cell) {
        cell = [[CellQZPostContent alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifer];
    }
    if ([cell respondsToSelector:@selector(setSeparatorInset:)]) {
        [cell setSeparatorInset:UIEdgeInsetsZero];
    }
    if ([cell respondsToSelector:@selector(setLayoutMargins:)]) {
        [cell setLayoutMargins:UIEdgeInsetsZero];
    }

    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    [cell cellQZPostContent:^(id thisObj) {
        NSLog(@"%@",thisObj);
        QuanZiMemberHomeVC *quanziMHVC = [[QuanZiMemberHomeVC alloc] init];
        [self.navigationController pushViewController:quanziMHVC animated:YES];
    }];
    cell.testStr = _arrTemp[indexPath.row];
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    NSLog(@"选中XXXX发布的帖子回复");

}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return [CellQZPostContent heightForCellWithDescription:_arrTemp[indexPath.row]];
}


@end
