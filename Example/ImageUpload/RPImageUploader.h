//
//  RPImageUploader.h
//  Example
//
//  Created by Rui Peres on 12/04/2014.
//  Copyright (c) 2014 Rui Peres. All rights reserved.
//

/**
 Responsible for uploading an image
 */
@interface RPImageUploader : NSObject

/// Properties used for KVO (isFinish, hasFailed, percentage)
@property(nonatomic,readonly)BOOL isFinished;
@property(nonatomic,readonly)BOOL isFailed;
@property(nonatomic,readonly)double uploadPercentage;

/**
 Designated Initializer. Receives a request and the image's Data. This 
 can be build for example like:
*/
- (instancetype)initWithRequest:(NSURLRequest *)request imageData:(NSData *)imageData;

/// Manual Operations
- (void)cancel;
- (void)resume;
- (void)suspend;

@end
