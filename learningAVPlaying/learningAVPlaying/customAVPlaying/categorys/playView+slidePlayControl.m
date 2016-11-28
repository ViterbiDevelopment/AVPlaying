//
//  playView+slidePlayControl.m
//  learningAVPlaying
//
//  Created by 掌上先机 on 16/11/8.
//  Copyright © 2016年 wangchao. All rights reserved.
//

#import "playView+slidePlayControl.h"

#import "progressView.h"

#import "playView+playControl.h"

#import "playView+showHMSecond.h"

#import "progressSlideView.h"



@implementation playView (slidePlayControl)

-(void)addSlidePlayControl{

    

    progressView *progress = self.playProgress;
    
    progressSlideView *PsliderView = progress.sliderView;
    
    UISlider *slider = PsliderView.sliderView;
    

    [slider  addTarget:self action:@selector(sildeTouchDown:) forControlEvents:UIControlEventTouchDown];
    [slider addTarget:self action:@selector(slideValueChange:) forControlEvents:UIControlEventValueChanged];
    [slider addTarget:self action:@selector(sliderTouchOut:) forControlEvents:UIControlEventTouchUpInside];
  
    

}

#pragma mark------开始滑动
-(void)sildeTouchDown:(UISlider *)sender{


    [self pause];
  

}

#pragma mark-------结束滑动

-(void)sliderTouchOut:(UISlider *)sender{
    
    
    float shouldMoveTime = [self shouMoveTimeSecond:sender];
    
   
    [self moveToTime:shouldMoveTime];
    
    
    
    
}


-(void)slideValueChange:(UISlider *)sender{

     progressView * SlideProgress = self.playProgress;
    
    float moveSecond = [self shouMoveTimeSecond:sender];
    
  
     NSString *moveString =  [self showHMAndSecondString:moveSecond];
    
    SlideProgress.currentTimeLable.text = moveString;
    
    
}

-(float)shouMoveTimeSecond:(UISlider *)sender{

    float totalTime = CMTimeGetSeconds([self.myPlayer.currentItem duration]);
    
    float shouldMoveTime = sender.value * totalTime;
   
    return shouldMoveTime;
    

}

@end
