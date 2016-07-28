//
//  ViewController.h
//  XXBAnimationJDHome
//
//  Created by baidu on 16/7/28.
//  Copyright © 2016年 com.baidu. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ViewController : UIViewController

/**
 *  弹出的view
 */
@property(nonatomic,strong) UIView * popView;

/**
 *  rootview
 */
@property(nonatomic,strong) UIView * rootview;

/**
 *  rootVC
 */
@property(nonatomic,strong) UIViewController * rootVC;

/**
 *  maskView
 */
@property(nonatomic,strong) UIView * maskView;

/**
 *  初始化 rootVC:根VC， popView:弹出的view
 */
- (void)createPopVCWithRootVC:(UIViewController *)rootVC andPopView:(UIView *)popView;

@end

