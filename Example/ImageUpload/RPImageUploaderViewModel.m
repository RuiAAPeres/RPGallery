//
//  RPImageUploaderViewModel.m
//  Example
//
//  Created by Rui Peres on 12/04/2014.
//  Copyright (c) 2014 Rui Peres. All rights reserved.
//

#import "RPImageUploaderViewModel.h"
#import "RPImageUploader.h"

static NSString *const RPImageUploaderViewModelContext = @"RPImageUploaderViewModelContext";

static NSString *const RPPercentage = @"uploadPercentage";
static NSString *const RPIsFinished = @"isFinished";
static NSString *const RPIsFailed = @"isFailed";

@interface RPImageUploaderViewModel ()

@property(nonatomic,strong)UIImage *imageToBeUploaded;
@property(nonatomic)NSNumber *uploadPercentage;

@property(nonatomic,strong)RPImageUploader *imageUploader;

@end

@implementation RPImageUploaderViewModel

#pragma mark - Initializer

- (instancetype)init
{
    NSAssert(NO, @"init method shouldn't be used. Use initWithImage:request: instead");
    return nil;
}

- (instancetype)initWithImage:(UIImage *)image request:(NSURLRequest *)request
{
    NSAssert(image, @"Image should be not nil");
    NSAssert(request, @"Request should be not nil");

    if (self = [super init])
    {
        _imageToBeUploaded = image;
        _uploadPercentage = @0;
        //TODO: There should possible to create an NSData
        //      from the picture in different ways.
        //      An alternative could be passing a function into the initializer,
        //      that would take an UIImage and return a NSData.
        NSData *imageData = UIImageJPEGRepresentation(image, 0.6f);
        
        _imageUploader = [[RPImageUploader alloc] initWithRequest:request imageData:imageData];
        [self setupKVO];
    }
    
    return self;
}

#pragma mark - Dealloc

- (void)dealloc
{
    [self removeObserver:_imageUploader forKeyPath:RPPercentage context:(__bridge void *)(RPImageUploaderViewModelContext)];
    
    [self removeObserver:_imageUploader forKeyPath:RPIsFailed context:(__bridge void *)(RPImageUploaderViewModelContext)];
    
    [self removeObserver:_imageUploader forKeyPath:RPIsFinished context:(__bridge void *)(RPImageUploaderViewModelContext)];
}

#pragma mark - KVO

- (void)setupKVO
{
    [self addObserver:_imageUploader forKeyPath:RPPercentage options:NSKeyValueObservingOptionNew context:(__bridge void *)(RPImageUploaderViewModelContext)];
    
    
    /// TODO: Report Back the failure and Finished
    [self addObserver:_imageUploader forKeyPath:RPIsFailed options:NSKeyValueObservingOptionNew context:(__bridge void *)(RPImageUploaderViewModelContext)];
    
    [self addObserver:_imageUploader forKeyPath:RPIsFinished options:NSKeyValueObservingOptionNew context:(__bridge void *)(RPImageUploaderViewModelContext)];
}

- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary *)change context:(void *)context
{
    if (context == (__bridge void *)(RPImageUploaderViewModelContext))
    {
        if ([keyPath isEqualToString:RPPercentage])
        {
            self.uploadPercentage = [change objectForKey:NSKeyValueChangeNewKey];
        }
        else
        {
            [super observeValueForKeyPath:keyPath ofObject:object change:change context:context];
        }
    }
}

@end
