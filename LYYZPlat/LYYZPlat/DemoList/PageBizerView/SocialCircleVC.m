//
//  SocialCircleVC.m
//  screenBtnsDemo
//
//  Created by 龙学武 on 15/8/24.
//  Copyright (c) 2015年 林夕. All rights reserved.
//

#import "SocialCircleVC.h"

@interface SocialCircleVC ()<UICollectionViewDataSource,UICollectionViewDelegate,UICollectionViewDelegateFlowLayout>

@property(nonatomic,strong)UICollectionView *collectionView;

@end

@implementation SocialCircleVC

- (void)viewDidLoad {
    [super viewDidLoad];

    [self configureColletionView];
}


static NSString *identifier = @"HIL:";

-(void)configureColletionView{

    UICollectionViewFlowLayout *flowLayout = [[UICollectionViewFlowLayout alloc]init];
    [flowLayout setItemSize:CGSizeMake(70, 100)];//设置cell的尺寸
    [flowLayout setScrollDirection:UICollectionViewScrollDirectionHorizontal];//设置其布局方向
    flowLayout.sectionInset = UIEdgeInsetsMake(5, 15, 35, 55);//设置其边界





    self.collectionView = [[UICollectionView alloc] initWithFrame:CGRectMake(0, 64, self.view.frame.size.width, self.view.frame.size.height-64-64-20) collectionViewLayout:flowLayout];
    [self.collectionView registerClass:[UICollectionViewCell class] forCellWithReuseIdentifier:identifier];
    self.collectionView.dataSource = self;
    self.collectionView.delegate  = self;
    [self.view addSubview:_collectionView];
}



-(NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView{
    return 3;
}


- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    return 80;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    UICollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:identifier forIndexPath:indexPath];
    cell.layer.borderColor = [UIColor redColor].CGColor;
    cell.layer.borderWidth = 3;
    cell.backgroundColor = [UIColor lightGrayColor];

    return cell;
}


-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    [collectionView deselectItemAtIndexPath:indexPath animated:YES];
    NSLog(@"%@",indexPath);

}

-(BOOL)collectionView:(UICollectionView *)collectionView shouldHighlightItemAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.row>40 || indexPath.row<20) {
        return NO;
    }
    return YES;
}

@end






