//
//  SwiftView.swift
//  LYYZPlat
//
//  Created by xw.long on 16/1/22.
//  Copyright © 2016年 xw.long. All rights reserved.
//

import UIKit



//协议代理
protocol SwiftViewDelegate{
    func touchEvent()
}


typealias touchBlock = (Int)  ->()//(1)


class SwiftView: UIView {
    
    var delegate:SwiftViewDelegate?
    
    var blockClick:touchBlock?//(2)
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setUp()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        
        setUp()
    }
    
    func setUp() {
        
        print("blockPropertyA = \(blockClick)")

        //Or any init you can use to perform some custom initialization
        self.layer.borderColor = UIColor.redColor().CGColor;
        self.layer.borderWidth = 1;
        self.exclusiveTouch = true;
        
        let tapG:UITapGestureRecognizer = UITapGestureRecognizer.init(target: self, action: Selector("tapGuresture:"))
        self.addGestureRecognizer(tapG)

        
        let doubleTouch:UITapGestureRecognizer = UITapGestureRecognizer.init(target: self, action: Selector("tapGuresture:"))
        doubleTouch.numberOfTapsRequired = 2
        self.addGestureRecognizer(doubleTouch)
        
        tapG.requireGestureRecognizerToFail(doubleTouch)//解决双击被单击拦截的问题
        
    }
    
    func tapGuresture(tapG:UITapGestureRecognizer) {
        let touchs = tapG.numberOfTapsRequired
        if(touchs == 1){
            print("hello onetouches, click")

            if((self.delegate) != nil){
                self.delegate?.touchEvent()
            }
            
        }else if(touchs == 2){
            print("touches == 2 ,click")
            
            self.blockClick!(touchs+2)//(3_1)
            
            self.eventBlock(blockClick,numbers: touchs)//(3_2)
            //这个地方使用了两种block回调方式，3_1,3_2
            //3_1:优点是直接调用block函数块，缺点是如果找不到对应的block块，程序崩溃
            //3_2:优点是回调函数块不是必须的，缺点是需要添加一个函数代码块对回调函数快的存在做一个判断，为了安全起见，最好使用这种形式的回调方法。
        }
    }
    
    func eventBlock(thistouchB:touchBlock!,numbers:Int){
        if let _ = thistouchB{
            thistouchB(numbers)
        }
    }
    
}
