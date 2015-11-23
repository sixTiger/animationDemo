//
//  ViewController.swift
//  CAReplicatorLayerTest
//
//  Created by 杨小兵 on 15/9/7.
//  Copyright (c) 2015年 杨小兵. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        animation1();
        animation2();
        animation3();
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    /**
    音乐抖动的效果
    */
    func animation1() {
        let r = CAReplicatorLayer()
        r.frame = CGRect(x: 20.0, y: 20.0, width: 60.0, height: 60.0)
        r.backgroundColor = UIColor.lightGrayColor().CGColor
        view.layer.addSublayer(r)
        
        
        let bar = CALayer()
        bar.bounds = CGRect(x: 0.0, y: 0.0, width: 8.0, height: 40.0)
        bar.position = CGPoint(x: 10.0, y: 75.0)
        bar.cornerRadius = 2.0
        bar.backgroundColor = randromColor().CGColor
        r.addSublayer(bar)
        
        
        let move = CABasicAnimation(keyPath: "position.y")
        move.toValue = bar.position.y - 35.0
        move.duration = 0.5
        move.autoreverses = true
        move.repeatCount = Float.infinity
        bar.addAnimation(move, forKey: nil)
        // 复制三份
        r.instanceCount = 3
        // 每个的偏移
        r.instanceTransform = CATransform3DMakeTranslation(20.0,0.0,0.0)
        // 每个动画 的偏移时间
        r.instanceDelay = 0.33
        
        r.masksToBounds = true
        
        
    }
    /**
    动画加载的效果
    */
    func animation2(){
        let r = CAReplicatorLayer()
        r.frame = CGRectMake(100,20,200.0,200.0)
        r.cornerRadius = 10.0
        r.backgroundColor = UIColor(white:0.0,alpha:0.75).CGColor
        // 锚点
        //        r.position = view.center
        view.layer.addSublayer(r)
        
        
        // 创建一个小点
        let dot = CALayer()
        dot.bounds = CGRectMake(0.0,0.0,14.0,14.0)
        dot.position = CGPointMake(100.0,40.0)
        dot.backgroundColor = randromColor().CGColor
        dot.borderColor = randromColor().CGColor
        dot.borderWidth = 1.0
        dot.cornerRadius = 3.0
        r.addSublayer(dot)
        
        // 复制15个小白点
        let nrDots : Int = 15
        r.instanceCount = nrDots
        let angle = CGFloat(2 * M_PI)/CGFloat(nrDots)
        r.instanceTransform = CATransform3DMakeRotation(angle, 0.0, 0.0, 1.0)
        
        // 添加动画
        dot.transform = CATransform3DMakeScale(0.01,0.01,0.01)
        
        let duration : CFTimeInterval = 1.5
        let shrink = CABasicAnimation(keyPath:"transform.scale")
        shrink.fromValue = 1.0
        shrink.toValue = 0.1
        shrink.duration = duration
        shrink.repeatCount = Float.infinity
        dot.addAnimation(shrink,forKey:nil)
        
        // 设置动画间隔
        r.instanceDelay = duration/Double(nrDots)
        
    }
    /**
    跟随动画
    */
    func animation3(){
        let r = CAReplicatorLayer()
        r.bounds = CGRectMake(0, 0, 300, 300)
        r.cornerRadius = 10;
        
        r.position = self.view.center
        r.backgroundColor = UIColor( white:0.0,alpha:0.25).CGColor
        r.position = view.center
        view.layer.addSublayer(r)
        // 添加一个亮点
        let dot = CALayer()
        dot.bounds = CGRectMake(0.0, 0.0, 10.0, 10.0)
        dot.backgroundColor = UIColor(white: 0.8,alpha:1.0).CGColor
        dot.borderColor = UIColor(white:1.0,alpha:1.0).CGColor
        dot.borderWidth = 1.0
        dot.cornerRadius = 5.0
        dot.shouldRasterize = true
        dot.rasterizationScale = UIScreen.mainScreen().scale
        r.addSublayer(dot)
        dot.position = CGPointMake(94.5,214.5)
        
        let move = CAKeyframeAnimation(keyPath:"position")
        move.path = rw()
        move.repeatCount = Float.infinity
        move.duration = 4.0
        dot.addAnimation(move,forKey:nil)
        // 20个圆点
        r.instanceCount = 20
        r.instanceDelay = 0.1
        // 设置复制动画的颜色
        r.instanceColor = randromColor().CGColor
        r.instanceRedOffset = -0.03
        r.instanceGreenOffset = -0.03
        r.instanceBlueOffset = -0.03
        
    }
    func rw() -> CGPath {
        //贝齐尔制图
        let bezierPath = UIBezierPath()
        bezierPath.moveToPoint(CGPointMake(31.5,71.5))
        bezierPath.addLineToPoint(CGPointMake(31.5,23.5))
        bezierPath.addCurveToPoint(CGPointMake(58.5, 38.5),
            controlPoint1:CGPointMake(31.5,23.5),
            controlPoint2:CGPointMake(62.46,18.69))
        bezierPath.addCurveToPoint(CGPointMake(53.5,45.5),
            controlPoint1:CGPointMake(57.5,43.5),
            controlPoint2:CGPointMake(53.5,45.5))
        bezierPath.addLineToPoint(CGPointMake(43.5,48.5))
        bezierPath.addLineToPoint(CGPointMake(53.5,66.5))
        bezierPath.addLineToPoint(CGPointMake(62.5,51.5))
        bezierPath.addLineToPoint(CGPointMake(70.5,66.5))
        bezierPath.addLineToPoint(CGPointMake( 86.5,23.5))
        bezierPath.addLineToPoint(CGPointMake(86.5,78.5))
        bezierPath.addLineToPoint(CGPointMake(31.5,78.5))
        bezierPath.addLineToPoint(CGPointMake(31.5,71.5))
        bezierPath.closePath()
        
        var T = CGAffineTransformMakeScale(3.0, 3.0)
        return CGPathCreateCopyByTransformingPath(bezierPath.CGPath, &T)!
    }
    
    func randromColor() ->UIColor{
        return UIColor(red: CGFloat (arc4random_uniform(255)) / 255.0, green: CGFloat (arc4random_uniform(255)) / 255.0, blue: CGFloat (arc4random_uniform(255)) / 255.0, alpha: 1.0);
    }
    
}

