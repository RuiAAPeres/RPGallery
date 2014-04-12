//
//  RPMockViewModel.m
//  Example
//
//  Created by Rui Peres on 12/04/2014.
//  Copyright (c) 2014 Rui Peres. All rights reserved.
//

#import "RPMockViewModel.h"

@interface RPMockViewModel ()

@property(nonatomic,strong)UIImage *imageToBeUploaded;
@property(nonatomic)NSNumber *uploadPercentage;

@end

@implementation RPMockViewModel

#pragma mark - Initializer

- (instancetype)initWithImage:(UIImage *)image request:(NSURLRequest *)request
{
    NSAssert(image, @"Image should be not nil");
    NSAssert(request, @"Request should be not nil");
    
    if (self = [super init])
    {
        _imageToBeUploaded = image;
        _uploadPercentage = @0;
    }
    
    return self;
}

#pragma mark - Mock Methods

- (void)startFakeUpload
{
    self.uploadPercentage = @1;
}

@end
