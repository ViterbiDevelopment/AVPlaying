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

-(progressSlideView *)sliderView{


    if (_sliderView == nil) {
        
        _sliderView = [[progressSlideView alloc] initWithFrame:CGRectZero];
    }

    return _sliderView;

}


-(UIButton *)playButton{



    if (_playButton == nil) {
        
        _playButton = [[UIButton alloc] initWithFrame:CGRectZero];
        [_playButton setTitle:@"播放" forState:UIControlStateNormal];
        
        _playButton.enabled = false;
        
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
        
        
        [self addSubview:self.sliderView];
        
        [_sliderView mas_makeConstraints:^(MASConstraintMaker *make) {
           
            make.centerX.equalTo(self);
            
            
            make.top.equalTo(self).with.offset(0);
            
            
            make.left.equalTo(self.currentTimeLable.mas_right).with.offset(5);
            
            make.bottom.equalTo(self).with.offset(0);

        }];
        

        

        [self addSubview:self.totalTimeLable];
        
        [self.totalTimeLable mas_makeConstraints:^(MASConstraintMaker *make) {
           
            make.top.equalTo(self).with.offset(0);
            
            make.left.equalTo(self.sliderView.mas_right).with.offset(5);
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
        
        //添加progressValue监听状态，实时更新progressSlideView
        [self addObserver:self forKeyPath:@"progressValue" options:NSKeyValueObservingOptionNew context:nil];
        //cacheProgressValue
        [self addObserver:self forKeyPath:@"cacheProgressValue" options:NSKeyValueObservingOptionNew context:nil];
    
        
           
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

-(void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary<NSKeyValueChangeKey,id> *)change context:(void *)context{


    if ([keyPath isEqualToString:@"progressValue"]) {
        
        NSString * stringOfNew = change[@"new"];
        
        double doubleOfNew =  [stringOfNew doubleValue];
        
        
        _sliderView.sliderView.value = doubleOfNew;
        
       
        
        
    }
    if ([keyPath isEqualToString:@"cacheProgressValue"]) {
        NSString * stringOfNew = change[@"new"];
        
        double doubleOfNew =  [stringOfNew doubleValue];
        
        _sliderView.cacheSliderView.progress = doubleOfNew;
        
       
        
        
    }

    

}

-(void)dealloc{


   [self removeObserver:self forKeyPath:@"progressValue"];
    [self removeObserver:self forKeyPath:@"cacheProgressValue"];
    
 
    

}

@end
