//
//  cacheVideoConnect.m
//  learningAVPlaying
//
//  Created by 掌上先机 on 17/3/15.
//  Copyright © 2017年 wangchao. All rights reserved.
//
#import <MobileCoreServices/MobileCoreServices.h>
#import "cacheVideoConnect.h"

@implementation cacheVideoConnect


-(BOOL)resourceLoader:(AVAssetResourceLoader *)resourceLoader shouldWaitForLoadingOfRequestedResource:(AVAssetResourceLoadingRequest *)loadingRequest{
    
    [self fillInContentInformation:loadingRequest.contentInformationRequest];
    
    NSLog(@"laodingRequest=========%@",loadingRequest.request.URL);

    return YES;

}


-(void)resourceLoader:(AVAssetResourceLoader *)resourceLoader didCancelLoadingRequest:(AVAssetResourceLoadingRequest *)loadingRequest{


    
}

- (void)fillInContentInformation:(AVAssetResourceLoadingContentInformationRequest *)contentInformationRequest
{
    NSString *mimeType = @"video/mp4";
    
    CFStringRef contentType = UTTypeCreatePreferredIdentifierForTag(kUTTagClassMIMEType, (__bridge CFStringRef)(mimeType), NULL);
    contentInformationRequest.byteRangeAccessSupported = YES;
    contentInformationRequest.contentType = CFBridgingRelease(contentType);
    contentInformationRequest.contentLength = MAXFLOAT;
}




@end
