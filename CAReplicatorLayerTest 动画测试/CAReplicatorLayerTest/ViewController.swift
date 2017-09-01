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
        animation4();
        animation5();
        addVoieView();
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
        r.backgroundColor = UIColor.lightGray.cgColor
        view.layer.addSublayer(r)
        
        
        let bar = CALayer()
        bar.bounds = CGRect(x: 0.0, y: 0.0, width: 8.0, height: 40.0)
        bar.position = CGPoint(x: 10.0, y: 75.0)
        bar.cornerRadius = 2.0
        bar.backgroundColor = randromColor().cgColor
        r.addSublayer(bar)
        
        
        let move = CABasicAnimation(keyPath: "position.y")
        move.toValue = bar.position.y - 35.0
        move.duration = 0.5
        move.autoreverses = true
        move.repeatCount = Float.infinity
        bar.add(move, forKey: nil)
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
        r.frame = CGRect(x: 140,y: 20,width: 180.0,height: 180.0)
        r.cornerRadius = 10.0
        r.backgroundColor = UIColor(white:0.0,alpha:0.75).cgColor
        // 锚点
        //        r.position = view.center
        view.layer.addSublayer(r)
        
        
        // 创建一个小点
        let dot = CALayer()
        dot.bounds = CGRect(x: 0.0,y: 0.0,width: 14.0,height: 14.0)
        dot.position = CGPoint(x: 100.0,y: 40.0)
        dot.backgroundColor = randromColor().cgColor
        dot.borderColor = randromColor().cgColor
        dot.borderWidth = 1.0
        dot.cornerRadius = 3.0
        r.addSublayer(dot)
        
        // 复制15个小白点
        let nrDots : Int = 15
        r.instanceCount = nrDots
        let angle = CGFloat(2 * Double.pi)/CGFloat(nrDots)
        r.instanceTransform = CATransform3DMakeRotation(angle, 0.0, 0.0, 1.0)
        
        // 添加动画
        dot.transform = CATransform3DMakeScale(0.01,0.01,0.01)
        
        let duration : CFTimeInterval = 1.5
        let shrink = CABasicAnimation(keyPath:"transform.scale")
        shrink.fromValue = 1.0
        shrink.toValue = 0.1
        shrink.duration = duration
        shrink.repeatCount = Float.infinity
        dot.add(shrink,forKey:nil)
        
        // 设置动画间隔
        r.instanceDelay = duration/Double(nrDots)
        
    }
    /**
    跟随动画
    */
    func animation3(){
        let r = CAReplicatorLayer()
        r.bounds = CGRect(x: 0, y: 0, width: 300, height: 300)
        r.cornerRadius = 10;
        
        r.position = self.view.center
        r.backgroundColor = UIColor( white:0.0,alpha:0.25).cgColor
        r.position = view.center
        view.layer.addSublayer(r)
        // 添加一个亮点
        let dot = CALayer()
        dot.bounds = CGRect(x: 0.0, y: 0.0, width: 10.0, height: 10.0)
        dot.backgroundColor = UIColor(white: 0.8,alpha:1.0).cgColor
        dot.borderColor = UIColor(white:1.0,alpha:1.0).cgColor
        dot.borderWidth = 1.0
        dot.cornerRadius = 5.0
        dot.shouldRasterize = true
        dot.rasterizationScale = UIScreen.main.scale
        r.addSublayer(dot)
        dot.position = CGPoint(x: 94.5,y: 214.5)
        
        let move = CAKeyframeAnimation(keyPath:"position")
        move.path = rw()
        move.repeatCount = Float.infinity
        move.duration = 4.0
        dot.add(move,forKey:nil)
        // 20个圆点
        r.instanceCount = 20
        r.instanceDelay = 0.1
        // 设置复制动画的颜色
        r.instanceColor = randromColor().cgColor
        r.instanceRedOffset = -0.03
        r.instanceGreenOffset = -0.03
        r.instanceBlueOffset = -0.03
        
    }
    func rw() -> CGPath {
        //贝齐尔制图
        let bezierPath = UIBezierPath()
        bezierPath.move(to: CGPoint(x: 31.5,y: 71.5))
        bezierPath.addLine(to: CGPoint(x: 31.5,y: 23.5))
        bezierPath.addCurve(to: CGPoint(x: 58.5, y: 38.5),
            controlPoint1:CGPoint(x: 31.5,y: 23.5),
            controlPoint2:CGPoint(x: 62.46,y: 18.69))
        bezierPath.addCurve(to: CGPoint(x: 53.5,y: 45.5),
            controlPoint1:CGPoint(x: 57.5,y: 43.5),
            controlPoint2:CGPoint(x: 53.5,y: 45.5))
        bezierPath.addLine(to: CGPoint(x: 43.5,y: 48.5))
        bezierPath.addLine(to: CGPoint(x: 53.5,y: 66.5))
        bezierPath.addLine(to: CGPoint(x: 62.5,y: 51.5))
        bezierPath.addLine(to: CGPoint(x: 70.5,y: 66.5))
        bezierPath.addLine(to: CGPoint( x: 86.5,y: 23.5))
        bezierPath.addLine(to: CGPoint(x: 86.5,y: 78.5))
        bezierPath.addLine(to: CGPoint(x: 31.5,y: 78.5))
        bezierPath.addLine(to: CGPoint(x: 31.5,y: 71.5))
        bezierPath.close()
        
        var T = CGAffineTransform(scaleX: 3.0, y: 3.0)
        return bezierPath.cgPath.copy(using: &T)!
    }
    
    func randromColor() ->UIColor{
        return UIColor(red: CGFloat (arc4random_uniform(255)) / 255.0, green: CGFloat (arc4random_uniform(255)) / 255.0, blue: CGFloat (arc4random_uniform(255)) / 255.0, alpha: 1.0);
    }
    
    
    /**
     * 录音抖动的效果
     */
    func animation4() {
        let frame = CGRect(x: 0, y: self.view.bounds.height - 200, width: self.view.bounds.width, height: 60);
        let voiceView = UIView(frame: frame)
        voiceView.backgroundColor = randromColor();
        self.view.addSubview(voiceView);
        let right = CAReplicatorLayer()
        right.frame = CGRect(x: voiceView.frame.width * 0.5 + 20, y: 0, width: voiceView.frame.width * 0.5 - 20, height: 60.0)
        right.backgroundColor = UIColor.clear.cgColor
        voiceView.layer.addSublayer(right)
        
        let rightBar = CALayer()
        rightBar.frame = CGRect(x: 0.0, y: 0.0, width: 4, height: 10)
        rightBar.position = CGPoint(x: 2, y: 20)
        rightBar.cornerRadius = 2.0
        rightBar.backgroundColor = UIColor.orange.cgColor
        right.addSublayer(rightBar)
        let move = CABasicAnimation(keyPath: "transform.scale.y")
        move.toValue  = 2.0;
        move.duration = 0.2
        move.autoreverses = true
        move.repeatCount = Float.infinity
        rightBar.add(move, forKey: nil)
        right.instanceCount = 20
        // 每个的偏移
        right.instanceTransform = CATransform3DMakeTranslation(7.0,0.0,0.0)
        // 每个动画 的偏移时间
        right.instanceDelay = 0.1
        
        right.masksToBounds = true
        
        
        let left = CAReplicatorLayer()
        left.frame = CGRect(x:0 , y: 0, width: voiceView.frame.width * 0.5 - 20, height: 60.0)
        left.backgroundColor = UIColor.clear.cgColor
        voiceView.layer.addSublayer(left)
        let leftBar = CALayer()
        leftBar.frame = CGRect(x:left.frame.width , y: 0.0, width: 4, height: 10)
        leftBar.position = CGPoint(x: left.frame.width - 2, y: 20)
        leftBar.cornerRadius = 2.0
        leftBar.backgroundColor = UIColor.orange.cgColor
        left.addSublayer(leftBar)
        leftBar.add(move, forKey: nil)
        left.instanceCount = 20
        // 每个的偏移
        left.instanceTransform = CATransform3DMakeTranslation(-7.0,0.0,0.0)
        // 每个动画 的偏移时间
        left.instanceDelay = 0.1
        
        left.masksToBounds = true
        
    }
    
    /**
     动画加载的效果
     */
    func animation5(){
        let r = CAReplicatorLayer()
        r.frame = CGRect(x: 20,y: 100,width: 100.0,height: 100.0)
        r.cornerRadius = 10.0
        r.backgroundColor = UIColor(white:0.0,alpha:0.75).cgColor
        // 锚点
        view.layer.addSublayer(r)
        
        
        // 创建一个小点
        let dot = CALayer()
        dot.bounds = CGRect(x: 0.0,y: 0.0,width: 10.0,height: 10.0)
        dot.position = CGPoint(x: 20.0,y: 50.0)
        dot.backgroundColor = randromColor().cgColor
        dot.borderColor = randromColor().cgColor
        dot.borderWidth = 1.0
        dot.cornerRadius = 5.0
        r.addSublayer(dot)
        
        // 复制15个小白点
        let nrDots : Int = 3
        r.instanceCount = nrDots
        // 每个的偏移
        r.instanceTransform = CATransform3DMakeTranslation(20.0,0.0,0.0)
        // 每个动画 的偏移时间
        r.instanceDelay = 0.33
        
        let duration : CFTimeInterval = 1.0
        let shrink = CABasicAnimation()
        shrink.keyPath = "opacity"
        shrink.fromValue = 1.0
        shrink.toValue = 0.1
        shrink.duration = duration
        shrink.repeatCount = Float.infinity
        dot.add(shrink,forKey:nil)
        
//        let move = CAKeyframeAnimation(keyPath:"position")
//        move.path = linePath(fromPoint: dot.position)
//        move.repeatCount = Float.infinity
//        move.duration = 2.0
//        dot.add(move,forKey:nil)

        
        
        // 设置动画间隔
        r.instanceDelay = duration/Double(nrDots)
        
    }
    
    func linePath(fromPoint: CGPoint) -> CGPath {
        //贝齐尔制图
        let bezierPath = UIBezierPath()
        bezierPath.move(to: CGPoint(x: fromPoint.x - 50.0,y: fromPoint.y))
        bezierPath.addLine(to: CGPoint(x: fromPoint.x,y: fromPoint.y))
        bezierPath.addLine(to: CGPoint(x: fromPoint.x - 50.0,y: fromPoint.y))
        bezierPath.close()
        return bezierPath.cgPath
    }
    
    func addVoieView(){
    
        let frame = CGRect(x: 0, y: self.view.bounds.height - 140, width: self.view.bounds.width, height: 140);
        let voiceView = XXBVoiceView(frame:frame)
        voiceView.backgroundColor = UIColor.yellow
        self.view.addSubview(voiceView)
    }
    
}

