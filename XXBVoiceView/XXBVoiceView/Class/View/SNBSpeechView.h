//
//  SNBSpeechView.h
//  SinaBlog
//
//  Created by ych on 15/10/29.
//  Copyright © 2015年 Robin. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol SNBSpeechViewDelegate;

@interface SNBSpeechView : UIView

@property (nonatomic, weak)id<SNBSpeechViewDelegate> delegate;

- (void)startRecognize;
- (void)stopRecognize;
- (void)volumeChanged: (int)volume;

@end


@protocol SNBSpeechViewDelegate <NSObject>

- (void)speech:(SNBSpeechView *)speechView shouldRecognize:(BOOL)shouldRecognize;

@end