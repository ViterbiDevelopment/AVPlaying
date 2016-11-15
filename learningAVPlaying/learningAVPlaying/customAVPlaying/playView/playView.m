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


@property(nonatomic,strong)NSString * urlString;

@end

@implementation playView


+(Class)layerClass{

    
    return [AVPlayerLayer class];
    
}



-(instancetype)initWithFrameAndUrl:(CGRect)frame url:(NSString *)urlString
{


    if (self = [super initWithFrame:frame]) {
        
        _urlString = urlString;
        
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
        
        
        //播放 本地资源
        if (_urlString == nil) {
            
            NSString * path = [[NSBundle mainBundle] pathForResource:@"b" ofType:@"mp4"];
            
            NSURL *sourceMovieURL = [NSURL fileURLWithPath:path];
            
            AVAsset *movieAsset = [AVURLAsset URLAssetWithURL:sourceMovieURL options:nil];
            
            _playItem = [[AVPlayerItem alloc] initWithAsset:movieAsset];
        }
        //播放网络资源
        else{
        
            NSURL * url = [NSURL URLWithString:_urlString];
            self.playItem = [AVPlayerItem playerItemWithURL:url];
            
        
        }
        
       
       
    }

     return _playItem;
    
    
}



-(void)setUp{


    
    _playerLayer = [AVPlayerLayer playerLayerWithPlayer:self.myPlayer];
    
    _playerLayer.frame = CGRectMake(0, 0, self.frame.size.width, self.frame.size.height);
   
    
     _playerLayer.videoGravity = AVLayerVideoGravityResizeAspectFill;

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
    
    [self addPlayStatus];
    

}
#pragma mark------添加播放状态


-(void)addPlayStatus{
    
    
    
    [self.myPlayer.currentItem addObserver:self forKeyPath:@"status" options:NSKeyValueObservingOptionNew context:nil];
   
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(moveDidPlayEnd:) name:AVPlayerItemDidPlayToEndTimeNotification object:nil];
    

    
}



#pragma mark-------监听播放的进度

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


-(void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary<NSKeyValueChangeKey,id> *)change context:(void *)context{


    AVPlayerItem * itme = (AVPlayerItem *)object;
    
    __weak playView * weakSelf = self;

    if ([keyPath isEqualToString:@"status"]) {
        
        if ([itme status] == AVPlayerStatusReadyToPlay) {
            
            float total = CMTimeGetSeconds([itme duration]);
            
            NSString * totalString = [weakSelf showHMAndSecondString:total];
            weakSelf.playProgress.totalTimeLable.text = totalString;

            weakSelf.playProgress.playButton.enabled = true;
            
            
            
        }
        
        
    }
    if ([keyPath isEqualToString:@""]) {
        
        
    }




}


#pragma mark-------moveDidPlayEnd

-(void)moveDidPlayEnd:(NSNotification *)noti{


    
    //从零开始
    [self pause];
    [self moveToTime:0];

    self.playProgress.progress.value = 0;
    
    self.playProgress.currentTimeLable.text = @"00:00";
    
    
    NSLog(@"move");


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
//status
-(void)dealloc{

    
    [self.myPlayer.currentItem removeObserver:self forKeyPath:@"status" context:nil];

    
    
}





@end
