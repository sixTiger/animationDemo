//
//  XXBView.h
//  ProgressAnimation
//
//  Created by xiaobing on 16/1/5.
//  Copyright © 2016年 xiaobing. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface XXBView : UIView
@property(nonatomic , assign) CGFloat   lineWidth;
@property(nonatomic , strong) UIColor   *backLineColor;
@property(nonatomic , strong) UIColor   *lineColor;
@property(nonatomic , assign) CGFloat   percent;
@end
