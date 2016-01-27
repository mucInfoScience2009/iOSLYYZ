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


//typealias funcBlock = (Int)  ->Int




class SwiftView: UIView {
    
    var delegate:SwiftViewDelegate?
    
    var blockClick:funcBlock?
    
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
    }
    
    func tapGuresture(tapG:UITapGestureRecognizer) {
        let touchs = tapG.numberOfTouches()
        if(touchs == 1){
            print("hello onetouches, click")

            if((self.delegate) != nil){
                self.delegate?.touchEvent()
            }
            
        }else if(touchs == 2){
            print("touches == 2 ,click")
//            self.blockClick!(touchs)
        }
        
    }
    
    
    /*
    // Only override drawRect: if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func drawRect(rect: CGRect) {
        // Drawing code
    }
    */
}
