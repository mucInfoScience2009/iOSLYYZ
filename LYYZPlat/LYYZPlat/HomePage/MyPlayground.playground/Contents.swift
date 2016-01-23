//: Playground - noun: a place where people can play

import UIKit

var str = "Hello, playground"




for index in 1...5 {
    print("\(index) times 5 is \(index * 5)")
}


for index in 1...5 {
    let number:NSNumber = NSNumber.init(integer: index);
}

var fontArr = UIFont.familyNames();

for fontName:NSString in fontArr{
    NSLog(fontName as String, fontName)
}


var i = 0
let span:CGFloat     = 10.0
let screen_w:CGFloat = 320
let label_w  = (screen_w - 2.0*span)/2
let label_h:CGFloat  =  30

for fontName:NSString in fontArr {
    NSLog(fontName as String, fontName)
    
    let label:UILabel = UILabel.init(frame: CGRectMake(span+(screen_w) * (CGFloat)(i%2), span, label_w, label_h))
    i++;
}





