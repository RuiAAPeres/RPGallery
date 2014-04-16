//
//  RPImageUploaderViewModel.h
//  Example
//
//  Created by Rui Peres on 12/04/2014.
//  Copyright (c) 2014 Rui Peres. All rights reserved.
//

/**
 The logic for this protocol, it's to enable
 the use of mock objects to act as a ViewModel. The
 properties should be overriden on a class extension so they
 can be readwrite. 
*/
@protocol RPImageUploaderViewModel <NSObject>

/**
 * Designated initializer wichs receives an image and a request. The request will then
 * be used to make the upload of the image, while the image will serve two purposes:
 * 1) Be uploaded
 * 2) Be presented on the RPBlurredImageView
 */
- (instancetype)initWithRequest:(NSURLRequest *)request;

/**
 *  Used to start the upload from the Model part
 */
- (void)start;

@property(nonatomic,strong,readonly)NSProgress *uploadProgress;

@end

/**
 Used as ViewModel for the RPBlurredImageView.
 */
@interface RPImageUploaderViewModel : NSObject <RPImageUploaderViewModel>


@end
