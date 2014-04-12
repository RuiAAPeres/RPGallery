//
//  RPImageUploader.m
//  Example
//
//  Created by Rui Peres on 12/04/2014.
//  Copyright (c) 2014 Rui Peres. All rights reserved.
//

#import "RPImageUploader.h"

@interface RPImageUploader () <NSURLSessionTaskDelegate>

@property(nonatomic,strong)NSURLSessionUploadTask *uploadTask;

@property(nonatomic)BOOL isFinished;
@property(nonatomic)BOOL isFailed;
@property(nonatomic)double uploadPercentage;

@end

@implementation RPImageUploader

#pragma mark - Initializer

- (instancetype)init
{
    NSAssert(NO, @"init method shouldn't be used. Use initWithRequest instead");
    return nil;
}

- (instancetype)initWithRequest:(NSURLRequest *)request imageData:(NSData *)imageData
{
    NSAssert(imageData, @"Image should be not nil");
    NSAssert(request, @"Request should be not nil");
    
    if(self = [super init])
    {
        _uploadTask = [self uploadTaskWithRequest:request imageData:imageData];
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
    _uploadPercentage = 0;
}

#pragma mark - NSURLSession

- (NSURLSessionUploadTask *)uploadTaskWithRequest:(NSURLRequest *)request imageData:(NSData *)data
{
    NSURLSessionConfiguration *configuration = [NSURLSessionConfiguration defaultSessionConfiguration];
    NSURLSession *session = [NSURLSession sessionWithConfiguration:configuration delegate:self delegateQueue:nil];
    
    _uploadTask = [session uploadTaskWithRequest:request fromData:data];
    
    return _uploadTask;
}

#pragma mark - NSURLSessionTaskDelegate

- (void)URLSession:(NSURLSession *)session task:(NSURLSessionTask *)task didSendBodyData:(int64_t)bytesSent totalBytesSent:(int64_t)totalBytesSent totalBytesExpectedToSend:(int64_t)totalBytesExpectedToSend
{
   self.uploadPercentage = (double)totalBytesSent / (double)totalBytesExpectedToSend;
}

- (void)URLSession:(NSURLSession *)session task:(NSURLSessionTask *)task didCompleteWithError:(NSError *)error
{
    if (error)
    {
        self.isFailed = YES;
    }
    else
    {
        self.isFinished = YES;
    }
}

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
