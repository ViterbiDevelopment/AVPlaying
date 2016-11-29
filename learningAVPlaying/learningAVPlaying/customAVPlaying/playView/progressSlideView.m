//
//  progressSlideView.m
//  learningAVPlaying
//
//  Created by 掌上先机 on 16/11/26.
//  Copyright © 2016年 wangchao. All rights reserved.
//

#import "progressSlideView.h"

#import "Masonry.h"


@implementation progressSlideView

-(UISlider *)sliderView{

    
    if (_sliderView == nil) {
        
        _sliderView = [[UISlider alloc] initWithFrame:self.frame];
        
        _sliderView.backgroundColor = [UIColor clearColor];
    }
    
    return _sliderView;
}


-(UIProgressView *)cacheSliderView{


    if (_cacheSliderView == nil) {
        
        _cacheSliderView = [[UIProgressView alloc] initWithFrame:self.frame];
        
      //  [_cacheSliderView setProgress:1];
        
        _cacheSliderView.backgroundColor = [UIColor clearColor];
        
    }
    return _cacheSliderView;

}

- (instancetype)initWithFrame:(CGRect)frame
{
    
    
    self = [super initWithFrame:frame];
    if (self) {
        
        self.backgroundColor = [UIColor clearColor];
        
        [self addSubview:self.cacheSliderView];
        
     //   self.cacheSliderView.progress = 1;
        
        [self.cacheSliderView mas_makeConstraints:^(MASConstraintMaker *make) {

            make.centerY.equalTo(self);
            make.left.equalTo(self).with.offset(0);
            make.right.equalTo(self).with.offset(0);
            make.size.height.mas_equalTo(2);
           
        }];
        
        

       [self addSubview:self.sliderView];
        
        
        [self setTransparentImage];
    
        [self.sliderView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self).with.offset(-2);
            make.left.equalTo(self).with.offset(0);
            make.right.equalTo(self).with.offset(0);
            make.bottom.equalTo(self).with.offset(0);
            

        }];
        
    }
    return self;
}

-(void)setTransparentImage{
    UIGraphicsBeginImageContextWithOptions((CGSize){ 1, 1 }, NO, 0.0f);
    UIImage *transparentImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    
    [self.sliderView setMaximumTrackImage:transparentImage forState:UIControlStateNormal];
    
    [self.sliderView setMinimumTrackImage:transparentImage forState:UIControlStateNormal];
}

@end
