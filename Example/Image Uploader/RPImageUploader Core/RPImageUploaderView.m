//
//  RPImageUploaderView.m
//  Example
//
//  Created by Rui Peres on 12/04/2014.
//  Copyright (c) 2014 Rui Peres. All rights reserved.
//

#import "RPImageUploaderView.h"
#import "RPImageUploaderViewModel.h"

#import "ReactiveCocoa.h"
#import "ReactiveCocoaLayout.h"
#import "RACEXTScope.h"

#import "FXBlurView.h"

static void *RPBlurredImageViewContext = &RPBlurredImageViewContext;

static NSString *const RPPercentage = @"uploadPercentage";

@interface RPImageUploaderView ()

@property(nonatomic,strong)id<RPImageUploaderViewModel> imageUploaderViewModel;

@property(nonatomic,weak)FXBlurView *blurredView;
@property(nonatomic,strong)RACSignal *signal;

@end

@implementation RPImageUploaderView

#pragma mark - Initializer

- (instancetype)init
{
    return nil;
}

- (instancetype)initWithFrame:(CGRect)frame
{
    return nil;
}

- (instancetype)initWithFrame:(CGRect)frame image:(UIImage *)image uploaderViewModel:(id<RPImageUploaderViewModel>)imageUploaderViewModel
{
    if (!image) return nil;
    if (!imageUploaderViewModel) return nil;
    
    if (self = [super initWithFrame:frame])
    {
        self.imageUploaderViewModel = imageUploaderViewModel;
        self.image = image;
        self.signal = [RACSignal empty];
        

        [self setupBlurredView];
        [self setupRACObserve];
        [self setupImageUploaderView];
    }
    
    return self;
}

#pragma mark - Frame Calculation

- (CGRect)frameFromUploadProgress:(NSNumber *)uploadProgress
{
    int newX = (int)ceil(uploadProgress.doubleValue * self.frame.size.width);
    int newWidth = (int)self.frame.size.width - newX;
    
    CGRect newFrame = CGRectMake(newX, CGRectGetMinY(self.blurredView.frame), newWidth, CGRectGetHeight(self.blurredView.frame));
    
    return newFrame;
}

#pragma mark - Setup

- (void)updateBlurredViewFrameWithProgress:(double)progress
{
    CGRect updatedBlurredFrame = [self frameFromUploadProgress:@(progress)];
    self.blurredView.frame = updatedBlurredFrame;
}

- (void)setupBlurredView
{
    _blurredView = [self defaultBlurredView];
    [_blurredView setDynamic:NO];
    
    // The upload progress might have already started, so we can't
    // assume the progress will be zero when this View is created
    [self updateBlurredViewFrameWithProgress:self.imageUploaderViewModel.uploadProgress.fractionCompleted];
    
    // If it's zero, there is no point in adding it
    if (self.blurredView.frame.size.width != 0)
    {
        [self addSubview:_blurredView];
    }
    else
    {
        // Nil it out immediatly
        _blurredView = nil;
    }
}

- (void)setupImageUploaderView
{
    [self setBackgroundColor:[UIColor blackColor]];
    [self setContentMode:UIViewContentModeScaleAspectFit];
}

- (void)setupRACObserve
{
    @weakify(self);
    RACSignal *uploadSignal = [[RACObserve(self.imageUploaderViewModel, uploadProgress.fractionCompleted) map:^id(NSNumber *uploadProgress){
        @strongify(self);
        
        CGRect newFrame = [self frameFromUploadProgress:uploadProgress];
        
        return [NSValue valueWithCGRect:newFrame];
    }] deliverOn:RACScheduler.mainThreadScheduler];
    
    [self setupBlurViewAnimationWithUploadSignal:uploadSignal];
}

- (void)setupBlurViewAnimationWithUploadSignal:(RACSignal *)uploadSignal
{
    @weakify(self);
    NSValue *currentFrame = [NSValue valueWithCGRect:self.blurredView.frame];
    RAC(self.blurredView,rcl_frame,currentFrame) = [[[uploadSignal throttle:0.3f] animateWithDuration:0.3f] doAnimationCompleted:^(NSValue *newFrame) {
        @strongify(self);
        if (newFrame.CGRectValue.size.width <= 0)
        {
            [self.blurredView removeFromSuperview];
        }
    }];
}

#pragma mark - BlurredView Creation

- (FXBlurView *)defaultBlurredView
{
    FXBlurView *blurView = [[FXBlurView alloc] initWithFrame:self.bounds];
    [blurView setBlurRadius:0];
    [blurView setContentMode:UIViewContentModeRight];
    [blurView setTintColor:[UIColor whiteColor]];
    
    return blurView;
}

@end
