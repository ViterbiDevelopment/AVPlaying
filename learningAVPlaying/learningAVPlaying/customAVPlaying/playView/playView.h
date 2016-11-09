//
//  playView.h
//  learningAVPlaying
//
//  Created by 掌上先机 on 16/10/31.
//  Copyright © 2016年 wangchao. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <AVFoundation/AVFoundation.h>

@class progressView;


@interface playView : UIView

@property(nonatomic,strong,nonnull)AVPlayer *myPlayer;

@property(nonatomic,strong,nonnull)progressView *playProgress;

@property(nonnull,strong)AVPlayerLayer *playerLayer;


-(void)play;

-(void)pause;


@end
