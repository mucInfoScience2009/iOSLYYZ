//
//  SFTLabelViewController.swift
//  LYYZPlat
//
//  Created by xw.long on 16/1/23.
//  Copyright © 2016年 xw.long. All rights reserved.
//

import UIKit



public var mytitle:String?

class SFTLabelViewController: XXRootViewController {
    
//这些property必须要在designation initializer里实例化， 不然就用optional
    var scrollView:UIScrollView?
    var detailLabel:UILabel?
    var tmpString:String = String()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        self.title = self.tmpString
        
        
        self.view.backgroundColor = UIColor.blueColor()
        
        self.setUIItems()
        
    }
//    Swift 被调用的函数必须在调用函数所在的前方，否者将导致找不到方法二crash。
    func btnClick(btn:UIButton){
        NSLog("%@", (btn.titleLabel?.text)!)
        detailLabel!.font = UIFont.init(name: (btn.titleLabel?.text)!, size: 22)
    }

    
    func setUIItems(){
        self.scrollView = UIScrollView.init(frame:
            CGRectMake(0, 0, self.view.bounds.size.width, self.view.bounds.size.height*0.38))
        self.scrollView?.backgroundColor = UIColor.darkGrayColor()
        self.view.addSubview(scrollView!)
        
        
        
        let fontArr = UIFont.familyNames()
        
        var i = 0
        let span:CGFloat     = 6.0
        let screen_w:CGFloat = self.view.bounds.size.width
        let label_w  = (screen_w - 2.0*span)/2
        let label_h:CGFloat  =  38
        
        
        
        
        detailLabel = UILabel.init(frame: CGRectMake(2.0*span, (scrollView?.frame.height)!+(scrollView?.frame.origin.y)!+span, screen_w-4.0*span, self.view.bounds.size.height*0.4));
        detailLabel!.text = "hello man font-Family 夜夜水波前万里，风里流霜不觉飞，皎皎空中孤月轮，江畔何人初见月，江月何年初照人，青枫浦上不胜愁， love with the world，You If I 哈哈哈哈O(∩_∩)O哈！ 😄"
        detailLabel!.backgroundColor = UIColor.whiteColor()
        detailLabel!.numberOfLines = 0
        detailLabel!.textAlignment = NSTextAlignment.Center
        detailLabel!.textColor = UIColor.blackColor()
        self.view.addSubview(detailLabel!)

        
        
        for fontName:String in fontArr {
            NSLog(fontName as String, fontName)
            
            let frame:CGRect = CGRectMake(span/2+(screen_w/2)*(CGFloat)(i%2),span+(span+label_h)*(CGFloat)(i/2), label_w, label_h)
            
            let btnFont = UIButton.init(frame: frame)
            btnFont.setTitle(fontName, forState: UIControlState.Normal)
            btnFont.setTitleColor(UIColor.blueColor(), forState: UIControlState.Normal)
            btnFont.backgroundColor = UIColor.blackColor()
            btnFont.titleLabel?.font  = UIFont.init(name: fontName, size: 22)
            btnFont.layer.borderColor = UIColor.redColor().CGColor;
            btnFont.layer.borderWidth = 1;
            btnFont.layer.cornerRadius = btnFont.bounds.size.height*0.25
            btnFont.addTarget(self, action:Selector("btnClick:"), forControlEvents: UIControlEvents.TouchUpInside)
            
            scrollView?.addSubview(btnFont)
            
            
            i++;
            
            scrollView?.contentSize = CGSize.init(width: screen_w, height: (span+label_h)*(CGFloat)(i/2)+label_h)
            
        }
        
        
        
    }

}
