//
//  playView+playControl.h
//  learningAVPlaying
//
//  Created by 掌上先机 on 16/11/6.
//  Copyright © 2016年 wangchao. All rights reserved.
//


#import "playView.h"

static void * VTPlayControlPropertyPlayControlGestureRecognizer;
static void * VTControlPropertyMoveToSecond;


@interface playView (playControl)<UIGestureRecognizerDelegate>

@property(nonatomic,assign)CGFloat moveToSecond;

@property(nonatomic,strong,readonly)UIPanGestureRecognizer *controlGester;



-(void)initControlGester;

-(void)moveToTime:(CGFloat)time;


@end
