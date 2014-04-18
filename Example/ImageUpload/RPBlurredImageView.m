//
//  RPBlurredImageView.m
//  Example
//
//  Created by Rui Peres on 12/04/2014.
//  Copyright (c) 2014 Rui Peres. All rights reserved.
//

#import "RPBlurredImageView.h"
#import "RPImageUploaderViewModel.h"

#import "ReactiveCocoa.h"
#import "ReactiveCocoaLayout.h"
#import "RACEXTScope.h"

#import "FXBlurView.h"

static void *RPBlurredImageViewContext = &RPBlurredImageViewContext;

static NSString *const RPPercentage = @"uploadPercentage";

@interface RPBlurredImageView ()

@property(nonatomic,strong)id<RPImageUploaderViewModel> imageUploaderViewModel;
@property(nonatomic,weak)FXBlurView *blurredView;

@property(nonatomic,strong)RACSignal *signal;

@end

@implementation RPBlurredImageView

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
    if (self = [super initWithFrame:frame])
    {
        self.imageUploaderViewModel = imageUploaderViewModel;
        self.image = image;
        
        self.signal = [RACSignal empty];
        
        [self setupBlurredImageView];
        [self setupBlurredView];
        [self setupRACObserve];
    }
    
    return self;
}

#pragma mark - Setup

- (void)setupBlurredView
{
    _blurredView = [self defaultBlurredView];;
    [_blurredView setDynamic:NO];
    [self addSubview:_blurredView];
}

- (void)setupBlurredImageView
{
    [self setBackgroundColor:[UIColor blackColor]];
    [self setContentMode:UIViewContentModeScaleAspectFit];
}

- (void)setupRACObserve
{
    @weakify(self);
    RACSignal *uploadSignal = [[RACObserve(self.imageUploaderViewModel, uploadProgress.fractionCompleted) map:^id(NSNumber *uploadProgress){
        @strongify(self);
        
        int newX = (int)ceil(uploadProgress.doubleValue * self.frame.size.width);
        int newWidth = (int)self.frame.size.width - newX;
        
        CGRect newFrame = CGRectMake(newX, CGRectGetMinY(self.blurredView.frame), newWidth, CGRectGetHeight(self.blurredView.frame));
        
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
