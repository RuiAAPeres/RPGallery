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
@property(nonatomic,copy)RPImageUploaderHandler imageUploaderHandler;

@end

@implementation RPImageUploaderViewModel

#pragma mark - Initializer

- (instancetype)init
{
    return nil;
}

- (instancetype)initWithRequest:(NSURLRequest *)request
{
    if (!request) return nil;
    
    if (self = [super init])
    {
        self.imageUploader = [[RPImageUploader alloc] initWithRequest:request];
        [self setupSignals];
    }
    
    return self;
}

#pragma mark - Setup Signals

- (void)setupSignals
{
    RAC(self,uploadProgress) = RACObserve(self.imageUploader,uploadProgress);
    
    [[RACObserve(self.imageUploader, uploadError) deliverOn:RACScheduler.mainThreadScheduler] subscribeNext:^(NSError *error) {
        if (self.imageUploaderHandler) self.imageUploaderHandler(error);
    }];
    
    [[RACObserve(self.imageUploader, isFinished) deliverOn:RACScheduler.mainThreadScheduler] subscribeNext:^(NSNumber *sisFinished) {
        if (self.imageUploaderHandler) self.imageUploaderHandler(nil);
    }];
}

#pragma mark - Model Ignition

- (void)startWithCompletionHandler:(RPImageUploaderHandler)handler
{
    NSAssert(handler, @"It should be non nil");
    
    self.imageUploaderHandler = [handler copy];
    [self.imageUploader resume];
}

@end
