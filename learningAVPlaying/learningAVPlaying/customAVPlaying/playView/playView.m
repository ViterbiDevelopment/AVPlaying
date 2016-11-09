//
//  playView.m
//  learningAVPlaying
//
//  Created by 掌上先机 on 16/10/31.
//  Copyright © 2016年 wangchao. All rights reserved.
//

#import "playView.h"
#import "progressView.h"
#import "playView+playControl.h"
#import "playView+showHMSecond.h"
#import "playView+slidePlayControl.h"
#import "Masonry.h"



@interface playView()<progressViewDelegate>



@property(nonatomic,strong)AVPlayerItem *playItem;


@end

@implementation playView


+(Class)layerClass{

    
    return [AVPlayerLayer class];
    
}





-(instancetype)initWithFrame:(CGRect)frame{

    if (self = [super initWithFrame:frame]) {
        
    
        [self setUp];
        
        
    
        
        //初始化控制手势
        
        [self initControlGester];
        
        //添加进度条控制
        [self addSlidePlayControl];
        
    }

    return self;

}

-(AVPlayer *)myPlayer{


    if (_myPlayer == nil) {
        
        _myPlayer = [[AVPlayer alloc] initWithPlayerItem:self.playItem];
        
    }

    return _myPlayer;
    
}

-(AVPlayerItem *)playItem{

    if (_playItem == nil) {
        
        NSString * path = [[NSBundle mainBundle] pathForResource:@"b" ofType:@"mp4"];
        
        NSURL *sourceMovieURL = [NSURL fileURLWithPath:path];
        
        AVAsset *movieAsset = [AVURLAsset URLAssetWithURL:sourceMovieURL options:nil];
        
        _playItem = [[AVPlayerItem alloc] initWithAsset:movieAsset];
       
    }

     return _playItem;
    
    
}



-(void)setUp{


    
    _playerLayer = [AVPlayerLayer playerLayerWithPlayer:self.myPlayer];
    
    _playerLayer.frame = CGRectMake(0, 0, self.frame.size.width, self.frame.size.height);
   
    
  _playerLayer.videoGravity = AVLayerVideoGravityResize;

    [self.layer addSublayer:_playerLayer];
    


    _playProgress = [[progressView alloc] initWithFrame:CGRectMake(0, self.frame.size.height - 40, self.frame.size.width, 40)];

    _playProgress.delegate = self;

    [self addSubview:_playProgress];
    
    [_playProgress mas_makeConstraints:^(MASConstraintMaker *make) {
       
        make.size.height.mas_equalTo(40);
        
        make.bottom.equalTo(self).with.offset(0);
        make.right.equalTo(self).with.offset(0);
        
        make.left.equalTo(self).with.offset(0);
        
    }];
    
    
    
    
    
    [self addProgressObserver];
    
    
    

}

#pragma mark-------监听播放的状态

- (void)addProgressObserver{
    
    AVPlayerItem *playerItem = self.myPlayer.currentItem;
    

    //这里设置每秒执行一次
    __weak __typeof(self) weakself = self;
    
   [_myPlayer addPeriodicTimeObserverForInterval:CMTimeMake(1.0, 1.0) queue:dispatch_get_main_queue() usingBlock:^(CMTime time) {
       
        float current = CMTimeGetSeconds(playerItem.currentTime);
        float total = CMTimeGetSeconds([playerItem duration]);
       
       NSString * currentHMSString = [weakself showHMAndSecondString:current];
       
       NSString * totalHMSString = [weakself showHMAndSecondString:total];
       
       
       weakself.playProgress.currentTimeLable.text = currentHMSString;
       
       weakself.playProgress.totalTimeLable.text = totalHMSString;

    
       weakself.playProgress.progress.value = current / total;
       
       
   
    }];
}

#pragma mark-------playProgressDelegate


-(void)playOrPause:(playStaus)status{



    switch (status) {
        case PLAY:
            [self play];
            break;
        case PAUSE:
            [self pause];
            break;
        default:
            break;
    }
    
    
    

}

#pragma mark-----播放

-(void)play{

   
    if (self.myPlayer.currentItem == nil) {
        
        
        [self.myPlayer replaceCurrentItemWithPlayerItem:self.playItem];
        
    }
    
    [self.playProgress.playButton setTitle:@"暂停" forState:UIControlStateNormal];
    
   
    [self.myPlayer play];
    
    
}
#pragma mark-----暂停

-(void)pause{

    if (self.myPlayer.rate > 0) {

        [self.playProgress.playButton setTitle:@"播放" forState:UIControlStateNormal];

        [self.myPlayer pause];
    }
    
}






@end
