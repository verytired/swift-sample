//
//  drawView.swift
//  swift-drawing
//
//  Created by yutaka on 2015/09/06.
//  Copyright (c) 2015年 Yutaka. All rights reserved.
//


import UIKit

class drawView: UIView {
    
    var lines: [Line] = []
    var lastPoint: CGPoint!
    
    required init(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        //self.backgroundColor = UIColor.blackColor() //チェック用
    }
    
    override func touchesBegan(touches: Set<NSObject>, withEvent event: UIEvent) {
        let touch = touches.first as! UITouch
        lastPoint = touch.locationInView(self)
    }
    
    
    override func touchesMoved(touches: Set<NSObject>, withEvent event: UIEvent) {
        let touch = touches.first as! UITouch
        let newPoint = touch.locationInView(self)
        lines.append(Line(start: lastPoint, end: newPoint))
        lastPoint = newPoint
        self.setNeedsDisplay()
    }
    
    override func drawRect(rect: CGRect) {
        var context = UIGraphicsGetCurrentContext()
        CGContextBeginPath(context)
        
        for line in lines {
            CGContextMoveToPoint(context, line.start.x, line.start.y)
            CGContextAddLineToPoint(context, line.end.x, line.end.y)
        }
        
        CGContextSetRGBStrokeColor(context, 1, 0, 0, 1) //線の色
        CGContextSetLineWidth(context, 10)  //線の太さ
        CGContextSetLineCap(context, kCGLineCapRound)   //線を滑らかに
        CGContextStrokePath(context)
    }
}