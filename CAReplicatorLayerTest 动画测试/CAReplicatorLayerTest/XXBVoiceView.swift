//
//  XXBVoiceView.swift
//  CAReplicatorLayerTest
//
//  Created by xiaobing on 15/11/23.
//  Copyright © 2015年 杨小兵. All rights reserved.
//

import UIKit

class XXBVoiceView: UIView {

    var left : CAReplicatorLayer?;
    var right : CAReplicatorLayer?;
    let rightBar = CALayer()
    let leftBar = CALayer()
    override init(frame: CGRect) {
         super.init(frame: frame)
        addButton()
    
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func addButton() {
    
        let voiceButton = UIButton(type: UIButtonType.custom)
        voiceButton.frame = CGRect(x: 0 , y: 0, width: 80, height: 80)
        self.addSubview(voiceButton)
        voiceButton.center = CGPoint(x: UIScreen.main.bounds.width * 0.5, y: self.frame.height * 0.5)
        voiceButton.setImage(UIImage(named: "voice"), for: UIControlState())
        voiceButton.backgroundColor = UIColor.orange
        voiceButton.layer.cornerRadius = 40;
        voiceButton.clipsToBounds = true
        voiceButton.addTarget(self, action: #selector(XXBVoiceView.voiceButtonClick(_:)), for: UIControlEvents.touchUpInside)
    }
    
    func voiceButtonClick(_ clickButton : UIButton) {

        clickButton.isSelected = !clickButton.isSelected;
        if clickButton.isSelected {
            animation()
        } else {
            leftBar.removeAnimation(forKey: "LeftAnimation")
            rightBar.removeAnimation(forKey: "RightAnimation")
        }
        print("\(#function)")
    }
    
    func animation() {
        
        right = CAReplicatorLayer()
        right!.frame = CGRect(x: self.bounds.width * 0.5 + 30, y: 0, width: self.bounds.width * 0.5 - 20, height: 60.0)
        right!.backgroundColor = UIColor.clear.cgColor
        self.layer.addSublayer(right!)
        rightBar.frame = CGRect(x: 0.0, y: 0.0, width: 4, height: 10)
        rightBar.position = CGPoint(x: 2, y: 20)
        rightBar.cornerRadius = 2.0
        rightBar.backgroundColor = UIColor.orange.cgColor
        right!.addSublayer(rightBar)
        let move = CABasicAnimation(keyPath: "transform.scale.y")
        move.toValue  = 2.0;
        move.duration = 0.2
        move.autoreverses = true
        move.repeatCount = Float.infinity
        rightBar.add(move, forKey: "RightAnimation")
        right!.instanceCount = 20
        // 每个的偏移
        right!.instanceTransform = CATransform3DMakeTranslation(7.0,0.0,0.0)
        // 每个动画 的偏移时间
        right!.instanceDelay = 0.1
        right!.masksToBounds = true
        
        
        
        left = CAReplicatorLayer()
        left!.frame = CGRect(x:0 , y: 0, width: self.bounds.width * 0.5 - 30, height: 60.0)
        left!.backgroundColor = UIColor.clear.cgColor
        self.layer.addSublayer(left!)
        leftBar.frame = CGRect(x:left!.frame.width , y: 0.0, width: 4, height: 10)
        leftBar.position = CGPoint(x: left!.frame.width - 2, y: 20)
        leftBar.cornerRadius = 2.0
        leftBar.backgroundColor = UIColor.orange.cgColor
        left!.addSublayer(leftBar)
        leftBar.add(move, forKey: "LeftAnimation")
        left!.instanceCount = 20
        // 每个的偏移
        left!.instanceTransform = CATransform3DMakeTranslation(-7.0,0.0,0.0)
        // 每个动画 的偏移时间
        left!.instanceDelay = 0.1
        left!.masksToBounds = true
        
    }


}
