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
@property(nonatomic,strong)NSProgress *uploadProgress;

@end

@implementation RPImageUploader

#pragma mark - Initializer

- (instancetype)init
{
    NSAssert(NO, @"init method shouldn't be used. Use initWithRequest instead");
    return nil;
}

- (instancetype)initWithRequest:(NSURLRequest *)request
{
    NSAssert(request, @"Request should be not nil");
    
    if(self = [super init])
    {
        NSProgress *progress;
        self.uploadTask = [self uploadTaskWithRequest:request progress:&progress];
        self.uploadProgress = progress;
        
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
