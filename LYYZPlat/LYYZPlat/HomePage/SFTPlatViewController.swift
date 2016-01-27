//
//  SFTPlatViewController.swift
//  LYYZPlat
//
//  Created by xw.long on 16/1/23.
//  Copyright © 2016年 xw.long. All rights reserved.
//

import UIKit

class SFTPlatViewController: XXRootViewController ,SwiftViewDelegate{
    
    
    

    var swView:SwiftView!
    
    var myView:SwiftView?
    
    func setUp(){
        
    }
    
    override func viewDidAppear(animated: Bool) {
        self.showAlertControllerWithTitle("Swift 代理简单尝试", andSubTitle: "你看看点击视图块的动画效果")
    }
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
    
        myView = SwiftView.init(frame: CGRectMake(100, 100, 100, 100))
        myView!.delegate = self
        myView!.backgroundColor = UIColor.orangeColor()
        self.view.addSubview(myView!)
        
        
//        myView?.blockClick =
//        
//        myView?.blockClick(2):
        
    }
    
    //SwiftViewDelegate
    func touchEvent() {
        
        UIView.animateKeyframesWithDuration(1, delay: 0, options: UIViewKeyframeAnimationOptions.CalculationModeCubic, animations: { () -> Void in
            self.myView?.frame = CGRectMake(100, 100, 100+(CGFloat)(arc4random()%200), 100+(CGFloat)(arc4random()%200))
            
            self.myView?.center = CGPoint.init(x: self.view.bounds.size.width*0.5, y: self.view.bounds.size.height*0.5)
            
            }) { (Bool) -> Void in
        }
        
        
        blockTest()
    }
    
    

    func blockTest(){
        var bk = BlocDemo()
        
        //block设置前,啥也没有输出
        bk.testProperty(0)
        bk.testProperty(1)
        bk.testProperty(2)
        bk.testProperty(3)
        print("＝＝＝＝＝＝＝＝＝＝＝＝＝＝设置block属性＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝")
        
        bk.blockProperty = {
            (a :Int,b:Int) -> String in
            let c = a*100+b
            return "\(a)*100+\(b) = \(c)"
        }
        bk.testProperty(0)
        
        bk.blockPropertyNoReturn = {
            (param:String) -> () in
            print("input param value is : \(param)")
        }
        bk.testProperty(1)
        
        bk.blockPropertyA = {
            (a:Int,b:Int) -> String in
            let c = a*100+b*200
            return "\(a)*100+\(b)*200 = \(c)"
        }
        bk.testProperty(2)
        
        bk.blockPropertyB = {
            (a:Int,b:Int) -> (String)->() in
            func sumprint(result:String)
            {
                let c = a + b;
                print("sumprint func print:parame :\(result) \(a) + \(b) = \(c)")
            }
            
            return sumprint
        }
        bk.testProperty(3)
        print("＝＝＝＝＝＝＝＝＝＝＝＝＝＝属性block完成＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝")
        
        print("＝＝＝＝＝＝＝＝＝＝＝＝＝＝函数block为nil时无输出＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝")
        bk.testBlock(nil)
        bk.testBlockA(nil)
        bk.testBlockB(nil)
        bk.testBlockC(nil)
        print("＝＝＝＝＝＝＝＝＝＝＝＝＝＝函数block操作＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝")
        bk.testBlock({
            //do something
            print("无参无返回值block 执行")
        })
        
        bk.testBlockA({
            (a:Int,b:Int) -> String in
            let c = a*400+b*1000
            return "\(a)*400 + \(b)*1000 is \(c)"
        })
        
        bk.testBlockB({
            (a:Int,b:Int) -> (String)->() in
            func sumprint(result:String)
            {  
                let c = a / b;  
                print("sumprint func print:parame :\(result) \(a) / \(b) = \(c)")  
            }  
            
            return sumprint  
        })  
        
        bk.testBlockC({  
            (a:Int,b:Int) -> (String)->String in  
            func sumrsult(res:String) -> String  
            {  
                let c = a*a+b*a  
                return "\(res) \(a)*\(a)+\(b)*\(a) = \(c)"  
            }  
            return sumrsult  
        })
        
        
    }
}
