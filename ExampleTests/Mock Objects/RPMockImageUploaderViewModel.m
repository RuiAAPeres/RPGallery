//
//  RPMockImageUploaderViewModel.m
//  Example
//
//  Created by Rui Peres on 12/04/2014.
//  Copyright (c) 2014 Rui Peres. All rights reserved.
//

#import "RPMockImageUploaderViewModel.h"

@implementation RPMockImageUploaderViewModel

#pragma mark - Initializer

- (instancetype)initWithRequest:(NSURLRequest *)request
{
    NSAssert(request, @"Request should be not nil");
    
    if (self = [super init])
    {
        _uploadProgress = [NSProgress progressWithTotalUnitCount:0];
    }
    
    return self;
}

#pragma mark - 

- (void)startWithCompletionHandler:(RPImageUploaderHandler)handler
{
    NSProgress *initialProgress = [NSProgress progressWithTotalUnitCount:0];
    [self startFakeUploadWithInitialPercentage:initialProgress];
}

#pragma mark - Mock Methods

-(void)startFakeUploadWithInitialPercentage:(NSProgress *)initialPercentage
{
    if (initialPercentage.fractionCompleted == 1.f)
    {
        return;
    }
    
    self.uploadProgress = initialPercentage;
    NSNumber *newPercentage = @([initialPercentage fractionCompleted]+.1f);
    
    [self performSelector:@selector(startFakeUploadWithInitialPercentage:) withObject:newPercentage afterDelay:0.1f];
}

@end
