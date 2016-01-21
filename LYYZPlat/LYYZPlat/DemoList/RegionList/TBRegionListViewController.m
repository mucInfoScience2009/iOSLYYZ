//
//  TBRegionListViewController.m
//  Stock
//
//  Created by xw.long on 15/11/4.
//  Copyright © 2015年 com.tigerbrokers. All rights reserved.
//

#import "TBRegionListViewController.h"
#import "TBRegionDBManager.h"
#import "TBRegionCell.h"
#import "AFNetworking.h"

@interface TBRegionListViewController ()<UITableViewDelegate,UITableViewDataSource>

@property (nonatomic, strong) UILabel *titleLabel;
@property (nonatomic, strong) UITableView *tableView;

@end

@implementation TBRegionListViewController{
    NSMutableArray *_arrProvince;
    NSMutableArray *_arrCity;
    NSMutableArray *_arrDistrict;
    
    NSMutableDictionary *_dictShowProvince;
    
    RegionListBlock _RLBlock;
}
-(void)region:(RegionListBlock)thisBlock;
{
    _RLBlock = thisBlock;
}

-(UITableView *)tableView{
    if (!_tableView) {
        _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0,0,self.view.width, self.view.height) style:UITableViewStylePlain];
        
        _tableView.backgroundColor = COMMOM_TABLE_CELL_SELECTED;
        _tableView.dataSource = self;
        _tableView.delegate = self;
        _tableView.contentInset = UIEdgeInsetsMake(0, 0, 0, 0);
        _tableView.separatorColor = COLOR_SEPERATE_LINE;
        _tableView.scrollEnabled = YES;
        _tableView.tableFooterView = [UIView new];
        _tableView.separatorStyle = UITableViewCellSeparatorStyleSingleLine;
        
        if ([_tableView respondsToSelector:@selector(setSeparatorInset:)]) {
            [_tableView setSeparatorInset:UIEdgeInsetsMake(0, 0, 0, 0)];
        }
        if ([_tableView respondsToSelector:@selector(setLayoutMargins:)]) {
            [_tableView setLayoutMargins:UIEdgeInsetsMake(0, 0, 0, 0)];
        }
        
    }
    return _tableView;
}
-(NSString *)keyFromIndexPath:(NSIndexPath *)indexPath{
    return [NSString stringWithFormat:@"%ld_%ld",(long)indexPath.section,(long)indexPath.row];
}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return _arrProvince.count;
}
-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 40;
}
-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
     TBRegionShowView *sectionRegionView = [[TBRegionShowView alloc] initWithFrame:CGRectMake(-1, 0, k_RectScreen.size.width+2, 40)];
    sectionRegionView.layer.borderColor = COLOR_SEPERATE_LINE.CGColor;
    sectionRegionView.layer.borderWidth = 1;
    sectionRegionView.layer.shadowColor = [UIColor redColor].CGColor;
    sectionRegionView.layer.shadowRadius = 8;
    sectionRegionView.layer.shadowOffset = CGSizeMake(sectionRegionView.width*0.2, sectionRegionView.height*0.2);
    sectionRegionView.region = _arrProvince[section];
    weakSelf();
    [sectionRegionView regionShowBlock:^(TBRegion *region) {
        MUCLog(@"showor  %d",region.showSubRegion);
        NSString *strKey = [NSString stringWithFormat:@"%ld",section];
        if (region.showSubRegion) {
            NSArray *cityArr = [TBRegionDBManager getCityArrFromProvince:region.province];
            if (!_dictShowProvince) {
                _dictShowProvince = [NSMutableDictionary dictionary];
            }
            [_dictShowProvince setObject:cityArr forKey:strKey];
            
        }else{
            [_dictShowProvince setObject:@[] forKey:strKey];
        }
        [weakSelf.tableView reloadSections:[NSIndexSet indexSetWithIndex:section] withRowAnimation:UITableViewRowAnimationAutomatic];

    }];
    return sectionRegionView;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    NSString *strKey = [NSString stringWithFormat:@"%ld",section];
    NSArray *cityArr = [_dictShowProvince objectForKey:strKey];
    if (cityArr) {
        return cityArr.count;
    }else{
        return 0;
    }
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *identifier = @"regioncell";
    TBRegionCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    if (nil == cell) {
        cell = [[TBRegionCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
    }
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    
    NSString *strKey = [NSString stringWithFormat:@"%ld",indexPath.section];
    NSArray *cityArr = [_dictShowProvince objectForKey:strKey];
    if (cityArr) {
        
        [cell setTableViewCellItem:cityArr[indexPath.row]];
        
        weakSelf();
        [cell regionCell:^(TBRegion *region) {
            MUCLog(@"showor  %d",region.showSubRegion);
            NSArray *districtArr = [TBRegionDBManager getDistrictArrFromCity:region.city];

            if (region.showSubRegion) {
                for (TBRegion *region in districtArr) {
                    region.indexPath = indexPath;
                }
                
                NSMutableArray *slevelArr = [NSMutableArray arrayWithArray:cityArr];
                [slevelArr insertObjects:districtArr atIndexes:[NSIndexSet indexSetWithIndexesInRange:NSMakeRange(indexPath.row+1, districtArr.count)]];
                [_dictShowProvince setObject:slevelArr forKey:strKey];
            
            }else{
                NSMutableArray *slevelArr = [NSMutableArray array];
                for (TBRegion *region in cityArr) {
                    if (region.indexPath.section == indexPath.section && region.indexPath.row == indexPath.row) {
                        continue;
                    }else{
                        [slevelArr addObject:region];
                    }
                }
                
                [_dictShowProvince setObject:slevelArr forKey:strKey];
            }
            
            [weakSelf.tableView reloadSections:[NSIndexSet indexSetWithIndex:indexPath.section] withRowAnimation:UITableViewRowAnimationAutomatic];
            
        }];
    }
    
    return  cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    TBRegionCell *cell = [tableView cellForRowAtIndexPath:indexPath];
    if (cell.region.regionlevel == RegionLevelDist) {
        [self showHint:cell.region.district hide:1.2];
        if (_RLBlock) {
            _RLBlock (cell.region);
            
            [self.navigationController popViewControllerAnimated:YES];
        }
    }
}

-(void)viewWillAppear:(BOOL)animated{
    [self.tabBarController.tabBar setHidden:YES];
}
-(void)viewWillDisappear:(BOOL)animated{
    [self.tabBarController.tabBar setHidden:NO];
}


-(void)viewDidAppear:(BOOL)animated{
    [self showAlertControllerWithTitle:@"三级列表" andSubTitle:@"涉及知识点：数据库，数据解析，plist存储，UI之三级列表展开收起的一种实现方式"];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    
    
    
    
    [self.view addSubview:self.tableView];

    
    
    if ([TBRegionDBManager haveOldData])
    {
        MUCLog(@"haveData");
        _arrProvince = [NSMutableArray arrayWithArray:[TBRegionDBManager getProvinceArr]];
    }
    else{
        
        [self netGetRegionList];
    }
}


-(void)loadDataSource{
    NSString *filePath = [[NSBundle mainBundle] pathForResource:@"regionFile" ofType:@"plist"];
    NSArray *arrData = [NSArray arrayWithContentsOfFile:filePath];

    
    if ([arrData isEqual:[NSNull null]] || !arrData || ![arrData count]) {
        MUCLog(@" count zero .");
        return;
    }
    
    if (!_arrCity)
        _arrCity = [NSMutableArray array];
    
    if (!_arrDistrict)
        _arrDistrict = [NSMutableArray array];
    
    if (!_arrProvince)
        _arrProvince = [NSMutableArray array];
    
    for (NSDictionary *proDict in arrData)
    {
        TBRegion *proR = [[TBRegion alloc] initProvinceWithDict:proDict];
        [_arrProvince addObject:proR];
        
        NSArray *cityArr = [proDict objectForKey:@"city"];
        for (NSDictionary *cityDict in cityArr)
        {
            TBRegion *cityR = [[TBRegion alloc] initCityWithDict:cityDict];
            cityR.supID = proR.ID;
            cityR.supName = proR.province;
            [_arrCity addObject:cityR];
            
            NSArray *districtArr = [cityDict objectForKey:@"district"];
            for (NSDictionary *distDict in districtArr)
            {
                TBRegion *districtR = [[TBRegion alloc] initDistrictWithDict:distDict];
                districtR.supID = cityR.ID;
                districtR.supName = cityR.city;
                [_arrDistrict addObject:districtR];
            }
        }
    }
    
    
    [TBRegionDBManager saveProvinceArray:_arrProvince];
    [TBRegionDBManager saveCityArray:_arrCity];
    [TBRegionDBManager saveDistrictArray:_arrDistrict];
    
    [self.tableView reloadData];
    
}

-(void)netGetRegionList{
    NSURLSessionConfiguration *configuration = [NSURLSessionConfiguration defaultSessionConfiguration];
    AFURLSessionManager *manager = [[AFURLSessionManager alloc] initWithSessionConfiguration:configuration];
    
    
    NSString *urlSuffix  = @"https://hellohellohelloebaby";
    NSURL *URL = [NSURL URLWithString:urlSuffix];
    NSURLRequest *request = [NSURLRequest requestWithURL:URL];
    weakSelf();
    [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    NSURLSessionDataTask *dataTask = [manager dataTaskWithRequest:request completionHandler:^(NSURLResponse *response, id responseObject, NSError *error) {
        [MBProgressHUD hideAllHUDsForView:weakSelf.view animated:YES];
        if (error) {
            MUCLog(@"error = %@",error);
            
        }else {
            NSLog(@"%@ %@", response, responseObject);
        }
        
        [weakSelf loadDataSource];
    }];
    [dataTask resume];
}




//-(void)netGetRegionList{
//    
//    NSString *url = [NSString stringWithFormat:@"%@api/v1/area",@"https://www.tigerbrokers.com/"];
//    weakSelf();
//    
//    
//    [[TBHttpRequestManager sharedInstance] GET:url parameters:nil headers:nil inQueue:nil sucess:^(AFHTTPRequestOperation *operation, id responseObject) {
//        TBLog(@"%@",[responseObject allKeys]);
//        NSNumber *isSucc = [responseObject objectForKey:@"is_succ"];
//        if(!isSucc || [isSucc intValue] < 1){
////            NSString *errMSG = [responseObject objectForKey:@"error_msg"];
//            return ;
//        }
//        
//        NSArray *arrData = [responseObject objectForKey:@"data"];
//        if ([arrData isEqual:[NSNull null]] || !arrData || ![arrData count]) {
//            TBLog(@" count zero .");
//            return;
//        }
//        
//        if (!_arrCity)
//            _arrCity = [NSMutableArray array];
//        
//        if (!_arrDistrict)
//            _arrDistrict = [NSMutableArray array];
//        
//        if (!_arrProvince)
//            _arrProvince = [NSMutableArray array];
//        
//        for (NSDictionary *proDict in arrData)
//        {
//            TBRegion *proR = [[TBRegion alloc] initProvinceWithDict:proDict];
//            [_arrProvince addObject:proR];
//            
//            NSArray *cityArr = [proDict objectForKey:@"city"];
//            for (NSDictionary *cityDict in cityArr)
//            {
//                TBRegion *cityR = [[TBRegion alloc] initCityWithDict:cityDict];
//                cityR.supID = proR.ID;
//                cityR.supName = proR.province;
//                [_arrCity addObject:cityR];
//                
//                NSArray *districtArr = [cityDict objectForKey:@"district"];
//                for (NSDictionary *distDict in districtArr)
//                {
//                    TBRegion *districtR = [[TBRegion alloc] initDistrictWithDict:distDict];
//                    districtR.supID = cityR.ID;
//                    districtR.supName = cityR.city;
//                    [_arrDistrict addObject:districtR];
//                }
//            }
//        }
//        
//        
//        [TBRegionDBManager saveProvinceArray:_arrProvince];
//        [TBRegionDBManager saveCityArray:_arrCity];
//        [TBRegionDBManager saveDistrictArray:_arrDistrict];
//        
//        [weakSelf.tableView reloadData];
//
//        
//    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
//        
//    }];
//    
//}


-(BOOL)hasTBNavigationBar{
    return YES;
}
- (BOOL) autoGenerateBackBarButtonItem
{
    return YES;
}

- (BOOL) autoGenerateMenuBarButtonItem
{
    return NO;
}

- (BOOL)prefersStatusBarHidden
{
    return NO;
}

- (BOOL) enableDragBack
{
    return YES;
}

-(UIStatusBarStyle)preferredStatusBarStyle
{
    return UIStatusBarStyleLightContent;
}




@end
