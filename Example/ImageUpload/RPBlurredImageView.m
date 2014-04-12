//
//  RPBlurredImageView.m
//  Example
//
//  Created by Rui Peres on 12/04/2014.
//  Copyright (c) 2014 Rui Peres. All rights reserved.
//

#import "RPBlurredImageView.h"
#import "RPImageUploaderViewModel.h"

#import "FXBlurView.h"

static void *RPBlurredImageViewContext = &RPBlurredImageViewContext;

static NSString *const RPPercentage = @"uploadPercentage";

@interface RPBlurredImageView ()

@property(nonatomic,strong)id<RPImageUploaderViewModel> imageUploaderViewModel;
@property(nonatomic,weak)FXBlurView *blurredView;

@end

@implementation RPBlurredImageView

#pragma mark - Initializer

- (instancetype)init
{
    NSAssert(NO, @"init method shouldn't be used. Use initWithFrame:uploaderViewModel: instead");
    return nil;
}

- (instancetype)initWithFrame:(CGRect)frame
{
    NSAssert(NO, @"initWithFrame: method shouldn't be used. Use initWithFrame:uploaderViewModel: instead");
    return nil;
}

- (instancetype)initWithFrame:(CGRect)frame uploaderViewModel:(id<RPImageUploaderViewModel>)imageUploaderViewModel
{
    if (self = [super initWithFrame:frame])
    {
        self.imageUploaderViewModel = imageUploaderViewModel;
        self.image = _imageUploaderViewModel.imageToBeUploaded;
        
        [self setupBlurredImageView];
        [self setupBlurredView];
        [self setupKVO];
    }
    
    return self;
}


#pragma mark - Dealloc

- (void)dealloc
{
    [self removeObserver:_imageUploaderViewModel forKeyPath:RPPercentage context:RPBlurredImageViewContext];
}

#pragma mark - Setup

- (void)setupBlurredView
{
    _blurredView = [self defaultBlurredView];;
    [self addSubview:_blurredView];
}

- (void)setupBlurredImageView
{
    [self setBackgroundColor:[UIColor blackColor]];
    [self setContentMode:UIViewContentModeScaleAspectFit];
}

- (void)setupKVO
{
    [self addObserver:self.imageUploaderViewModel forKeyPath:RPPercentage options:NSKeyValueObservingOptionNew context:RPBlurredImageViewContext];
}

#pragma mark - KVO

- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary *)change context:(void *)context
{
    if (context == RPBlurredImageViewContext)
    {
        if ([keyPath isEqualToString:RPPercentage])
        {
            // TODO: Handle the percentage
        }
    }
}

#pragma mark - Getter

- (FXBlurView *)defaultBlurredView
{
    FXBlurView *blurView = [[FXBlurView alloc] initWithFrame:self.bounds];
    [blurView setBlurRadius:0];
    [blurView setContentMode:UIViewContentModeRight];
    [blurView setTintColor:[UIColor whiteColor]];
    
    return blurView;
}

#pragma mark - Testing

- (void)animate
{
    [self.blurredView updateAsynchronously:YES completion:NULL];
    [FXBlurView setUpdatesDisabled];
    
    [UIView animateWithDuration:10.0f animations:^{
        [self.blurredView setFrame:CGRectMake(CGRectGetWidth(self.blurredView.frame), CGRectGetMinY(self.blurredView.frame), 0.0f, CGRectGetHeight(self.blurredView.frame))];
        
    } completion:^(BOOL finished) {
        [self.blurredView removeFromSuperview];
        [FXBlurView setUpdatesEnabled];
    }];
}


@end
