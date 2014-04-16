//
//  RPImageUploader.m
//  Example
//
//  Created by Rui Peres on 12/04/2014.
//  Copyright (c) 2014 Rui Peres. All rights reserved.
//

#import "RPImageUploader.h"
#import "AFURLSessionManager.h"
#import "ReactiveCocoa.h"

@interface RPImageUploader () <NSURLSessionTaskDelegate>

@property(nonatomic,strong)NSURLSessionDataTask *uploadTask;

@property(nonatomic)BOOL isFinished;
@property(nonatomic)BOOL isFailed;

@end

@implementation RPImageUploader

#pragma mark - Initializer

- (instancetype)init
{
    NSAssert(NO, @"init method shouldn't be used. Use initWithRequest instead");
    return nil;
}

- (instancetype)initWithRequest:(NSURLRequest *)request progress:(NSProgress * __autoreleasing *)progress
{
    NSAssert(request, @"Request should be not nil");
    
    if(self = [super init])
    {
        self.uploadTask = [self uploadTaskWithRequest:request progress:progress];
        [self setDefaultKVOValues];
    }
    
    return self;
}

#pragma mark - Dealloc

- (void)dealloc
{
    [self.uploadTask cancel];
}

#pragma mark - Default Configuration

- (void)setDefaultKVOValues
{
    _isFailed = NO;
    _isFinished = NO;
}

#pragma mark - NSURLSession

- (NSURLSessionDataTask *)uploadTaskWithRequest:(NSURLRequest *)request progress:(NSProgress * __autoreleasing *)progress
{
    AFURLSessionManager *manager = [[AFURLSessionManager alloc] initWithSessionConfiguration:[NSURLSessionConfiguration defaultSessionConfiguration]];
    
    __weak typeof(self) weakSelf = self;
    
    NSURLSessionUploadTask *uploadTask = [manager uploadTaskWithStreamedRequest:request progress:progress completionHandler:^(NSURLResponse *response, id responseObject, NSError *error) {
        if (error)
        {
            weakSelf.isFailed = YES;
        } else
        {
            weakSelf.isFinished = YES;
        }
    }];
        
    return uploadTask;
}



#pragma mark - NSURLSessionTaskDelegate

//- (void)URLSession:(NSURLSession *)session task:(NSURLSessionTask *)task didSendBodyData:(int64_t)bytesSent totalBytesSent:(int64_t)totalBytesSent totalBytesExpectedToSend:(int64_t)totalBytesExpectedToSend
//{
//   self.uploadPercentage = [NSNumber numberWithDouble:(double)totalBytesSent / (double)totalBytesExpectedToSend];
//    NSLog(@"%@",self.uploadPercentage);
//}
//
//- (void)URLSession:(NSURLSession *)session didBecomeInvalidWithError:(NSError *)error
//{
//    
//}
//
//- (void)URLSession:(NSURLSession *)session task:(NSURLSessionTask *)task didCompleteWithError:(NSError *)error
//{
//    if (error)
//    {
//        self.isFailed = YES;
//    }
//    else
//    {
//        self.isFinished = YES;
//    }
//}

#pragma mark - Manual Controls

- (void)resume
{
    [_uploadTask resume];
}

- (void)suspend
{
    [_uploadTask suspend];
}

- (void)cancel
{
    [_uploadTask cancel];
}

@end
