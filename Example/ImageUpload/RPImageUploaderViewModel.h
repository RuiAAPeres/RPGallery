//
//  RPImageUploaderViewModel.h
//  Example
//
//  Created by Rui Peres on 12/04/2014.
//  Copyright (c) 2014 Rui Peres. All rights reserved.
//

/**
 Used as ViewModel for the RPBlurredImageView.
 */
@interface RPImageUploaderViewModel : NSObject

@property(nonatomic,strong,readonly)UIImage *imageToBeUploaded;
@property(nonatomic,readonly)double percentage;

/**
 Designated initializer wichs receives an image and a request. The request will then
 be used to make the upload of the image, while the image will serve two purposes:
 1) Be uploaded
 2) Be presented on the RPBlurredImageView
 */
- (instancetype)initWithImage:(UIImage *)image request:(NSURLRequest *)request;

@end
