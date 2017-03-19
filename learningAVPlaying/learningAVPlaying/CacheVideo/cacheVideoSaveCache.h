//
//  cacheVideoSaveCache.h
//  learningAVPlaying
//
//  Created by 掌上先机 on 17/3/15.
//  Copyright © 2017年 wangchao. All rights reserved.
//

#import <Foundation/Foundation.h>

@class cacheVideoSaveCache;

@protocol cacheVideoSaveCacheDelegate <NSObject>


-(void)didReceiveVideoData:(cacheVideoSaveCache *)cachTask;

-(void)didFinishLoadingCacheTask:(cacheVideoSaveCache *)cacheTask;


@end

@interface cacheVideoSaveCache : NSObject

@property(nonatomic,assign)NSUInteger videoLenght;

@property(nonatomic,strong)NSURL *url;

@property(nonatomic,assign)NSUInteger downloadOffset;

@property(nonatomic,assign)NSUInteger offset;

@property(nonatomic,strong)NSString *videoType;


@property(nonatomic,assign)id<cacheVideoSaveCacheDelegate>delegate;

-(void)setUrl:(NSURL *)url offSet:(NSUInteger)offset;


-(void)cancle;

@end
