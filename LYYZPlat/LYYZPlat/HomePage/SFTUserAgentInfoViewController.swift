//
//  SFTUserAgentInfoViewController.swift
//  LYYZPlat
//
//  Created by xw.long on 16/1/25.
//  Copyright © 2016年 xw.long. All rights reserved.
//

import UIKit

class SFTUserAgentInfoViewController: XXRootViewController ,UITableViewDataSource, UITableViewDelegate{
    
    var tableView:UITableView?
    var keys:NSArray?
    var userAgent:NSDictionary?
    var tempTitle:NSString?

    override func viewWillAppear(animated: Bool) {
        self.tabBarController!.tabBar.hidden = true;
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        if(tempTitle == nil){
            self.title = "用户设备属性"
        }else{
            self.title = tempTitle as! String
        }
        
        userAgent = getuserAgentInfo()
        print(userAgent)
        keys = userAgent!.allKeys
        
        configureTableView()
    }
    
    
    func configureTableView(){
        self.tableView = UITableView.init(frame: CGRectMake(0, 0, self.view.bounds.size.width, self.view.bounds.size.height), style: UITableViewStyle.Grouped)
        self.tableView?.dataSource = self;
        self.tableView?.delegate = self;
        self.view.addSubview(self.tableView!)
    }
    
//    tableViewDataSource
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let identifier:String = "SFTdeviceInfoItemCellIdentifier";
        var cell = tableView.dequeueReusableCellWithIdentifier(identifier);
        if(cell == nil){
            cell = UITableViewCell.init(style: UITableViewCellStyle.Subtitle, reuseIdentifier: identifier);
        }
        
        let key:NSString = (keys?.objectAtIndex(indexPath.section)) as! NSString;
        let value:NSString = userAgent?.objectForKey(key) as! NSString
        
        cell!.textLabel?.text = key as String
        cell!.detailTextLabel!.text = value as String
        
        return cell!
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
//    tableViewDelegate
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return (keys?.count)!
    }
    func tableView(tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let headerView:UIView = UIView.init(frame: CGRectMake(0, 0, self.view.bounds.size.width, 30.0))
        headerView.backgroundColor = UIColor.init(red: 0.5, green: 0.8, blue: 0.9, alpha: 1)
        headerView.layer.borderWidth = 1;
        headerView.layer.borderColor = UIColor.orangeColor().CGColor;
        headerView.layer.shadowColor = UIColor.redColor().CGColor;
        headerView.layer.shadowOffset = CGSize.init(width: 10, height: 10)
        
        let titleLabel:UILabel = UILabel.init(frame: CGRectMake(10, 7, 300, 16))
        titleLabel.text = keys?.objectAtIndex(section) as? String;
        titleLabel.font = UIFont.systemFontOfSize(16, weight: 20)
        titleLabel.textColor = UIColor.blueColor()
        headerView.addSubview(titleLabel)
        
        return headerView
    }
    func tableView(tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 30.0;
    }
    
    

  
//    或去设备基本信息
    func getuserAgentInfo() ->NSDictionary{
        let userAgentInfo:NSMutableDictionary = NSMutableDictionary()
        //	app版本
        let appVersion = NSBundle.mainBundle().objectForInfoDictionaryKey("CFBundleShortVersionString")
        
        //	设备唯一标识
        var imei:NSString  = OpenUDID.value();
        imei = imei.stringByReplacingPercentEscapesUsingEncoding(NSUTF8StringEncoding)!
        
        
        let appv = appVersion as! String
        
        let APkeyfrom:NSString = NSString.init(string: "MucScienceInfo2009"+appv+".iPhone")
        
        //	app平台KEYFROM
        let keyfrom:NSString = APkeyfrom.stringByReplacingPercentEscapesUsingEncoding(NSUTF8StringEncoding)!
        
        let winSize = UIScreen.mainScreen().bounds.size
//        设备屏幕大小
        let screenW = NSString.init(format: "%.0f", winSize.width)
        let screenH = NSString.init(format: "%.0f", winSize.height)
//        手机型号
        let model:NSString = UIDeviceHardware.platformString().stringByReplacingPercentEscapesUsingEncoding(NSUTF8StringEncoding)!
//        手机系统
        let mid:NSString = UIDevice.currentDevice().systemVersion.stringByReplacingPercentEscapesUsingEncoding(NSUTF8StringEncoding)!
        //	app安装渠道
        let vendor:NSString = NSString.init(string: "AppStrone").stringByReplacingPercentEscapesUsingEncoding(NSUTF8StringEncoding)!

        
        
        userAgentInfo.setValue("iOS", forKey: "platform")
        userAgentInfo.setValue(appVersion, forKey: "appVer")
        userAgentInfo.setValue(imei, forKey: "deviceId")
        userAgentInfo.setValue(screenH, forKey: "screenH")
        userAgentInfo.setValue(screenW, forKey: "screenW")
        userAgentInfo.setValue(model, forKey: "device")
        userAgentInfo.setValue(mid, forKey: "osVer")
        userAgentInfo.setValue(keyfrom, forKey: "keyfrom")
        userAgentInfo.setValue(vendor, forKey: "vendor")
        
        return userAgentInfo
    }
}
