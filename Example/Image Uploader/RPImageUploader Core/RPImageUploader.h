//
//  RPImageUploader.h
//  Example
//
//  Created by Rui Peres on 12/04/2014.
//  Copyright (c) 2014 Rui Peres. All rights reserved.
//

/**
 * Responsible for uploading an image
 */
@interface RPImageUploader : NSObject

/// Properties used for KVO (isFinish, hasFailed)
@property(nonatomic,readonly)BOOL isFinished;
@property(nonatomic,readonly)NSError *uploadError;
@property(nonatomic,strong,readonly)NSProgress *uploadProgress;

/**
 * Designated Initializer.
 */
- (instancetype)initWithRequest:(NSURLRequest *)request;

/// Manual Operations
- (void)cancel;
- (void)resume;

@end
