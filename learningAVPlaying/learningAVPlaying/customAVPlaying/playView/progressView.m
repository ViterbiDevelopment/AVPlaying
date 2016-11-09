//
//  progressView.m
//  learningAVPlaying
//
//  Created by 掌上先机 on 16/11/4.
//  Copyright © 2016年 wangchao. All rights reserved.
//

#import "progressView.h"
#import "Masonry.h"



@implementation progressView



-(UISlider *)progress{




    if (_progress == nil) {
        
   
        _progress = [[UISlider alloc] initWithFrame:CGRectZero];
        
        _progress.value = 0.0f;
        
       
    }
    
    return  _progress;
    
}

-(UIButton *)playButton{



    if (_playButton == nil) {
        
        _playButton = [[UIButton alloc] initWithFrame:CGRectZero];
        [_playButton setTitle:@"播放" forState:UIControlStateNormal];
        
        [_playButton addTarget:self action:@selector(play:) forControlEvents:UIControlEventTouchUpInside];
        
        _playButton.titleLabel.font = [UIFont systemFontOfSize:13];
        
    }

    return _playButton;

}


-(UIButton *)screenFullButton{



    if (_screenFullButton == nil) {
        
        _screenFullButton = [[UIButton alloc] initWithFrame:CGRectZero];
        [_screenFullButton setTitle:@"全屏" forState:UIControlStateNormal];
        
        _screenFullButton.titleLabel.font = [UIFont systemFontOfSize:13];
     

    }
    return _screenFullButton;

}


-(UILabel *)currentTimeLable{

    if (_currentTimeLable == nil) {
        
        _currentTimeLable = [self createLableWithFrame:CGRectZero];
        
    }
    
    return _currentTimeLable;


}

-(UILabel *)totalTimeLable{



    if (_totalTimeLable == nil) {
        
        _totalTimeLable = [self createLableWithFrame:CGRectZero];
    }
    
    return _totalTimeLable;

}


-(instancetype)initWithFrame:(CGRect)frame{



    
    
    if (self = [super initWithFrame:frame]) {
        
        self.backgroundColor = [UIColor blueColor];
        
        [self addSubview:self.playButton];
        
        [self.playButton mas_makeConstraints:^(MASConstraintMaker *make) {
           
            make.top.equalTo(self).with.offset(0);
            make.left.equalTo(self).with.offset(0);
            make.bottom.equalTo(self).with.offset(0);
            
            make.size.width.mas_equalTo(40);
            
            
        }];
        
        
        
        [self addSubview:self.currentTimeLable];
        
        [self.currentTimeLable mas_makeConstraints:^(MASConstraintMaker *make) {
           
            make.top.equalTo(self).with.offset(0);
            
            make.left.equalTo(self.playButton.mas_right).with.offset(0);
            
            make.bottom.equalTo(self).offset(0);
            
            make.size.width.mas_equalTo(45);
            
        }];
        [self addSubview:self.progress];
        
       
        [self.progress mas_makeConstraints:^(MASConstraintMaker *make) {
           
            
            make.top.equalTo(self).with.offset(0);
            
            make.left.equalTo(self.currentTimeLable.mas_right).with.offset(5);
            
            make.bottom.equalTo(self).with.offset(0);
            
           
            
        }];

        [self addSubview:self.totalTimeLable];
        
        [self.totalTimeLable mas_makeConstraints:^(MASConstraintMaker *make) {
           
            make.top.equalTo(self).with.offset(0);
            
            make.left.equalTo(self.progress.mas_right).with.offset(5);
            make.bottom.equalTo(self).with.offset(0);
            
            make.size.width.mas_equalTo(45);
            
        }];
        
        
        [self addSubview:self.screenFullButton];
        
    
        
        [self.screenFullButton mas_makeConstraints:^(MASConstraintMaker *make) {
           
            make.top.equalTo(self).with.offset(0);
            
            make.left.equalTo(self.totalTimeLable.mas_right).with.offset(0);
            
            make.right.equalTo(self).with.offset(0);
            
            make.bottom.equalTo(self).with.offset(0);
            
            
        }];
        
       
    
        
           
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






-(UILabel *)createLableWithFrame:(CGRect)frame{

    UILabel * lable = [[UILabel alloc] initWithFrame:frame];
    
    lable.font = [UIFont systemFontOfSize:12];
    
    lable.textAlignment = NSTextAlignmentCenter;
    
    lable.text = @"0:0";
    
    
    lable.textColor = [UIColor whiteColor];

    return lable;


}


@end
