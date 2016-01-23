//
//  SFTListViewController.swift
//  LYYZPlat
//
//  Created by xw.long on 16/1/22.
//  Copyright © 2016年 xw.long. All rights reserved.
//



import UIKit


public var listItem:NSArray?

var dataSource:NSMutableArray=NSMutableArray();



class SFTListViewController: XXRootViewController,UITableViewDataSource,UITableViewDelegate{
    
    
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated);
        self.tabBarController?.tabBar.hidden = true;
    }
    override func viewWillDisappear(animated: Bool) {
        super.viewWillDisappear(animated);
        self.tabBarController?.tabBar.hidden = false;
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        self.view.backgroundColor = UIColor.redColor();
        
        
        listItem = NSArray.init(array: ["font-Family","More","YouKnow","","","","","",""])
        
        for index in 1...5 {
            let number:NSNumber = NSNumber.init(integer: index);
            dataSource.addObject(number);
        }
        
        
        
        let tableView:UITableView = UITableView.init(frame: CGRectMake(0, 0, self.view.bounds.size.width, self.view.bounds.size.height), style:UITableViewStyle.Plain);
        tableView.dataSource    = self;
        tableView.delegate      = self;
        self.view.addSubview(tableView);
        
    }

    
//    TableView  DataSource
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return dataSource.count;
        
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let identifier:String = "SFTListCellIdentifier";
        var cell = tableView.dequeueReusableCellWithIdentifier(identifier);
        if(cell == nil){
            cell = UITableViewCell.init(style: UITableViewCellStyle.Default, reuseIdentifier: identifier);
        }
        let number = dataSource.objectAtIndex(indexPath.row);
        cell!.textLabel?.text = NSString.init(format: "index --> %d   :%@", number.integerValue,(listItem?.objectAtIndex(indexPath.row))as! String) as String;

        return cell!;
    }
    
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        tableView.deselectRowAtIndexPath(indexPath, animated: true)
        
        if(indexPath.row == 0){
            let _stLabelVC:SFTLabelViewController = SFTLabelViewController();
            //值传递方式处理这个问题
            _stLabelVC.tmpString = "Font-Family"
            self.navigationController?.pushViewController(_stLabelVC, animated: true);
        }else if(indexPath.row == 1){
            let _stPlatVC:SFTPlatViewController = SFTPlatViewController();
            self.navigationController?.pushViewController(_stPlatVC, animated: true);
        }
    }
    
    
    
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
