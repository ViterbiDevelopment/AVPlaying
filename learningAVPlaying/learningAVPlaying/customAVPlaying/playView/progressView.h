//
//  progressView.h
//  learningAVPlaying
//
//  Created by 掌上先机 on 16/11/4.
//  Copyright © 2016年 wangchao. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef enum : NSUInteger {
    PLAY = 1,
    PAUSE = 2
} playStaus;

@protocol progressViewDelegate <NSObject>

@optional


-(void)playOrPause:(playStaus)status;

-(void)fullScreenBtnClick;

@end

@interface progressView : UIView


@property(nonatomic,strong)UISlider *progress;

@property(nonatomic,strong)UIButton *playButton;

@property(nonatomic,strong)UIButton *screenFullButton;


@property(nonatomic,assign)id<progressViewDelegate> delegate;


@end
