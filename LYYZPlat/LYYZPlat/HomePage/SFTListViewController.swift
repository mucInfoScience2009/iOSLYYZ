//
//  SFTListViewController.swift
//  LYYZPlat
//
//  Created by xw.long on 16/1/22.
//  Copyright © 2016年 xw.long. All rights reserved.
//



import UIKit

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
        cell!.textLabel?.text = NSString.init(format: "index --> %d", number.integerValue) as String;
        return cell!;
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
