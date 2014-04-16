//
//  RPBlurredImageView.h
//  Example
//
//  Created by Rui Peres on 12/04/2014.
//  Copyright (c) 2014 Rui Peres. All rights reserved.
//

@protocol RPImageUploaderViewModel;

/**
 * Used to show an image's preview, while the same is being uploaded. The progress
 * will be indicated by a blur view on top of it
 */
@interface RPBlurredImageView : UIImageView

/**
 * Designated Initializer.
 */
- (instancetype)initWithFrame:(CGRect)frame image:(UIImage *)image uploaderViewModel:(id <RPImageUploaderViewModel>)imageUploaderViewModel;

@end
