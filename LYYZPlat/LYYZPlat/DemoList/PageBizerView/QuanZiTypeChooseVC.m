//
//  QuanZiTypeChooseVC.m
//  yijianbao
//
//  Created by 龙学武 on 15/9/1.
//  Copyright (c) 2015年 offen. All rights reserved.
//

#import "QuanZiTypeChooseVC.h"

@interface QuanZiTypeChooseVC ()<UITableViewDataSource,UITableViewDelegate>

@property(nonatomic,strong)UITableView *tableView;

@end

@implementation QuanZiTypeChooseVC{
    NSArray *_arrQuanziType;

    qzTypeClock _qztClock;
}

- (void)viewDidLoad {
    [super viewDidLoad];



    self.title = @"选择圈子类型";

    _arrQuanziType = [NSMutableArray arrayWithArray:@[@"汽车",@"娱乐",@"健康",@"家居生活",@"旅游",@"同乡",@"校友",@"科技数码",@"女性天地",@"经济",@"创业",@"社会万象",@"情感",@"其他"]];


    _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height-64) style:UITableViewStyleGrouped];
    _tableView.dataSource = self;
    _tableView.delegate = self;

    [self.view addSubview:_tableView];
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *identifier = @"CGHUIOL:";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
    }
    cell.textLabel.text = _arrQuanziType[indexPath.row];

    return cell;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return _arrQuanziType.count;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    if (_qztClock) {

        [self.navigationController popViewControllerAnimated:YES];

        _qztClock([NSDictionary dictionaryWithObjectsAndKeys:_arrQuanziType[indexPath.row],[NSNumber numberWithInteger:(indexPath.row+1)], nil]);
    }
}

-(void)qzTypeChoose:(qzTypeClock)thisClock{
    _qztClock = thisClock;
}

@end
