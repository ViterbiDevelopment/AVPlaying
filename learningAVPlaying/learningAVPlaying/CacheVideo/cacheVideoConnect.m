//
//  cacheVideoConnect.m
//  learningAVPlaying
//
//  Created by 掌上先机 on 17/3/15.
//  Copyright © 2017年 wangchao. All rights reserved.
//
#import <MobileCoreServices/MobileCoreServices.h>
#import "cacheVideoConnect.h"


@interface cacheVideoConnect()<cacheVideoSaveCacheDelegate>

@property(nonatomic,strong)cacheVideoSaveCache *cacheTask;

@property(nonatomic,strong)NSMutableArray *requestArray;

@property (nonatomic,strong) NSString *videoPath;



@end

@implementation cacheVideoConnect

-(instancetype)init{

    if (self = [super init]) {
        
        NSString *document = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES).lastObject;
        
        _videoPath = [document stringByAppendingPathComponent:@"temp.mp4"];

        
        self.requestArray = [NSMutableArray new];
        
        
    }
    
    return self;
    
}
- (void)fillInContentInformation:(AVAssetResourceLoadingContentInformationRequest *)contentInformationRequest
{
    NSString *mimeType = self.cacheTask.videoType;
    
    
    CFStringRef contentType = UTTypeCreatePreferredIdentifierForTag(kUTTagClassMIMEType, (__bridge CFStringRef)(mimeType), NULL);
    contentInformationRequest.byteRangeAccessSupported = YES;
    contentInformationRequest.contentType = CFBridgingRelease(contentType);
    
    contentInformationRequest.contentLength = self.cacheTask.videoLenght;
}

-(void)resourceLoader:(AVAssetResourceLoader *)resourceLoader didCancelLoadingRequest:(AVAssetResourceLoadingRequest *)loadingRequest{
    
    
    [self.requestArray removeObject:loadingRequest];
    
    
}

-(BOOL)resourceLoader:(AVAssetResourceLoader *)resourceLoader shouldWaitForLoadingOfRequestedResource:(AVAssetResourceLoadingRequest *)loadingRequest{
    
   
    [self.requestArray addObject:loadingRequest];
    
    [self dealLoadingRequest:loadingRequest];
    
    return YES;

}
-(void)dealWithRequestArray{
    
    NSMutableArray *finishArray = [NSMutableArray new];
    
    for (AVAssetResourceLoadingRequest *loadingRequest in _requestArray) {
        
        
        [self fillInContentInformation:loadingRequest.contentInformationRequest];
        
        // 判读请求是否完成
        
        BOOL isfinish = [self judgeResposeDataHasFinish:loadingRequest.dataRequest];
        
        if (isfinish) {
            
            [finishArray addObject:loadingRequest];
            
            [loadingRequest finishLoading];
        }
        
    }
    
    [_requestArray removeObjectsInArray:finishArray];
    
    
    
}


-(BOOL)judgeResposeDataHasFinish:(AVAssetResourceLoadingDataRequest *)dataRequest{

    long long start = dataRequest.requestedOffset;
    
    if (dataRequest.currentOffset != 0) {
        
        start = dataRequest.currentOffset;
    }
    
    if (self.cacheTask.offset + self.cacheTask.downloadOffset < start) {
        
        return NO;
    }
    
    if (start < self.cacheTask.offset) {
        
        return NO;
    }
    
    
    NSData *filedata = [NSData dataWithContentsOfURL:[NSURL fileURLWithPath:_videoPath] options:NSDataReadingMappedIfSafe error:nil];
    
    // This is the total data we have from startOffset to whatever has been downloaded so far
    NSUInteger unreadBytes = self.cacheTask.downloadOffset - ((NSInteger)start - self.cacheTask.offset);
    
    // Respond with whatever is available if we can't satisfy the request fully yet
    NSUInteger numberOfBytesToRespondWith = MIN((NSUInteger)dataRequest.requestedLength, unreadBytes);
    
    
    [dataRequest respondWithData:[filedata subdataWithRange:NSMakeRange((NSUInteger)start- self.cacheTask.offset, (NSUInteger)numberOfBytesToRespondWith)]];
    
    
    
    long long endOffset = start + dataRequest.requestedLength;
    BOOL didRespondFully = (self.cacheTask.offset + self.cacheTask.downloadOffset) >= endOffset;
    
    return didRespondFully;
    
    

}


-(void)dealLoadingRequest:(AVAssetResourceLoadingRequest *)request{

    NSURL *replaceUrl = [request.request URL];
    
    NSRange range = NSMakeRange(request.dataRequest.currentOffset, NSUIntegerMax);
    
    
    if (self.cacheTask.downloadOffset > 0) {
        
        // 对请求进行处理
        
        [self dealWithRequestArray];
        
    }

    if (!self.cacheTask) {
        
        _cacheTask = [[cacheVideoSaveCache alloc] init];
        
        _cacheTask.delegate = self;
        
        [_cacheTask setUrl:replaceUrl offSet:0];
        
    }
    else{
    
        if (_cacheTask.offset + _cacheTask.downloadOffset + 1024 * 30< range.location || range.location < _cacheTask.offset) {
            
            [_cacheTask setUrl:replaceUrl offSet:range.location];
        }
        
        
    }
    
    
}


#pragma mark---cacheVideoSaveCacheDelegate

-(void)didReceiveVideoData:(cacheVideoSaveCache *)cachTask{


    [self dealWithRequestArray];
    
    
}



-(void)didFinishLoadingCacheTask:(cacheVideoSaveCache *)cacheTask{

    
}







@end
