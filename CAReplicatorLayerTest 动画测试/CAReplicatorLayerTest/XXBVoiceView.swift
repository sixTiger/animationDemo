//
//  XXBVoiceView.swift
//  CAReplicatorLayerTest
//
//  Created by xiaobing on 15/11/23.
//  Copyright © 2015年 杨小兵. All rights reserved.
//

import UIKit

class XXBVoiceView: UIView {

    override init(frame: CGRect) {
         super.init(frame: frame)
        addButton()
    
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func addButton() {
    
        let voiceButton = UIButton(type: UIButtonType.Custom)
        voiceButton.frame = CGRectMake(0 , 0, 100, 100)
        self.addSubview(voiceButton)
        voiceButton.center = CGPointMake(CGRectGetWidth(UIScreen.mainScreen().bounds) * 0.5, CGRectGetHeight(self.frame) * 0.5)
        voiceButton.setImage(UIImage(named: "voice"), forState: UIControlState.Normal)
        voiceButton.backgroundColor = UIColor.orangeColor()
        voiceButton.layer.cornerRadius = 50;
        voiceButton.clipsToBounds = true
    }
    func animation() {
        let frame = CGRectMake(0, CGRectGetHeight(self.bounds) - 200, CGRectGetWidth(self.bounds), 200);
        let voiceView = UIView(frame: frame)
        voiceView.backgroundColor = UIColor.yellowColor()
        self.addSubview(voiceView);
        let right = CAReplicatorLayer()
        right.frame = CGRect(x: CGRectGetWidth(voiceView.frame) * 0.5 + 20, y: 0, width: CGRectGetWidth(voiceView.frame) * 0.5 - 20, height: 60.0)
        right.backgroundColor = UIColor.clearColor().CGColor
        voiceView.layer.addSublayer(right)
        let rightBar = CALayer()
        rightBar.frame = CGRect(x: 0.0, y: 0.0, width: 4, height: 10)
        rightBar.position = CGPoint(x: 2, y: 20)
        rightBar.cornerRadius = 2.0
        rightBar.backgroundColor = UIColor.orangeColor().CGColor
        right.addSublayer(rightBar)
        let move = CABasicAnimation(keyPath: "transform.scale.y")
        move.toValue  = 2.0;
        move.duration = 0.2
        move.autoreverses = true
        move.repeatCount = Float.infinity
        rightBar.addAnimation(move, forKey: nil)
        right.instanceCount = 20
        // 每个的偏移
        right.instanceTransform = CATransform3DMakeTranslation(7.0,0.0,0.0)
        // 每个动画 的偏移时间
        right.instanceDelay = 0.1
        right.masksToBounds = true
        
        
        
        let left = CAReplicatorLayer()
        left.frame = CGRect(x:0 , y: 0, width: CGRectGetWidth(voiceView.frame) * 0.5 - 20, height: 60.0)
        left.backgroundColor = UIColor.clearColor().CGColor
        voiceView.layer.addSublayer(left)
        let leftBar = CALayer()
        leftBar.frame = CGRect(x:CGRectGetWidth(left.frame) , y: 0.0, width: 4, height: 10)
        leftBar.position = CGPoint(x: CGRectGetWidth(left.frame) - 2, y: 20)
        leftBar.cornerRadius = 2.0
        leftBar.backgroundColor = UIColor.orangeColor().CGColor
        left.addSublayer(leftBar)
        leftBar.addAnimation(move, forKey: nil)
        left.instanceCount = 20
        // 每个的偏移
        left.instanceTransform = CATransform3DMakeTranslation(-7.0,0.0,0.0)
        // 每个动画 的偏移时间
        left.instanceDelay = 0.1
        left.masksToBounds = true
        
    }


}
