//
//  QuanZiDetailVC.m
//  screenBtnsDemo
//
//  Created by 龙学武 on 15/8/27.
//  Copyright (c) 2015年 林夕. All rights reserved.
//

#import "QuanZiDetailVC.h"

#import "CollectionCellQuanziMember.h"

#import "D_QZDetail.h"

@interface QuanZiDetailVC ()<UITableViewDelegate,UITableViewDataSource,UICollectionViewDataSource,UICollectionViewDelegate,UICollectionViewDelegateFlowLayout>


@property(nonatomic,strong)UITableView *tableView;

@property(nonatomic,strong)UIView *viewHeader;
@property(nonatomic,strong)UIImageView *imgvIcon;


@property(nonatomic,strong)UIView *viewPostDesc;//主贴简介
@property(nonatomic,strong)UIView *viewQuanZiMember;//圈成员
@property(nonatomic,strong)UIView *viewQuanZiRule;//圈子规则


@property(nonatomic,strong)UICollectionView *collectionView;


@property(nonatomic,strong)UIImageView *imgvBottom;


@end


@implementation QuanZiDetailVC{
    CGRect screenR;

    D_QZDetail *_dQZDetail;
}

- (void)viewDidLoad {
    [super viewDidLoad];

    self.view.backgroundColor = [UIColor whiteColor];
    self.title = @"圈子详情";

    screenR = [[UIScreen mainScreen] bounds];




    self.imgvBottom.frame = CGRectMake(0, screenR.size.height-64-40, _imgvBottom.frame.size.width,_imgvBottom.frame.size.height);
    [self.view addSubview:_imgvBottom];

    [self tableViewConfigure];


    [self netWorkForQuanZiXiangQing];

}

-(void)viewDidAppear:(BOOL)animated{
    [super viewDidAppear:animated];
    [self.view bringSubviewToFront:_imgvBottom];
}

-(void)tableViewConfigure{
    _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height-64-4) style:UITableViewStyleGrouped];
    _tableView.backgroundColor = [UIColor colorWithRed:245.0/255 green:245.0/255 blue:245.0/255 alpha:1];
    _tableView.dataSource = self;
    _tableView.delegate = self;

    _tableView.tableHeaderView = self.viewHeader;

    _tableView.sectionFooterHeight = 0;

    [self.view addSubview:_tableView];
}


-(UIView *)viewHeader{
    if (!_viewHeader) {
        _viewHeader = [[UIView alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, 89)];
        _viewHeader.backgroundColor = [UIColor whiteColor];

        _imgvIcon = [[UIImageView alloc] initWithFrame:CGRectMake(15, 15, k_SizeIconBig_60, k_SizeIconBig_60)];
        _imgvIcon.backgroundColor = [UIColor greenColor];
        _imgvIcon.image = [UIImage imageNamed:@"faceImg22"];
        [_viewHeader addSubview:_imgvIcon];



        UILabel *labelName = [[UILabel alloc] initWithFrame:CGRectMake(_imgvIcon.frame.origin.x+_imgvIcon.frame.size.width+10,_imgvIcon.center.y-k_CellFontBig_15-5, 250, k_CellFontBig_15)];
        labelName.font = [UIFont systemFontOfSize:k_CellFontBig_15];
        labelName.textColor = RGBCOLOR_HEX(0x1a1a1a);
        labelName.text = self.dQZList.name;
        [_viewHeader addSubview:labelName];

        //        圈子人数
        UIImageView *imgvNumberPerson = [[UIImageView alloc] initWithFrame:CGRectMake(_imgvIcon.frame.origin.x+_imgvIcon.frame.size.width+10, _imgvIcon.center.y+5, k_SizeIconSmall_14, k_SizeIconSmall_14)];
        imgvNumberPerson.image = [UIImage imageNamed:@"icon_quanzi_member"];
        [_viewHeader addSubview:imgvNumberPerson];
        UILabel *labelNumberPerson = [[UILabel alloc] initWithFrame:CGRectMake(imgvNumberPerson.frame.origin.x+imgvNumberPerson.frame.size.width+2, imgvNumberPerson.frame.origin.y, 80, k_CellFontSmall_12)];
        labelNumberPerson.textColor = RGBCOLOR_HEX(0x666666);
        labelNumberPerson.font = [UIFont systemFontOfSize:k_CellFontSmall_12];
        labelNumberPerson.text = [NSString stringWithFormat:@"%@ 人",self.dQZList.user_num];
        [_viewHeader addSubview:labelNumberPerson];

        UIImageView *imgvNumberPost = [[UIImageView alloc] initWithFrame:CGRectMake(_viewHeader.frame.size.width/2, imgvNumberPerson.frame.origin.y, k_SizeIconSmall_14, k_SizeIconSmall_14)];
        imgvNumberPost.image = [UIImage imageNamed:@"icon_quanzi_post"];
        [_viewHeader addSubview:imgvNumberPost];
        UILabel *labelNumberPost = [[UILabel alloc] initWithFrame:CGRectMake(_viewHeader.frame.size.width/2+imgvNumberPost.frame.size.width+2, imgvNumberPerson.frame.origin.y, 80, k_CellFontSmall_12)];
        labelNumberPost.textColor =  RGBCOLOR_HEX(0x666666);
        labelNumberPost.font = [UIFont systemFontOfSize:k_CellFontSmall_12];
        labelNumberPost.text =  [NSString stringWithFormat:@"%@ ",self.dQZList.con_num];
        [_viewHeader addSubview:labelNumberPost];


        //        如果没有加入圈子，显示的加入圈子图标
        UIButton *btnJoin = [UIButton buttonWithType:UIButtonTypeRoundedRect];
        btnJoin.layer.borderColor = [UIColor lightGrayColor].CGColor;
        btnJoin.layer.borderWidth = 1;
        btnJoin.layer.cornerRadius = 2;
        btnJoin.frame = CGRectMake(_viewHeader.frame.size.width-10-k_SizeIconSmall_27, 15, k_SizeIconSmall_27, k_SizeIconSmall_27);
        [btnJoin setContentEdgeInsets:UIEdgeInsetsMake(2, 2, 6, 2)];
        [btnJoin addTarget:self action:@selector(btnJoinQuanzi:) forControlEvents:UIControlEventTouchUpInside];
        [btnJoin setTitle:@"+" forState:UIControlStateNormal];
        [_viewHeader addSubview:btnJoin];
        [btnJoin setHidden:YES];

    }
    return _viewHeader;
}

-(void)btnQuanziDetail:(UIButton *)btn{
    NSLog(@"点击进入圈子详情");
}

-(void)btnJoinQuanzi:(UIButton *)btn{
    NSLog(@"点击加入圈子");
}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 3;
}
-(CGFloat )tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 10;
}
-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    UIView *view = [[UIView alloc] initWithFrame:CGRectMake(-1, 0, self.view.frame.size.width+2, 10)];
    view.backgroundColor = [UIColor colorWithRed:245.0/255 green:245.0/255 blue:245.0/255 alpha:1];
    view.layer.borderColor = [UIColor colorWithRed:217.0/255 green:217.0/255 blue:217.0/255 alpha:1].CGColor;
    view.layer.borderWidth = 0.5;
    return view;
}



-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 1;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *identifier = @"CFGHJKL:";

    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
    }
    if (indexPath.section == 0) {
        [cell.contentView addSubview:self.viewPostDesc];
    }else if (indexPath.section == 1){
        [cell.contentView addSubview:self.viewQuanZiMember];
    }else if (indexPath.section == 2){
        [cell.contentView addSubview:self.viewQuanZiRule];
    }
    cell.selectionStyle = UITableViewCellSelectionStyleNone;

    return cell;
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.section == 1) {
        return 146;
    }
    return 102;
}



-(UIView *)viewPostDesc{
    if (!_viewPostDesc) {
        _viewPostDesc = [[UIView alloc] initWithFrame:CGRectMake(0, 0, screenR.size.width, 102)];
        _viewPostDesc.backgroundColor =[UIColor whiteColor];

        UIImageView *imgvTitle = [[UIImageView alloc] initWithFrame:CGRectMake(10, 10, 18, 18)];
//        imgvTitle.backgroundColor =  [UIColor blueColor];
        imgvTitle.image = [UIImage imageNamed:@"icon_quanzi_desc"];
        [_viewPostDesc addSubview:imgvTitle];

        UILabel *labelTitle = [[UILabel alloc] initWithFrame:CGRectMake(imgvTitle.frame.origin.x+imgvTitle.frame.size.width+5, 10, 100, 18)];
        labelTitle.text = @"主贴简介";
        labelTitle.font = [UIFont systemFontOfSize:k_CellFontBig_15];
        labelTitle.textColor = RGBCOLOR_HEX(0x1a1a1a);
        [_viewPostDesc addSubview:labelTitle];

        CGFloat labelC_y =  imgvTitle.frame.origin.y+imgvTitle.frame.size.height;
        UILabel *labelContent = [[UILabel alloc] initWithFrame:CGRectMake(10, labelC_y, screenR.size.width-20, _viewPostDesc.frame.size.height-labelC_y - 25)];
        labelContent.numberOfLines = 0;
        labelContent.font = [UIFont systemFontOfSize:k_CellFontSmall_13];
        labelContent.textColor = RGBCOLOR_HEX(0x1a1a1a);
        labelContent.tag = 100;
        labelContent.text = @"你好随风扶绿柳，自在助蝶舞，欢畅琼台歌你好随风扶绿柳，自在助蝶舞，欢畅琼台歌你好随风扶绿柳，自在助蝶舞，欢畅琼台歌你好随风扶绿柳，自在助蝶舞，欢畅琼台歌";
        labelContent.textColor = [UIColor grayColor];
        [_viewPostDesc addSubview:labelContent];


        UIButton *btnMore = [UIButton buttonWithType:UIButtonTypeRoundedRect];
        [btnMore setFrame:CGRectMake(self.view.frame.size.width-10-40, _viewPostDesc.frame.size.height-25, 40, 20)];
        btnMore.tag = 111;
        [btnMore addTarget:self action:@selector(btnMoreClick:) forControlEvents:UIControlEventTouchUpInside];
        [btnMore setTitle:@"更多" forState:UIControlStateNormal];
        btnMore.titleLabel.font = [UIFont systemFontOfSize:k_CellFontSmall_13];
        [btnMore setTitleColor:RGBCOLOR_HEX(0x666666) forState:UIControlStateNormal];
        [_viewPostDesc addSubview:btnMore];
    }
    return _viewPostDesc;
}
-(UIView *)viewQuanZiMember{
    if (!_viewQuanZiMember) {
        _viewQuanZiMember = [[UIView alloc] initWithFrame:CGRectMake(0, 0, screenR.size.width, 134)];
        _viewQuanZiMember.backgroundColor =[UIColor whiteColor];

        UIImageView *imgvTitle = [[UIImageView alloc] initWithFrame:CGRectMake(10, 10, 18, 18)];
//        imgvTitle.backgroundColor =  [UIColor blueColor];
        imgvTitle.image = [UIImage imageNamed:@"icon_quanzi_number"];
        [_viewQuanZiMember addSubview:imgvTitle];

        UILabel *labelTitle = [[UILabel alloc] initWithFrame:CGRectMake(imgvTitle.frame.origin.x+imgvTitle.frame.size.width+5, 10, 100, 18)];
        labelTitle.text = @"圈成员";
        labelTitle.font = [UIFont systemFontOfSize:k_CellFontBig_15];
        labelTitle.textColor = RGBCOLOR_HEX(0x1a1a1a);
        [_viewQuanZiMember addSubview:labelTitle];


        self.collectionView.frame = CGRectMake(0, imgvTitle.frame.origin.y+imgvTitle.frame.size.height, _collectionView.frame.size.width, _collectionView.frame.size.height);
        [_viewQuanZiMember addSubview:_collectionView];


    }
    return _viewQuanZiMember;
}

-(void)btnMoreClick:(UIButton *)btn{
    if (btn.tag == 111) {
        NSLog(@"主贴简介 更多 ~");
    }else if(btn.tag == 112){
        NSLog(@"圈规则 更多 ~");
    }
}


#pragma mark - 
#pragma mark - UICollectionView

static NSString *identifier = @"quanziMemberCell";
-(UICollectionView *)collectionView{
    if (!_collectionView) {

        UICollectionViewFlowLayout *flowLayout = [[UICollectionViewFlowLayout alloc]init];
        [flowLayout setItemSize:CGSizeMake(100,100)];//设置cell的尺寸
        [flowLayout setScrollDirection:UICollectionViewScrollDirectionHorizontal];//设置其布局方向
        flowLayout.sectionInset = UIEdgeInsetsMake(10, 10, 10, 10);//设置其边界


        _collectionView = [[UICollectionView alloc] initWithFrame:CGRectMake(0, 0, screenR.size.width, 120) collectionViewLayout:flowLayout];
        [_collectionView registerNib:[UINib nibWithNibName:@"CollectionCellQuanziMember" bundle:nil] forCellWithReuseIdentifier:identifier];
        _collectionView.backgroundColor = [UIColor whiteColor];
        _collectionView.dataSource = self;
        _collectionView.delegate  = self;

    }
    return _collectionView;
}

#pragma mark UICollectionView Datasource and Delegate

-(NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView{
    return 1;
}


- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    return 10;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    CollectionCellQuanziMember *cell = [collectionView dequeueReusableCellWithReuseIdentifier:identifier forIndexPath:indexPath];
    cell.imgvIcon.backgroundColor = [UIColor redColor];
//    cell.imgvMark.backgroundColor = [UIColor blueColor];
    cell.imgvIcon.image =[UIImage imageNamed:@"faceImg"];
    cell.imgvMark.image =[UIImage imageNamed:@"icon_quanzi_medal"];

    return cell;
}


-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    [collectionView deselectItemAtIndexPath:indexPath animated:YES];
    NSLog(@"%@",indexPath);

}


#pragma mark 圈子成员子视图

#pragma mark -



-(UIView *)viewQuanZiRule{
    if (!_viewQuanZiRule) {
        _viewQuanZiRule = [[UIView alloc] initWithFrame:CGRectMake(0, 0, screenR.size.width, 102)];
        _viewQuanZiRule.backgroundColor =[UIColor whiteColor];

        UIImageView *imgvTitle = [[UIImageView alloc] initWithFrame:CGRectMake(10, 10, 18, 18)];
//        imgvTitle.backgroundColor =  [UIColor blueColor];
        imgvTitle.image = [UIImage imageNamed:@"icon_quanzi_rule"];
        [_viewQuanZiRule addSubview:imgvTitle];

        UILabel *labelTitle = [[UILabel alloc] initWithFrame:CGRectMake(imgvTitle.frame.origin.x+imgvTitle.frame.size.width+5, 10, 100, 18)];
        labelTitle.text = @"圈规则";
        labelTitle.font = [UIFont systemFontOfSize:k_CellFontBig_15];
        labelTitle.textColor = RGBCOLOR_HEX(0x1a1a1a);
        [_viewQuanZiRule addSubview:labelTitle];


        CGFloat labelC_y =  imgvTitle.frame.origin.y+imgvTitle.frame.size.height;
        UILabel *labelContent = [[UILabel alloc] initWithFrame:CGRectMake(10, labelC_y, screenR.size.width-20, _viewPostDesc.frame.size.height-labelC_y - 25)];
        labelContent.tag = 100;
        labelContent.numberOfLines = 0;
        labelContent.font = [UIFont systemFontOfSize:k_CellFontSmall_13];
        labelContent.text = @"你好随风扶绿柳，自在助蝶舞，欢畅琼台歌你好随风扶绿柳，自在助蝶舞，欢畅琼台歌你好随风扶绿柳，自在助蝶舞，欢畅琼台歌你好随风扶绿柳，自在助蝶舞，欢畅琼台歌";
        labelContent.textColor = RGBCOLOR_HEX(0x1a1a1a);
        [_viewQuanZiRule addSubview:labelContent];

        UIButton *btnMore = [UIButton buttonWithType:UIButtonTypeRoundedRect];
        [btnMore setFrame:CGRectMake(self.view.frame.size.width-10-40, _viewQuanZiRule.frame.size.height-25, 40, 20)];
        btnMore.tag = 112;
        [btnMore addTarget:self action:@selector(btnMoreClick:) forControlEvents:UIControlEventTouchUpInside];
        [btnMore setTitle:@"更多" forState:UIControlStateNormal];
        btnMore.titleLabel.font = [UIFont systemFontOfSize:k_CellFontSmall_13];
        [btnMore setTitleColor:RGBCOLOR_HEX(0x666666) forState:UIControlStateNormal];
        [_viewQuanZiRule addSubview:btnMore];

    }
    return _viewQuanZiRule;
}



-(UIImageView *)imgvBottom{
    if (!_imgvBottom) {
        _imgvBottom = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, screenR.size.width, 40)];
        _imgvBottom.userInteractionEnabled = YES;
        _imgvBottom.backgroundColor =  [UIColor colorWithRed:53.0/155 green:168.0/255 blue:252.0/255 alpha:1];

        UIButton *btnJoinQZ = [UIButton buttonWithType:UIButtonTypeRoundedRect];
        [btnJoinQZ setTitle:@"加入圈子" forState:UIControlStateNormal];
        [btnJoinQZ setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        btnJoinQZ.tag = 11;
        [btnJoinQZ addTarget:self action:@selector(btnBootomClick:) forControlEvents:UIControlEventTouchUpInside];
        [btnJoinQZ setFrame:CGRectMake(0, 0, screenR.size.width/2, 40)];
        [_imgvBottom addSubview:btnJoinQZ];


        UIView *lineH = [[UIView alloc] initWithFrame:CGRectMake(screenR.size.width/2-0.5, 5, 1, 30)];
        lineH.backgroundColor = [UIColor whiteColor];
        [_imgvBottom addSubview:lineH];

        UIButton *btnJoinTalk = [UIButton buttonWithType:UIButtonTypeRoundedRect];
        btnJoinTalk.tag = 12;
        [btnJoinTalk setTitle:@"进群讨论" forState:UIControlStateNormal];
        [btnJoinTalk setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [btnJoinTalk addTarget:self action:@selector(btnBootomClick:) forControlEvents:UIControlEventTouchUpInside];
        [btnJoinTalk setFrame:CGRectMake(screenR.size.width/2, 0, screenR.size.width/2, 40)];
        [_imgvBottom addSubview:btnJoinTalk];

    }
    return _imgvBottom;
}

-(void)btnBootomClick:(UIButton *)btn{
    if (btn.tag == 11) {
        NSLog(@"加入圈子");
    }else if (btn.tag == 12){
        NSLog(@"进群讨论");
    }
}




-(void)refreshUIItems{
    UILabel *labelContent = (UILabel *)[_viewPostDesc viewWithTag:100];
    labelContent.text = _dQZDetail.content;

}


-(void)netWorkForQuanZiXiangQing{
//    DataInterface *_dIF = [[DataInterface alloc] initWithDelegate:self];
//    [_dIF CircleInfoWithCid:[self.dQZList.ID integerValue]];
    
        D_QZList *dQZ = [D_QZList new];
    NSString *i  = @"hahaha";
    
        dQZ.con_num         = [NSString stringWithFormat:@"%@",i];
        dQZ.content         = [NSString stringWithFormat:@"%@",i];
        dQZ.create_time     = [NSString stringWithFormat:@"%@",i];
        dQZ.id              = [NSString stringWithFormat:@"%@",i];
        dQZ.img             = [NSString stringWithFormat:@"%@",i];
        dQZ.img_str         = [NSString stringWithFormat:@"%@",i];
        dQZ.name            = [NSString stringWithFormat:@"%@",i];
        dQZ.uid             = [NSString stringWithFormat:@"%@",i];
        dQZ.is_circle       = [NSString stringWithFormat:@"%@",i];
        dQZ.is_pwd          = [NSString stringWithFormat:@"%@",i];
        dQZ.user_img        = [NSString stringWithFormat:@"%@",i];
        dQZ.user_num        = [NSString stringWithFormat:@"%@",i];
        dQZ.username        = [NSString stringWithFormat:@"%@",i];

    [self refreshUIItems];

}

-(void)dataInterfaceRequestFinishedWithReturnStatus:(NSInteger)status andResult:(NSDictionary *)result andType:(NSString *)type{
    NSLog(@"type = %@ %@",type,[result allKeys]);
    if (status) {
        NSDictionary *dictData = [result objectForKey:@"data"];
        if ([dictData isKindOfClass:[NSDictionary class]])
        {
            _dQZDetail = [D_QZDetail new];
            [_dQZDetail setValuesForKeysWithDictionary:dictData];

            [self refreshUIItems];
        }
    }
}





@end




