//
//  PageRootViewController.m
//  LYYZPlat
//
//  Created by xw.long on 16/1/21.
//  Copyright © 2016年 xw.long. All rights reserved.
//

#import "PageRootViewController.h"
#import "QuanZiItemFaceVC.h"
#import "QuanZiSearchListVC.h"
#import "QuanZiPageVC.h"

@interface PageRootViewController ()

@end

@implementation PageRootViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    
    [self setNavigationConfigure];
    
    
    [self displayPageVC];

}

-(void)setNavigationConfigure{
    UIBarButtonItem *lBarItem = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemUndo target:self action:@selector(navItemBack)];
    UIBarButtonItem *rBarItem = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemSearch target:self action:@selector(navItemSearch)];
    self.navigationItem.rightBarButtonItem = rBarItem;
    self.navigationItem.leftBarButtonItem = lBarItem;
}
-(void)navItemBack{
    [self displayQuanZiItemFaceVC];
}
-(void)navItemSearch{
    QuanZiSearchListVC *_quanziSLVC = [[QuanZiSearchListVC alloc] init];
    [self.navigationController pushViewController:_quanziSLVC animated:YES];
}

//    这个地方搁置一下那个最初选择六边形按钮的界面。
-(void)displayQuanZiItemFaceVC{
    QuanZiItemFaceVC *_qziIFaceVC = [[QuanZiItemFaceVC alloc] init];
    __block QuanZiItemFaceVC *weekQVC = _qziIFaceVC;
    [self presentViewController:_qziIFaceVC animated:NO completion:nil];
    _qziIFaceVC.IFBlock = ^(NSArray *arrItems){
        NSLog(@"%@",arrItems);
        [weekQVC dismissViewControllerAnimated:YES completion:nil];
    };
}


//这个地方搁置底层的PageView滚动视图
-(void)displayPageVC{
    QuanZiPageVC *pageVC  = [[QuanZiPageVC alloc] init];
    [self addChildViewController:pageVC];
    [self.view addSubview:pageVC.view];
    
}


@end
