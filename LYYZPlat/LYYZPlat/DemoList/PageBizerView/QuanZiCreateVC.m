//
//  QuanZiCreateVC.m
//  screenBtnsDemo
//
//  Created by 龙学武 on 15/8/26.
//  Copyright (c) 2015年 林夕. All rights reserved.
//

#import "QuanZiCreateVC.h"
#import "QuanZiTypeChooseVC.h"

@interface QuanZiCreateVC ()<UITableViewDataSource,UITableViewDelegate,UITextFieldDelegate,UITextViewDelegate,UIActionSheetDelegate,UIImagePickerControllerDelegate,UINavigationControllerDelegate>

@property(nonatomic,strong)UITableView *tableView;
@property(nonatomic,strong)UIView *viewHeader;
@property(nonatomic,strong)UIImageView *imgvIcon;//头像

@property(nonatomic,strong)UIView *viewFooter;

@property(nonatomic,strong)UIView *viewName;
@property(nonatomic,strong)UITextField *filedName;//名字

@property(nonatomic,strong)UIView *viewDesc;
@property(nonatomic,strong)UITextView *tviewDesc;//圈子简介

@property(nonatomic,strong)UISwitch *swAuth;



@end

@implementation QuanZiCreateVC{
    NSDictionary *_typeDict;
}


-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [self.navigationController.navigationBar setHidden:YES];
}
-(void)viewWillDisappear:(BOOL)animated{
    [self.navigationController.navigationBar setHidden:NO];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"创建圈子";
    self.view.backgroundColor = [UIColor whiteColor];

    [self setNavigationConfigure];

    [self tableViewConfigure];
}




-(void)setNavigationConfigure{
    //    UIBarButtonItem *lBarItem = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemUndo target:self action:@selector(navItemBack)];
    UIBarButtonItem *rBarItem = [[UIBarButtonItem alloc] initWithTitle:@"完成" style:UIBarButtonItemStylePlain target:self action:@selector(navItemSearch)];
    self.navigationItem.rightBarButtonItem = rBarItem;
    //    self.navigationItem.leftBarButtonItem = lBarItem;
}
-(void)navItemBack{
    [self.navigationController popViewControllerAnimated:YES];
}
-(void)navItemSearch{
    NSLog(@"点击完成圈子创建");

    [self.view endEditing:YES];

    [self judgeForNetWorkToCreateQuanZi];

}

-(void)tableViewConfigure{
    _tableView = [[UITableView alloc] initWithFrame:self.view.bounds style:UITableViewStyleGrouped];
    _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    _tableView.backgroundColor = [UIColor lightGrayColor];
    _tableView.separatorColor = COLOR_SEPERATE_LINE;
    _tableView.dataSource = self;
    _tableView.delegate = self;

    _tableView.tableHeaderView = self.viewHeader;
    _tableView.tableFooterView = self.viewFooter;

    _tableView.sectionFooterHeight = 0;

    [self.view addSubview:_tableView];
}

-(void)tapGesture:(UITapGestureRecognizer *)tapG{
    [self.view endEditing:YES];
}
-(UIView *)viewHeader{
    if (!_viewHeader) {
        _viewHeader = [[UIView alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, 20+k_SizeIconBig_60)];
        [_viewHeader addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapGesture:)]];
        _viewHeader.backgroundColor = [UIColor whiteColor];

        _imgvIcon = [[UIImageView alloc] initWithFrame:CGRectMake(10, 10, k_SizeIconBig_60, k_SizeIconBig_60)];
        _imgvIcon.backgroundColor = [UIColor greenColor];
        _imgvIcon.image = [UIImage imageNamed:@"faceImg22"];
        [_viewHeader addSubview:_imgvIcon];

        UIButton *btnUpdate = [UIButton buttonWithType:UIButtonTypeRoundedRect];
        [btnUpdate setFrame:CGRectMake(0, 0, 120, 40)];
        [btnUpdate setCenter:CGPointMake([UIScreen mainScreen].bounds.size.width-130, 40)];
        [btnUpdate setTitle:@"上传头像 >" forState:UIControlStateNormal];
        [btnUpdate setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
        [btnUpdate addTarget:self action:@selector(btnUpdateImgv:) forControlEvents:UIControlEventTouchUpInside];
        [_viewHeader addSubview:btnUpdate];
    }
    return _viewHeader;
}

-(void)btnUpdateImgv:(UIButton *)btn{
    NSLog(@"上传头像");
    [self.view endEditing:YES];

    UIActionSheet *actionSheet = [[UIActionSheet alloc] initWithTitle:nil
                                                             delegate:self
                                                    cancelButtonTitle:@"取消"
                                               destructiveButtonTitle:nil
                                                    otherButtonTitles:@"拍照", @"从手机相册选取", nil];
    [actionSheet showInView:btn];

}

-(UIView *)viewFooter{
    if (!_viewFooter) {
        _viewFooter = [[UIView alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, 120)];
        [_viewFooter addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapGesture:)]];
        _viewFooter.backgroundColor = [UIColor lightGrayColor];

        UILabel *labelTitle = [[UILabel alloc] initWithFrame:CGRectMake(15, 10, 100, 22)];
        labelTitle.font = [UIFont systemFontOfSize:15];
        labelTitle.text = @"邀请好友";
        [_viewFooter addSubview:labelTitle];



        CGRect screenR = [[UIScreen mainScreen] bounds];
        CGFloat radio =  screenR.size.width/self.view.frame.size.width;

        UIButton *btnInviteFriend = [UIButton buttonWithType:UIButtonTypeRoundedRect];
        btnInviteFriend.frame = CGRectMake(15, 32, 50*radio, 50*radio);
        btnInviteFriend.layer.borderColor = [UIColor colorWithRed:217.0/255 green:217.0/255 blue:217.0/255 alpha:1].CGColor;
        btnInviteFriend.layer.borderWidth = 1;
        btnInviteFriend.backgroundColor = [UIColor whiteColor];
        [btnInviteFriend setTitle:@"+" forState:UIControlStateNormal];
        [btnInviteFriend setTitleColor:[UIColor lightGrayColor] forState:UIControlStateNormal];
        //        [btnInviteFriend setContentHorizontalAlignment:UIControlContentHorizontalAlignmentCenter];
        [btnInviteFriend setContentEdgeInsets:UIEdgeInsetsMake(4, 10, 10, 10)];
        btnInviteFriend.titleLabel.font = [UIFont systemFontOfSize:45*radio];
        [btnInviteFriend addTarget:self action:@selector(btnInvitationFriend:) forControlEvents:UIControlEventTouchUpInside];
        [_viewFooter addSubview:btnInviteFriend];

    }
    return _viewFooter;
}

-(void)btnInvitationFriend:(UIButton *)btn{
    NSLog(@"邀请好友");
}


-(CGFloat )tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    if (section == 1) {
        return 25;
    }
    return 10;
}
-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    UIView *view = [[UIView alloc] initWithFrame:CGRectMake(-1, 0, self.view.frame.size.width+2, 10)];
    [view addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapGesture:)]];
    view.backgroundColor = COLOR_SEPERATE_LINE;
    view.layer.borderColor = COMMOM_TABLE_CELL_SELECTED.CGColor;
    view.layer.borderWidth = 1;
    return view;
}
-(NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section{
    if (section == 1) {
        return @"    注： 4-20位字符，支持汉字、字母、数字及“_”、“-” 组合";
    }
    return nil;
}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 4;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 1;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    UITableViewCell *cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue2 reuseIdentifier:nil];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    cell.accessoryType = UITableViewCellAccessoryNone;
    if (indexPath.section == 0) {
        [cell.contentView addSubview:self.viewName];
    }else if (indexPath.section == 1){
        [cell.contentView addSubview:self.viewDesc];
    }else if (indexPath.section == 2){
        UILabel *fenlei = [[UILabel alloc] initWithFrame:CGRectMake(15, 0, 100, 33)];
        fenlei.text = @"分类";
        fenlei.textColor = COLOR_SEPERATE_LINE;
        [cell.contentView addSubview:fenlei];

        UILabel *neibie =  [[UILabel alloc] initWithFrame:CGRectMake(self.view.frame.size.width - 100, 0, 100, 33)];
        neibie.text = [_typeDict objectForKey:[[_typeDict allKeys] lastObject]];
        neibie.textColor = COLOR_SEPERATE_LINE;
        [cell.contentView addSubview:neibie];
        cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    }else if (indexPath.section == 3){
        UILabel *authority = [[UILabel alloc] initWithFrame:CGRectMake(15, 0, 200, 33)];
        authority.textColor = COLOR_SEPERATE_LINE;
        authority.text = @"是否允许所有人加入";
        [cell.contentView addSubview:authority];
        cell.accessoryView =self.swAuth;
    }

    return cell;
}
-(CGFloat )tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.section ==0) {
        return 40;
    }else if (indexPath.section == 1){
        return 125;
    }
    return 33;
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [self.view endEditing:YES];
    if (indexPath.section == 2) {
        NSLog(@"选择类型");

        QuanZiTypeChooseVC *_quanziTCVC = [[QuanZiTypeChooseVC alloc] init];
        [_quanziTCVC qzTypeChoose:^(NSDictionary *typeDict) {
            NSLog(@"%@",typeDict);
            _typeDict = typeDict;
            [self.tableView reloadData];
        }];
        [self.navigationController pushViewController:_quanziTCVC animated:YES];
    }
}



//请输入名字
-(UIView *)viewName{
    if (!_viewName) {
        _viewName = [[UIView alloc] initWithFrame:CGRectMake(-1, 0, self.view.frame.size.width+2, 40)];
        _viewName.backgroundColor = [UIColor whiteColor];

        _filedName = [[UITextField alloc] initWithFrame:CGRectMake(1, 0, 234, 40)];
        UIView *leftv =[[UIView alloc] initWithFrame:CGRectMake(0, 0, 15, 40)];
        _filedName.leftView = leftv;
        _filedName.leftViewMode = UITextFieldViewModeAlways;
        _filedName.delegate = self;
        _filedName.placeholder = @"请输入名字";
        _filedName.font = [UIFont systemFontOfSize:k_CellFontBig_15];
        [_viewName addSubview:_filedName];

    }
    return _viewName;
}



//圈子简介
-(UIView *)viewDesc{
    if (!_viewDesc) {
        _viewDesc = [[UIView alloc] initWithFrame:CGRectMake(-1, 0, self.view.frame.size.width+2, 125)];
        _viewDesc.backgroundColor = [UIColor whiteColor];

        _tviewDesc = [[UITextView alloc] initWithFrame:CGRectMake(10, 10, self.view.frame.size.width-20, 105)];
        _tviewDesc.backgroundColor = [UIColor clearColor];
        _tviewDesc.delegate = self;
        _tviewDesc.text = @"请输入圈子简介";
        _tviewDesc.font = [UIFont systemFontOfSize:15];
        _tviewDesc.textColor = [UIColor lightGrayColor];
        [_viewDesc addSubview:_tviewDesc];
    }
    return _viewDesc;
}


//授权允许加入
-(UISwitch *)swAuth{
    if (!_swAuth) {
        _swAuth = [[UISwitch alloc] init];
        [_swAuth addTarget:self action:@selector(switchChangeValue:) forControlEvents:UIControlEventValueChanged];
    }
    return _swAuth;
}
-(void)switchChangeValue:(UISwitch *)sw{
    if (sw.isOn) {
        NSLog(@"授权开启");
    }else{
        NSLog(@"授权关闭");
    }
}


-(BOOL)textFieldShouldReturn:(UITextField *)textField{
    [self.navigationController.view endEditing:YES];
    return YES;
}


#pragma mark -
#pragma mark - 图片处理



#pragma mark - UIActionSheetDelegate methods

- (void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex {
    if (buttonIndex == 0) {
        if ([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera]) {
            [self showImagePickerForSourceType:UIImagePickerControllerSourceTypeCamera];

        }
    } else if (buttonIndex == 1) {
        if ([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypePhotoLibrary]) {
            [self showImagePickerForSourceType:UIImagePickerControllerSourceTypePhotoLibrary];
        }
    }
}

#pragma mark - UIImagePickerControllerDelegate methods
- (void)showImagePickerForSourceType:(UIImagePickerControllerSourceType)sourceType {
    UIImagePickerController *imagePickerController = [[UIImagePickerController alloc] init];
    imagePickerController.navigationBar.titleTextAttributes = nil;
    imagePickerController.modalPresentationStyle = UIModalPresentationCurrentContext;
    imagePickerController.sourceType = sourceType;
    imagePickerController.allowsEditing = YES;
    imagePickerController.delegate = self;

    if (sourceType == UIImagePickerControllerSourceTypeCamera) {
        imagePickerController.showsCameraControls = YES;
        imagePickerController.cameraDevice = UIImagePickerControllerCameraDeviceFront;
    }

    [self presentViewController:imagePickerController animated:YES completion:^(void) {
#if 0
        if (sourceType == UIImagePickerControllerSourceTypeCamera) {

            [[UIApplication sharedApplication] setStatusBarHidden:YES];

        } else {
            if ([[[UIDevice currentDevice] systemVersion] floatValue] >= 7.0) {

                [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleDefault];
                [[UIApplication sharedApplication] setStatusBarHidden:YES];
            }
        }
#endif
    }];
    //    [self.tabBarController.tabBar setHidden:YES];

}

- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info {
    UIImage *originalImage = [info valueForKey:UIImagePickerControllerOriginalImage];
    UIImage *editedImage = [info valueForKey:UIImagePickerControllerEditedImage];

    if (picker.sourceType == UIImagePickerControllerSourceTypeCamera) {
        UIImageWriteToSavedPhotosAlbum (originalImage, nil, nil, nil);
    }

    [self dismissViewControllerAnimated:YES completion:NULL];
    //    [self.tabBarController.tabBar setHidden:NO];

    if (picker.sourceType == UIImagePickerControllerSourceTypeCamera) {
        [[UIApplication sharedApplication] setStatusBarHidden:NO];
    } else {
        if ([[[UIDevice currentDevice] systemVersion] floatValue] >= 7.0) {
            [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleLightContent];
            [[UINavigationBar appearance] setTitleTextAttributes:@{NSForegroundColorAttributeName:[UIColor whiteColor]}];
        }
    }
    //
    //    if (!_arr_fieldImgv) {
    //        _arr_fieldImgv = [NSMutableArray array];
    //    }
    //    UIImageView *upImgv = [[UIImageView alloc] initWithImage:editedImage];
    //    [_arr_fieldImgv insertObject:upImgv atIndex:_photoArr.count];


    [self upImage:originalImage];

    _imgvIcon.image = editedImage;

    //    [self.tableView reloadData];

}


- (void)imagePickerControllerDidCancel:(UIImagePickerController *)picker {
    [self dismissViewControllerAnimated:YES completion:NULL];
    [self.tabBarController.tabBar setHidden:NO];

    if (picker.sourceType == UIImagePickerControllerSourceTypeCamera) {
        [[UIApplication sharedApplication] setStatusBarHidden:NO];
    } else {
        if ([[[UIDevice currentDevice] systemVersion] floatValue] >= 7.0) {
            [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleLightContent];
        }
    }
}



#pragma mark  - netWork
#pragma mark - 压缩图片
-(UIImage *) originImage:(UIImage *)image scaleToSize:(CGSize)size
{
    UIGraphicsBeginImageContext(size);
    [image drawInRect:CGRectMake(0, 0, size.width, size.height)];
    UIImage *scaleImage = UIGraphicsGetImageFromCurrentImageContext();
    return scaleImage;
}
/*
 4.1 上传图片
 file : 图片相关data 必填参数
 uid: 用户id 必填参数
 type : 类别（1绿色就诊 2退换货 3上传病例） 必填参数
 */
-(void)upImage:(UIImage *)img{

    CGSize pictureSize = CGSizeMake(200, 200);
    UIImage *newImg = [self originImage:img scaleToSize:pictureSize];
    NSData *pictureData = UIImagePNGRepresentation(newImg);

//    NSString *file = [pictureData base64EncodedStringWithOptions:0];
//    file = [file stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    
    [self upImage:newImg];
    
}

-(void)judgeForNetWorkToCreateQuanZi{

    NSString *errMSG = nil;
    if (!self.filedName.text.length) {
        errMSG = @"请输入名称";
    }else if (!self.tviewDesc.text.length){
        errMSG = @"请输入圈子简介";
    }else if (!_typeDict){
        errMSG = @"请选择圈子类型";
    }

    if (errMSG) {
        UIAlertView *_alert = [[UIAlertView alloc] initWithTitle:errMSG message:nil delegate:nil cancelButtonTitle:@"OK" otherButtonTitles: nil];
        [_alert show];
        return;
    }

    NSInteger cid = arc4random()%5;
    NSInteger is_pwd = self.swAuth.isOn;

}







///
//http://192.168.1.5/circle/add?uid=1&name=lxwmy&content=nihao&type=women&is_pwd=0
///

@end






