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


    objc_setAssociatedObject(self, &VTControlPropertyMoveToSecond, @(moveToSecond), OBJC_ASSOCIATION_RETAIN);
    
}

-(CGFloat)moveToSecond{


   return (CGFloat)[objc_getAssociatedObject(self, &VTControlPropertyMoveToSecond) floatValue];

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

-(UILabel *)infoShowLable{

     UILabel *lable = objc_getAssociatedObject(self, &VTControlPropertyInfoLable);
    

    return lable;

    

}

-(void)setInfoShowLable:(UILabel *)infoShowLable{


    objc_setAssociatedObject(self, &VTControlPropertyInfoLable, infoShowLable, OBJC_ASSOCIATION_RETAIN);
    
    
}

-(void)showInfoLableWithText:(NSString *)text{

    if (self.infoShowLable == nil) {
        
        self.infoShowLable = [[UILabel alloc] init];
        
        self.infoShowLable.text = text;
        
        [self addSubview:self.infoShowLable];
        
        
    }
    else{
    
        self.infoShowLable.text = text;
    
        self.infoShowLable.hidden = false;
    }

   

}

-(void)dissMissInfoLable{


    self.infoShowLable.hidden = true;
    
    
}

-(void)didRecognizedPlayControlRecognizer:(UIPanGestureRecognizer *)gester{



   
    CGPoint point = [gester locationInView:self];
    

    switch (gester.state) {
        case UIGestureRecognizerStateChanged:
        {
         float second  = [self shouldMoveSecond:self.myPlayer.currentItem distance:point.x];
            
            [self showInfoLableWithText:[NSString stringWithFormat:@"移动：%f秒",second]];
            
            
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
                
                [self pause];
                
                
                break;
            }
            
            float move = shouldMove + current;
            
            [self moveToTime:move];
            
        }
            break;
            
         case UIGestureRecognizerStateBegan:
            
            self.moveToSecond = point.x;
           
            break;
            
        default:
            break;
    }
    
    
}


-(float)shouldMoveSecond:(AVPlayerItem *)AVItem distance:(float)pointX{

    //获得视频总共时长
    
    float totalSecond = CMTimeGetSeconds([AVItem duration]);
    
    //移动比例
    
    float moveSecond  =  totalSecond/self.frame.size.width * (pointX - self.moveToSecond);
    
    NSLog(@"移动多少秒---------%f",moveSecond);
    
    
    return moveSecond;
    



    
}

-(void)moveToTime:(CGFloat )time{

    
    CMTimeScale scale =  self.myPlayer.currentItem.asset.duration.timescale;
    
    
    CMTime Mytime = CMTimeMakeWithSeconds(time,scale);
    

 
    [self.myPlayer seekToTime:Mytime toleranceBefore:kCMTimeZero toleranceAfter:kCMTimeZero completionHandler:^(BOOL finished) {
        
        
        
    }];
    
    
    
}


@end
