//
//  RPImageUploaderViewModel.m
//  Example
//
//  Created by Rui Peres on 12/04/2014.
//  Copyright (c) 2014 Rui Peres. All rights reserved.
//

#import "RPImageUploaderViewModel.h"
#import "RPImageUploader.h"
#import "ReactiveCocoa.h"

static NSString *const RPImageUploaderViewModelContext = @"RPImageUploaderViewModelContext";

static NSString *const RPPercentage = @"uploadPercentage";
static NSString *const RPIsFinished = @"isFinished";
static NSString *const RPIsFailed = @"isFailed";

@interface RPImageUploaderViewModel ()

@property(nonatomic,strong)NSProgress *uploadProgress;
@property(nonatomic,strong)RPImageUploader *imageUploader;

@end

@implementation RPImageUploaderViewModel

#pragma mark - Initializer

- (instancetype)init
{
    return nil;
}

- (instancetype)initWithRequest:(NSURLRequest *)request
{
    NSAssert(request, @"Request should be not nil");

    if (self = [super init])
    {
        _imageUploader = [[RPImageUploader alloc] initWithRequest:request];
        [self setupSignals];
    }
    
    return self;
}

#pragma mark - Setup Signals

- (void)setupSignals
{
    RAC(self,uploadProgress) = RACObserve(self.imageUploader,uploadProgress);
    
    [RACObserve(self, uploadProgress.fractionCompleted) subscribeNext:^(id x) {
        NSLog(@"%@",x);
    }];
    
    [RACObserve(self.imageUploader, isFailed) subscribeNext:^(id x) {
        //TODO: Notify it has failed
    }];
    
    [RACObserve(self.imageUploader, isFinished) subscribeNext:^(id x) {
        //TODO: Notify it has finished
    }];
}

#pragma mark - Model Ignition

- (void)start
{
    [_imageUploader resume];
}

@end
