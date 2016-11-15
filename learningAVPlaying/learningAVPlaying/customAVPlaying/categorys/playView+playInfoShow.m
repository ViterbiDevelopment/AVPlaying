//
//  playView+playInfoShow.m
//  learningAVPlaying
//
//  Created by 掌上先机 on 16/11/8.
//  Copyright © 2016年 wangchao. All rights reserved.
//

#import "playView+playInfoShow.h"
#import "playView+showHMSecond.h"
#import "Masonry.h"


#import <objc/runtime.h>


static void * VTControlPropertyInfoLable;


@implementation playView (playInfoShow)



-(void)showInfoLableWithTextSecond:(float)second{

    
    
    float total = CMTimeGetSeconds([self.myPlayer.currentItem duration]);
    
   
    NSString * totalString = [self showHMAndSecondString:total];
    

    float current = CMTimeGetSeconds(self.myPlayer.currentItem.currentTime);

    float shouldMove = current + second;
    
    
    
    NSString * shouldMoveStr = [self showHMAndSecondString:shouldMove];
    
    if (shouldMove <= 0) {
     
        shouldMoveStr = @"0:0";
        
    }
    
    NSString * info = [NSString stringWithFormat:@"%@ / %@",shouldMoveStr,totalString];
    

    if (self.infoLable == nil) {
        
        self.infoLable = [[UILabel alloc] init];
        self.infoLable.textAlignment = NSTextAlignmentCenter;
        
        self.infoLable.layer.cornerRadius = 10;
        
        self.infoLable.layer.masksToBounds = true;
        
        self.infoLable.backgroundColor = [UIColor blackColor];
        
        self.infoLable.font = [UIFont systemFontOfSize:14];
        
        self.infoLable.textColor = [UIColor whiteColor];
        
        self.infoLable.text = info;
        
        [self addSubview:self.infoLable];
        
        
        [self.infoLable mas_makeConstraints:^(MASConstraintMaker *make) {
           
            
            make.size.mas_equalTo(CGSizeMake(140, 40));
            
            make.center.equalTo(self);
            
        }];
        
        
        
        
        
    }
    else{
        
        self.infoLable.text = info;
        
        self.infoLable.hidden = false;
    }


}

-(void)dissMissInfoLable{
    
    
    self.infoLable.hidden = true;
    
    
}

-(UILabel *)infoLable{
    
    
    UILabel *lable = objc_getAssociatedObject(self, &VTControlPropertyInfoLable);
    
    
    return lable;
    
    
    
}

-(void)setInfoLable:(UILabel *)infoLable{


    objc_setAssociatedObject(self, &VTControlPropertyInfoLable, infoLable, OBJC_ASSOCIATION_RETAIN);
    

}



@end
