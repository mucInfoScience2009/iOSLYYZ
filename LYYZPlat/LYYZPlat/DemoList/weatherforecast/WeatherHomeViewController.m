//
//  WeatherHomeViewController.m
//  LYYZPlat
//
//  Created by 龙学武 on 16/1/18.
//  Copyright © 2016年 xw.long. All rights reserved.
//

#import "WeatherHomeViewController.h"

@interface WeatherHomeViewController ()

@property (nonatomic, strong) UISegmentedControl *segmentCotnrol;

@end

@implementation WeatherHomeViewController


-(void)viewWillAppear:(BOOL)animated{
    [self.tabBarController.tabBar setHidden:YES];
}

-(UISegmentedControl *)segmentCotnrol{
    if (!_segmentCotnrol) {
        _segmentCotnrol = [[UISegmentedControl alloc] initWithFrame:CGRectMake(0, self.view.frame.size.height-64-50, k_SizeScreen.width, 50)];
        _segmentCotnrol.backgroundColor = [UIColor yellowColor];
        [_segmentCotnrol addTarget:self action:@selector(segmentControlClick:) forControlEvents:UIControlEventValueChanged];
        [_segmentCotnrol insertSegmentWithTitle:@"One" atIndex:0 animated:YES];
        [_segmentCotnrol insertSegmentWithTitle:@"One" atIndex:1 animated:YES];
        [_segmentCotnrol insertSegmentWithTitle:@"One" atIndex:2 animated:YES];
        [_segmentCotnrol insertSegmentWithTitle:@"One" atIndex:3 animated:YES];
    }
    return _segmentCotnrol;
}
- (void)segmentControlClick:(UISegmentedControl *)segContrl{
    MUCLog(@"selected index = %ld",(long)segContrl.selectedSegmentIndex);
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self.view addSubview:self.segmentCotnrol];

}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
