//
//  SwiftView.swift
//  LYYZPlat
//
//  Created by xw.long on 16/1/22.
//  Copyright © 2016年 xw.long. All rights reserved.
//

import UIKit


class SwiftView: UIView {
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setUp()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        
        setUp()
    }
    
    func setUp() {
        //Or any init you can use to perform some custom initialization
        
    }

    /*
    // Only override drawRect: if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func drawRect(rect: CGRect) {
        // Drawing code
    }
    */
}
