//
//  playView.m
//  learningAVPlaying
//
//  Created by 掌上先机 on 16/10/31.
//  Copyright © 2016年 wangchao. All rights reserved.
//

#import "playView.h"

#import "progressView.h"


#import <AVFoundation/AVFoundation.h>


@interface playView()<progressViewDelegate>


@property(nonatomic,strong)AVPlayer *myPlayer;

@property(nonatomic,strong)AVPlayerItem *playItem;


@property(nonatomic,strong)progressView *playProgress;



@end

@implementation playView


+(Class)layerClass{

    
    return [AVPlayerLayer class];
    
}




-(instancetype)initWithCoder:(NSCoder *)aDecoder{


    
    if (self = [super initWithCoder:aDecoder]) {
        
#pragma mark-----约束的话  要设置frame 真是奇怪
        self.frame = CGRectMake(0, 0, 375, 275);
        
        [self setUp];
        
    }
    
    return self;
}

-(instancetype)initWithFrame:(CGRect)frame{

    if (self = [super initWithFrame:frame]) {
        
    
        [self setUp];
        
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


    
    AVPlayerLayer *playerLayer = [AVPlayerLayer playerLayerWithPlayer:self.myPlayer];
    
   
    playerLayer.frame = CGRectMake(0, 0, self.frame.size.width, self.frame.size.height);
    
    playerLayer.videoGravity = AVLayerVideoGravityResizeAspectFill;
    
    
    [self.layer addSublayer:playerLayer];
    
    
    _playProgress = [[progressView alloc] initWithFrame:CGRectMake(0, self.frame.size.height - 40, self.frame.size.width, 40)];
    
    _playProgress.backgroundColor = [UIColor redColor];
    
    _playProgress.delegate = self;
    
    
    [self addSubview:_playProgress];
    
    
    [self addProgressObserver];
    
    
    

}

#pragma mark-------监听播放的状态

- (void)addProgressObserver{
    
    AVPlayerItem *playerItem = self.myPlayer.currentItem;
    //这里设置每秒执行一次
    __weak __typeof(self) weakself = self;
    
   [_myPlayer addPeriodicTimeObserverForInterval:CMTimeMake(1.0, 1.0) queue:dispatch_get_main_queue() usingBlock:^(CMTime time) {
        float current = CMTimeGetSeconds(time);
        float total = CMTimeGetSeconds([playerItem duration]);
       
        
        weakself.playProgress.progress.progress = current/total;
       
   
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
   
    [self.myPlayer play];
    
    
}
#pragma mark-----暂停

-(void)pause{

    if (self.myPlayer.rate > 0) {
        
        [self.myPlayer pause];
    }
    
}

#pragma mark-----全屏

-(void)fullScreenBtnClick{




}




@end
