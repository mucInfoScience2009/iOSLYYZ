//
//  QuanZiPageVC.m
//  screenBtnsDemo
//
//  Created by 龙学武 on 15/8/26.
//  Copyright (c) 2015年 林夕. All rights reserved.
//

#import "QuanZiPageVC.h"
#import "ScrollSegments.h"
#import "QuanZiMainListVC.h"
#import "QuanZiMineListVC.h"


@interface QuanZiPageVC ()<UIPageViewControllerDataSource,UIPageViewControllerDelegate,UIScrollViewDelegate>

@property(nonatomic,strong)ScrollSegments *scrollSeg;
@property(nonatomic,strong)UIViewController *currentCVC;

@end


#define kDeviceWidth  [UIScreen mainScreen].bounds.size.width
#define KDeviceHeight [UIScreen mainScreen].bounds.size.height
#define k_nabBar_h 40


@implementation QuanZiPageVC{
    NSMutableArray *_arr_Items;
    UIView *topView;

    NSMutableArray *_arrCVCItems;
}

-(instancetype)init{
    return  [self initWithTransitionStyle:UIPageViewControllerTransitionStyleScroll navigationOrientation:UIPageViewControllerNavigationOrientationHorizontal options:nil];
}

-(instancetype)initWithTransitionStyle:(UIPageViewControllerTransitionStyle)style navigationOrientation:(UIPageViewControllerNavigationOrientation)navigationOrientation options:(NSDictionary *)options{
    return [super initWithTransitionStyle:UIPageViewControllerTransitionStyleScroll navigationOrientation:UIPageViewControllerNavigationOrientationHorizontal options:options];
}


- (void)viewDidLoad {
    [super viewDidLoad];




    self.dataSource = self;
    self.delegate = self;

    //    _arr_Items = [NSMutableArray arrayWithArray:@[@"One",@"two",@"three",@"four",@"five",@"Six",@"seven",@"eight"]];
    _arr_Items = [NSMutableArray arrayWithArray:@[@"推荐",@"我的",@"汽车",@"娱乐",@"健康",@"家居生活",@"旅游",@"同乡",@"校友",@"科技数码",@"女性天地",@"经济",@"创业",@"社会万象",@"情感",@"其他"]];




    [self configureScrollSeg];

}

#pragma mark 顶部的控制view
-(void)configureScrollSeg{

    //    UIScrollView *scrollView= [[UIScrollView alloc] initWithFrame:CGRectMake(0, 164, kDeviceWidth, k_nabBar_h)];
    //    scrollView.backgroundColor = [UIColor clearColor];
    //    [self.view addSubview:scrollView];

    NSMutableArray *btnTitleArr = [NSMutableArray array];
    [btnTitleArr addObjectsFromArray:_arr_Items];

    self.scrollSeg = [[ScrollSegments alloc] initWithArray:btnTitleArr andFrame:CGRectMake(0,0, kDeviceWidth, k_nabBar_h*[UIScreen mainScreen].bounds.size.width/320)];
    self.scrollSeg.delegate = self;
    [self.view addSubview:_scrollSeg];
    [self.scrollSeg sSegBlock:^(NSInteger seletedIndex, SSegDirection direction) {
        NSLog(@"----->%ld",seletedIndex);
        [self setViewControllers:@[_arrCVCItems[seletedIndex]] direction:direction==SSegDirectionLeft? UIPageViewControllerNavigationDirectionForward:UIPageViewControllerNavigationDirectionReverse animated:YES completion:NULL];
    }];


    [self setConsultingItemViewControllers];
}



-(void)setConsultingItemViewControllers{
    if (!_arrCVCItems) {
        _arrCVCItems = [NSMutableArray array];
    }
    for (int i=0; i<_arr_Items.count; i++) {
        if (i==0) {
            QuanZiMainListVC *mainListVC = [[QuanZiMainListVC alloc] init];
            mainListVC.view.frame = CGRectMake(0, 64+self.scrollSeg.frame.size.height+self.scrollSeg.frame.origin.y, self.view.frame.size.width, self.view.frame.size.height*0.4);
            [_arrCVCItems addObject:mainListVC];
        }else if (i == 1){
            QuanZiMineListVC *mineListVC = [[QuanZiMineListVC alloc] init];
            mineListVC.view.frame = CGRectMake(0, 64+self.scrollSeg.frame.size.height+self.scrollSeg.frame.origin.y, self.view.frame.size.width, self.view.frame.size.height*0.4);
            [_arrCVCItems addObject:mineListVC];
        }
        else{
            UIViewController *vc = [[UIViewController alloc] init];
            vc.view.frame = CGRectMake(0, 64+self.scrollSeg.frame.size.height+self.scrollSeg.frame.origin.y, self.view.frame.size.width, self.view.frame.size.height*0.4);
            [_arrCVCItems addObject:vc];
        }
    }

    self.currentCVC = _arrCVCItems[0];

    [self setViewControllers:@[_arrCVCItems[0]] direction:UIPageViewControllerNavigationDirectionForward animated:NO completion:NULL];
}


#pragma mark - PageViewControllerDelegate methods
-(UIViewController *)pageViewController:(UIPageViewController *)pageViewController viewControllerAfterViewController:(UIViewController *)viewController{

    //    return nil;
#if 1
    int index = (int)[_arrCVCItems indexOfObject:viewController];
    //    [self showIndex:index];
    printf("----> %d\n",index);

    [_scrollSeg setSeletedIndex:index];

    if (index<[_arrCVCItems count]-1) {
        _currentCVC = [_arrCVCItems objectAtIndex:index+1];
        return _currentCVC;
    }else{
        return nil;
    }
#endif

}

-(UIViewController *)pageViewController:(UIPageViewController *)pageViewController viewControllerBeforeViewController:(UIViewController *)viewController{

    //    return nil;

#if 1
    int index = (int)[_arrCVCItems indexOfObject:viewController];
    //    [self showIndex:index];
    printf("%d<----\n",index);
    [_scrollSeg setSeletedIndex:index];

    if (index>0) {

        _currentCVC = [_arrCVCItems objectAtIndex:index-1];
        return _currentCVC;
    }else{

        return nil;
    }
    
#endif
    
}


@end
