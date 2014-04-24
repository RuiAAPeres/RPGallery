//
//  RPImageUploaderView+PrivatePropertiesExposure.h
//  Example
//
//  Created by Rui Peres on 19/04/2014.
//  Copyright (c) 2014 Rui Peres. All rights reserved.
//

#import "RPImageUploaderView.h"

@class FXBlurView;

@interface RPImageUploaderView (PrivatePropertiesExposure)

@property(nonatomic,weak)FXBlurView *blurredView;

@end
