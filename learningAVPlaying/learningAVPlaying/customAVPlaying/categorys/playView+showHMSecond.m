//
//  playView+showHMSecond.m
//  learningAVPlaying
//
//  Created by 掌上先机 on 16/11/8.
//  Copyright © 2016年 wangchao. All rights reserved.
//

#import "playView+showHMSecond.h"

@implementation playView (showHMSecond)


-(NSString *)showHMAndSecondString:(float)second{
    

    float totalMinute = second/60;
    
    float totalLeft = (int)second % 60;
    
    NSString * totalString = [NSString stringWithFormat:@"%d:%d",(int)totalMinute,(int)totalLeft];
    

    return totalString;
    

}

@end
