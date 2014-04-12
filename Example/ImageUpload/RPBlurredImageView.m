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

@interface RPBlurredImageView ()

@property(nonatomic,strong)RPImageUploaderViewModel *imageUploaderViewModel;
@property(nonatomic,strong)FXBlurView *blurredView;

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

- (instancetype)initWithFrame:(CGRect)frame uploaderViewModel:(RPImageUploaderViewModel *)imageUploaderViewModel
{
    if (self = [super initWithFrame:frame])
    {
        _imageUploaderViewModel = imageUploaderViewModel;
        self.image = imageUploaderViewModel.imageToBeUploaded;
        [self setBackgroundColor:[UIColor blackColor]];
        [self setContentMode:UIViewContentModeScaleAspectFit];
        
        [self addSubview:self.blurredView];
    }
    
    return self;
}

#pragma mark - Getter

- (FXBlurView *)blurredView
{
    if (!_blurredView)
    {
        _blurredView = ({
            FXBlurView *blurView = [[FXBlurView alloc] initWithFrame:self.bounds];
            [blurView setBlurRadius:0];
            [blurView setContentMode:UIViewContentModeRight];
            [blurView setTintColor:[UIColor whiteColor]];
            
            blurView;
        });
    }
    
    return _blurredView;
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
