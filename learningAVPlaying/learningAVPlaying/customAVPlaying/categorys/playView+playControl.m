//
//  playView+playControl.m
//  learningAVPlaying
//
//  Created by 掌上先机 on 16/11/6.
//  Copyright © 2016年 wangchao. All rights reserved.
//

#import "playView+playControl.h"
#import <objc/runtime.h>


@implementation playView (playControl)


-(void)initControlGester{

    [self addGestureRecognizer:self.controlGester];

}

-(void)setMoveToSecond:(CGFloat)moveToSecond{


    objc_setAssociatedObject(self, &VTControlPropertyMoveToSecond, @(moveToSecond), OBJC_ASSOCIATION_ASSIGN);
    
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


    NSLog(@"--------");
    
    switch (gester.state) {
        case UIGestureRecognizerStateChanged:
          //  [self moveToTime:25];
            break;
        case UIGestureRecognizerStateEnded:
            
            [self moveToTime:200];
            
          //  [self play];
        default:
            break;
    }
    
    
}

-(void)moveToTime:(CGFloat )time{

    
    CMTimeScale scale =  self.myPlayer.currentItem.asset.duration.timescale;
    
    
    CMTime Mytime = CMTimeMakeWithSeconds(time,scale);
    

 
    [self.myPlayer seekToTime:Mytime toleranceBefore:kCMTimeZero toleranceAfter:kCMTimeZero completionHandler:^(BOOL finished) {
        
        
        
    }];
    
    
    
}


@end
