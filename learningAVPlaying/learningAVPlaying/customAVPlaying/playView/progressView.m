//
//  progressView.m
//  learningAVPlaying
//
//  Created by 掌上先机 on 16/11/4.
//  Copyright © 2016年 wangchao. All rights reserved.
//

#import "progressView.h"


@implementation progressView



-(UISlider *)progress{




    if (_progress == nil) {
        
   
        _progress = [[UISlider alloc] initWithFrame:CGRectMake(90, 0, self.frame.size.width - 180, self.frame.size.height)];
        
        _progress.value = 0.0f;
        
       
    }
    
    return  _progress;
    
}

-(UIButton *)playButton{



    if (_playButton == nil) {
        
        _playButton = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 40, self.frame.size.height)];
        [_playButton setTitle:@"播放" forState:UIControlStateNormal];
        
        [_playButton addTarget:self action:@selector(play:) forControlEvents:UIControlEventTouchUpInside];
        
        _playButton.titleLabel.font = [UIFont systemFontOfSize:13];
        
    }

    return _playButton;

}


-(UIButton *)screenFullButton{



    if (_screenFullButton == nil) {
        
        _screenFullButton = [[UIButton alloc] initWithFrame:CGRectMake(self.frame.size.width-40, 0, 40, self.frame.size.height)];
        [_screenFullButton setTitle:@"全屏" forState:UIControlStateNormal];
        
        [_screenFullButton addTarget:self action:@selector(fullBtnClcik) forControlEvents:UIControlEventTouchUpInside];
        
        
        _screenFullButton.titleLabel.font = [UIFont systemFontOfSize:13];
     
        
    }
    return _screenFullButton;

}


-(UILabel *)currentTimeLable{

    if (_currentTimeLable == nil) {
        
        _currentTimeLable = [self createLableWithFrame:CGRectMake(40, 0, 45, 40)];
        
    }
    
    return _currentTimeLable;


}

-(UILabel *)totalTimeLable{



    if (_totalTimeLable == nil) {
        
        _totalTimeLable = [self createLableWithFrame:CGRectMake(self.frame.size.width - 45 - 40, 0, 45, 40)];
    }
    
    return _totalTimeLable;

}


-(instancetype)initWithFrame:(CGRect)frame{



    
    
    if (self = [super initWithFrame:frame]) {
        
        self.backgroundColor = [UIColor blueColor];
        
        [self addSubview:self.progress];
        
        [self addSubview:self.currentTimeLable];
        
        [self addSubview:self.totalTimeLable];
        
        [self addSubview:self.playButton];
        
        [self addSubview:self.screenFullButton];
        
           
    }
    
    return self;
    
    
}


-(void)play:(UIButton *)sender{
    
    
    playStaus statu;
    

    if ([sender.currentTitle isEqualToString:@"播放"]) {
        
        statu = PLAY;
        
        
    }
    else{
        statu = PAUSE;
    
      
        
    }
    

    if ([_delegate respondsToSelector:@selector(playOrPause:)]) {
        
        [_delegate playOrPause:statu];
        
    }
   

}



-(void)fullBtnClcik{



    if ([_delegate respondsToSelector:@selector(fullScreenBtnClick)]) {
        
        [_delegate fullScreenBtnClick];
        
        
    }

}



-(UILabel *)createLableWithFrame:(CGRect)frame{

    UILabel * lable = [[UILabel alloc] initWithFrame:frame];
    
    lable.font = [UIFont systemFontOfSize:12];
    
    lable.textAlignment = NSTextAlignmentCenter;
    
    lable.text = @"0:0";
    
    
    lable.textColor = [UIColor whiteColor];

    return lable;


}


@end
