//
//  playView.m
//  learningAVPlaying
//
//  Created by 掌上先机 on 16/10/31.
//  Copyright © 2016年 wangchao. All rights reserved.
//

#import "playView.h"
#import <AVFoundation/AVFoundation.h>


@interface playView()


@property(nonatomic,strong)AVPlayer *myPlayer;

@property(nonatomic,strong)AVPlayerItem *playItem;

@property(strong, nonatomic) id timeObserver; //视频播放时间观察者



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


        NSString * path = [[NSBundle mainBundle] pathForResource:@"b" ofType:@"mp4"];
        
        NSURL *sourceMovieURL = [NSURL fileURLWithPath:path];
        
        AVAsset *movieAsset = [AVURLAsset URLAssetWithURL:sourceMovieURL options:nil];
        
        _playItem = [[AVPlayerItem alloc] initWithAsset:movieAsset];
        
    
        return _playItem;
    
    
}



-(void)setUp{


    
    AVPlayerLayer *playerLayer = [AVPlayerLayer playerLayerWithPlayer:self.myPlayer];
    
   
    playerLayer.frame = CGRectMake(0, 0, self.frame.size.width, self.frame.size.height);
    
    playerLayer.videoGravity = AVLayerVideoGravityResizeAspectFill;
    
    
    [self.layer addSublayer:playerLayer];
    
    
    
    [self addProgressObserver];
    
    
    

}
- (void)addProgressObserver{
    AVPlayerItem *playerItem = self.myPlayer.currentItem;
    //这里设置每秒执行一次
 //   __weak __typeof(self) weakself = self;
    self.timeObserver = [_myPlayer addPeriodicTimeObserverForInterval:CMTimeMake(1.0, 1.0) queue:dispatch_get_main_queue() usingBlock:^(CMTime time) {
        float current = CMTimeGetSeconds(time);
        float total = CMTimeGetSeconds([playerItem duration]);
        NSLog(@"当前已经播放%f--------总时长%f",current,total);
   
    }];
}

-(void)play{

   
    if (self.myPlayer.currentItem == nil) {
        
        
        [self.myPlayer replaceCurrentItemWithPlayerItem:self.playItem];
        
    
    }
   
    [self.myPlayer play];
    
    
}

-(void)pause{

    if (self.myPlayer.rate > 0) {
        
        [self.myPlayer pause];
    }
    
}



@end
