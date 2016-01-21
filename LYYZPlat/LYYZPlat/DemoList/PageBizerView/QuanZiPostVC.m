//
//  QuanZiPostVC.m
//  screenBtnsDemo
//
//  Created by 龙学武 on 15/8/27.
//  Copyright (c) 2015年 林夕. All rights reserved.
//

#import "QuanZiPostVC.h"

@interface QuanZiPostVC ()<UITableViewDataSource,UITableViewDelegate>

@property(nonatomic,strong)UITableView *tableView;

@property(nonatomic,strong)UIView *viewHeader;
@property(nonatomic,strong)UIView *viewFooter;

@property(nonatomic,strong)UITextView *tviewContent;



@end


#define UIColorFromRGB(rgbValue) [UIColor colorWithRed:((float)((rgbValue & 0xFF0000) >> 16))/255.0 green:((float)((rgbValue & 0xFF00) >> 8))/255.0 blue:((float)(rgbValue & 0xFF))/255.0 alpha:1.0]



@implementation QuanZiPostVC{
    CGRect screenR;
}

- (void)viewDidLoad {
    [super viewDidLoad];

    self.view.backgroundColor =[UIColor whiteColor];
    screenR = [UIScreen mainScreen].bounds;

    [self navigationItemConfigure];
    [self tableViewConfigure];
}

-(void)navigationItemConfigure{
    self.title = @"新帖";

    UIBarButtonItem *rBarItem = [[UIBarButtonItem alloc] initWithTitle:@"完成" style:UIBarButtonItemStylePlain target:self action:@selector(navItemSearch)];
    self.navigationItem.rightBarButtonItem = rBarItem;
}

-(void)navItemSearch{
    NSLog(@"点击发布帖子王城");
}

-(void)tableViewConfigure{
    _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height-64) style:UITableViewStyleGrouped];
    _tableView.backgroundColor = [UIColor colorWithRed:245.0/255 green:245.0/255 blue:245.0/255 alpha:1];
    _tableView.dataSource = self;
    _tableView.delegate = self;
    _tableView.tableHeaderView = self.viewHeader;
    _tableView.tableFooterView = self.viewFooter;
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
        _viewHeader = [[UIView alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, 39+43)];
        _viewHeader.backgroundColor = [UIColor whiteColor];

        UILabel *labelSend = [[UILabel alloc] initWithFrame:CGRectMake(10,0,50, 38)];
        labelSend.textColor = UIColorFromRGB(0x1a1a1a);
        labelSend.font = [UIFont systemFontOfSize:k_CellFontBig_15];
        labelSend.text = @"发送到";
        [_viewHeader addSubview:labelSend];

        UILabel *label_QuanZi = [[UILabel alloc] initWithFrame:CGRectMake(labelSend.frame.origin.x+labelSend.frame.size.width, 0, 234, 38)];
        label_QuanZi.textColor = UIColorFromRGB(0xcccccc);
        label_QuanZi.font = [UIFont systemFontOfSize:k_CellFontBig_15];
        label_QuanZi.text = @"北大社交圈";
        [_viewHeader addSubview:label_QuanZi];

        UIView *cLine = [[UIView alloc] initWithFrame:CGRectMake(0, 38, _viewHeader.frame.size.width, 0.5)];
        cLine.backgroundColor = UIColorFromRGB(0xd9d9d9);
        [_viewHeader addSubview:cLine];


        UILabel *labelTheme = [[UILabel alloc] initWithFrame:CGRectMake(10, 39, 50, 30)];
        labelTheme.textColor = UIColorFromRGB(0x1a1a1a);
        labelTheme.font = [UIFont systemFontOfSize:15];
        labelTheme.text = @"标题";
        [_viewHeader addSubview:labelTheme];


        UITextField *fieldTheme = [[UITextField alloc] initWithFrame:CGRectMake(labelTheme.frame.origin.x+labelTheme.frame.size.width, 39, _viewHeader.frame.size.width-20, 30)];
        fieldTheme.font = [UIFont systemFontOfSize:k_CellFontBig_15];
        fieldTheme.textColor =[UIColor darkGrayColor];
        fieldTheme.placeholder = @"(必填)";
        [_viewHeader addSubview:fieldTheme];

        //        UIView *dLine = [[UIView alloc] initWithFrame:CGRectMake(0, 62, _viewHeader.frame.size.width, 1)];
        //        dLine.backgroundColor = [UIColor lightGrayColor];
        //        [_viewHeader addSubview:dLine];
        
    }
    return _viewHeader;
}


-(UIView *)viewFooter{
    if (!_viewFooter) {
        _viewFooter = [[UIView alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, 120)];
        _viewFooter.backgroundColor = [UIColor colorWithRed:245.0/255 green:245.0/255 blue:245.0/255 alpha:1];

        UILabel *labelTitle = [[UILabel alloc] initWithFrame:CGRectMake(15, 10, 100, 22)];
        labelTitle.font = [UIFont systemFontOfSize:k_CellFontBig_15];
        labelTitle.text = @"添加图片";
        [_viewFooter addSubview:labelTitle];

        CGFloat radio =  screenR.size.width/self.view.frame.size.width;

        UIButton *btnAddPicture = [UIButton buttonWithType:UIButtonTypeRoundedRect];
        btnAddPicture.frame = CGRectMake(15, 32, 50*radio, 50*radio);
        btnAddPicture.layer.borderColor = [UIColor colorWithRed:217.0/255 green:217.0/255 blue:217.0/255 alpha:1].CGColor;
        btnAddPicture.layer.borderWidth = 1;
        btnAddPicture.backgroundColor = [UIColor whiteColor];
        [btnAddPicture setTitle:@"+" forState:UIControlStateNormal];
        [btnAddPicture setTitleColor:[UIColor lightGrayColor] forState:UIControlStateNormal];
        //        [btnAddPicture setContentHorizontalAlignment:UIControlContentHorizontalAlignmentCenter];
        [btnAddPicture setContentEdgeInsets:UIEdgeInsetsMake(4, 10, 10, 10)];
        btnAddPicture.titleLabel.font = [UIFont systemFontOfSize:45*radio];
        [btnAddPicture addTarget:self action:@selector(btnAddPicture:) forControlEvents:UIControlEventTouchUpInside];
        [_viewFooter addSubview:btnAddPicture];
        
    }
    return _viewFooter;
}
-(void)btnAddPicture:(UIButton *)btn{
    NSLog(@"添加图片");
}




-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 1;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString * identifer = @"VIOP:";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identifer];
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifer];
    }
    if ([cell respondsToSelector:@selector(setSeparatorInset:)]) {
        [cell setSeparatorInset:UIEdgeInsetsZero];
    }
    if ([cell respondsToSelector:@selector(setLayoutMargins:)]) {
        [cell setLayoutMargins:UIEdgeInsetsZero];
    }
    for (UIView *view in cell.contentView.subviews) {
        [view removeFromSuperview];
    }

    self.tviewContent.frame = CGRectMake(10, 0, screenR.size.width-20, 150);
    [cell.contentView addSubview:_tviewContent];

//    cell.testStr = _arrTemp[indexPath.row];
    return cell;
}

-(UITextView *)tviewContent{
    if (!_tviewContent) {
        _tviewContent = [[UITextView alloc] initWithFrame:CGRectMake(0, 0, screenR.size.width-20, 100)];
        _tviewContent.font = [UIFont systemFontOfSize:k_CellFontBig_15];
        _tviewContent.text = @"请输入内容";
    }
    return _tviewContent;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{

    return 150;
}


@end



