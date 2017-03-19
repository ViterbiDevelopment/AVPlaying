//
//  cacheVideoSaveCache.m
//  learningAVPlaying
//
//  Created by 掌上先机 on 17/3/15.
//  Copyright © 2017年 wangchao. All rights reserved.
//

#import "cacheVideoSaveCache.h"


@interface cacheVideoSaveCache()<NSURLConnectionDataDelegate>


@property(nonatomic,strong)NSURLConnection *downloadConnection;

@property(nonatomic,strong)NSFileHandle *handelDataFile;



@property(nonatomic,strong)NSMutableArray *connectArray;


@property(nonatomic,strong)NSString *videoTempPath;


@property(nonatomic,assign)BOOL isFinishLoading;

@end

@implementation cacheVideoSaveCache


-(instancetype)init{

    if (self = [super init]) {
        
        _connectArray = [[NSMutableArray alloc] initWithCapacity:0];
        
        NSString *document = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES).lastObject;
        _videoTempPath =  [document stringByAppendingPathComponent:@"temp.mp4"];

        if ([[NSFileManager defaultManager] fileExistsAtPath:_videoTempPath]) {
            
            [[NSFileManager defaultManager] removeItemAtPath:_videoTempPath error:nil]
            ;
        }
        [[NSFileManager defaultManager] createFileAtPath:_videoTempPath contents:nil attributes:nil];
        
        
        
    }
    
    return self;
}


-(void)setUrl:(NSURL *)url offSet:(NSUInteger)offset{

    _url = url;
    _offset = offset;
    
    if (_connectArray.count >= 1) {
        
        [[NSFileManager defaultManager] removeItemAtPath:_videoTempPath error:nil];
        [[NSFileManager defaultManager] createFileAtPath:_videoTempPath contents:nil attributes:nil];
    }
    
    _downloadOffset = 0;
    
    NSURLComponents *replaceUrl = [[NSURLComponents alloc] initWithURL:url resolvingAgainstBaseURL:NO];
    replaceUrl.scheme = @"http";
    NSMutableURLRequest *request = [[NSMutableURLRequest alloc] initWithURL:[replaceUrl URL]];
    
    if (offset > 0 && self.videoLenght > 0) {
        
        [request addValue:[NSString stringWithFormat:@"bytes=%ld-%ld",(unsigned long)offset, (unsigned long)self.videoLenght - 1] forHTTPHeaderField:@"Range"];
    }
    
    if (self.downloadConnection) {
        
        [self.downloadConnection cancel];
    }
    
    self.downloadConnection = [[NSURLConnection alloc] initWithRequest:request delegate:self startImmediately:NO];
    
    [self.downloadConnection setDelegateQueue:[NSOperationQueue mainQueue]];
    
    [self.downloadConnection start];
    
    

}

-(void)connection:(NSURLConnection *)connection didReceiveResponse:(NSURLResponse *)response{
    
    _isFinishLoading = NO;

    NSHTTPURLResponse *httpResponse = (NSHTTPURLResponse *)response;
    
    NSDictionary *httpDic = [httpResponse allHeaderFields];
    
    NSString *contentRangeLength = [httpDic valueForKey:@"Content-Length"];
    
   // NSString *length = [contentRange componentsSeparatedByString:@"/"].firstObject;
    
    self.videoLenght = [contentRangeLength integerValue];
    
    self.videoType = @"video/mp4";
    
    [self.connectArray addObject:connection];
    
    self.handelDataFile = [NSFileHandle fileHandleForWritingAtPath:_videoTempPath];
    
   
    
    
}


-(void)connection:(NSURLConnection *)connection didReceiveData:(NSData *)data{

    [self.handelDataFile seekToEndOfFile];
    
    [self.handelDataFile writeData:data];
    
    _downloadOffset = _downloadOffset + data.length;
    
    if ([_delegate respondsToSelector:@selector(didReceiveVideoData:)]) {
        

        
        [_delegate didReceiveVideoData:self];
        
        
    }
}

-(void)connectionDidFinishLoading:(NSURLConnection *)connection{

    
    if (self.connectArray.count == 1) {
        
        _isFinishLoading = YES;
        
        NSString *document = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES).lastObject;
        NSString *movePath =  [document stringByAppendingPathComponent:@"保存数据.mp4"];
        
        BOOL isSuccess = [[NSFileManager defaultManager] copyItemAtPath:_videoTempPath toPath:movePath error:nil];
        
        if (isSuccess) {
            NSLog(@"rename success");
        }else{
            NSLog(@"rename fail");
        }
        NSLog(@"----%@", movePath);
        
    }
    
    if ([_delegate respondsToSelector:@selector(didFinishLoadingCacheTask:)]) {
        
        [_delegate didFinishLoadingCacheTask:self];
    }
    
    
    

}

-(void)cancle{


    if (self.downloadConnection) {
        
        [self.downloadConnection cancel];
        
    }
    
}

@end
