//
//  playView+playControl.m
//  learningAVPlaying
//
//  Created by 掌上先机 on 16/11/6.
//  Copyright © 2016年 wangchao. All rights reserved.
//

#import "playView+playControl.h"

#import "playView+playInfoShow.h"

#import <objc/runtime.h>


#define playScale 0.1 //手势移动比例 如果想移动手势的时候 播放慢点 将改系数调大 默认0.2

@implementation playView (playControl)


-(void)initControlGester{

    [self addGestureRecognizer:self.controlGester];

}

-(void)setMoveToSecond:(CGFloat)moveToSecond{


    objc_setAssociatedObject(self, &VTControlPropertyMoveToSecond, @(moveToSecond), OBJC_ASSOCIATION_RETAIN);
    
}

-(CGFloat)moveToSecond{


   return [objc_getAssociatedObject(self, &VTControlPropertyMoveToSecond) floatValue];

}

-(UIPanGestureRecognizer *)controlGester{
 
    
    UIPanGestureRecognizer *panGest = objc_getAssociatedObject(self, &VTPlayControlPropertyPlayControlGestureRecognizer);
    
    if (panGest == nil) {
        
        panGest = [[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(didRecognizedPlayControlRecognizer:)];
        panGest.maximumNumberOfTouches = 1;
        panGest.minimumNumberOfTouches = 1;
        panGest.delegate = self;
    }
    
    return panGest;
    
}






-(void)didRecognizedPlayControlRecognizer:(UIPanGestureRecognizer *)gester{



   
    CGPoint point = [gester locationInView:self];
    

    switch (gester.state) {
        case UIGestureRecognizerStateChanged:
        {
         float second  = [self shouldMoveSecond:self.myPlayer.currentItem distance:point.x];
            
        
            [self showInfoLableWithTextSecond:second];
            
            
        }
            break;
        case UIGestureRecognizerStateEnded:
            
        {
            
           [self dissMissInfoLable];
            
            float current =  CMTimeGetSeconds(self.myPlayer.currentTime);
            
        
            float shouldMove = [self shouldMoveSecond:self.myPlayer.currentItem distance:point.x];
            
            float totalTime = CMTimeGetSeconds([self.myPlayer.currentItem duration]);
            
            if (shouldMove + current >= totalTime ) {
              
                [self moveToTime:totalTime];
                
                break;
            }
            
            if (shouldMove + current <= 0) {
                
                [self moveToTime:0];
           
                break;
            }
         
            float move = shouldMove + current;
            
            [self moveToTime:move];
            
        }
            break;
            
         case UIGestureRecognizerStateBegan:
        {
            [self pause];
            
            self.moveToSecond = point.x;
        }
            break;
            
        default:
            break;
    }
    
    
}


-(float)shouldMoveSecond:(AVPlayerItem *)AVItem distance:(float)pointX{

    //获得视频总共时长
    
    float totalSecond = CMTimeGetSeconds([AVItem duration]);
    
   
    float moveSecond  =  totalSecond/self.frame.size.width * (pointX - self.moveToSecond)*playScale;
    
    
    return moveSecond;
    



    
}

-(void)moveToTime:(CGFloat )time{

    
    CMTimeScale scale =  self.myPlayer.currentItem.asset.duration.timescale;
    
    
    CMTime Mytime = CMTimeMakeWithSeconds(time,scale);
    
    __weak playView * weakSelf = self;

    [self.myPlayer seekToTime:Mytime toleranceBefore:kCMTimeZero toleranceAfter:kCMTimeZero completionHandler:^(BOOL finished) {
        
        float totalTime = CMTimeGetSeconds([weakSelf.myPlayer.currentItem duration]);
   
        float currentTime = CMTimeGetSeconds(weakSelf.myPlayer.currentItem.currentTime);
        
        if (totalTime == currentTime) {
            
            [weakSelf pause];
        }
        else{
        
            if (finished) {
                
                [weakSelf play];
                
            }
            
        }
        
        
       
        

    }];
    
    
    
}




@end
