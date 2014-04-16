//
//  RPMockViewModel.m
//  Example
//
//  Created by Rui Peres on 12/04/2014.
//  Copyright (c) 2014 Rui Peres. All rights reserved.
//

#import "RPMockViewModel.h"

@interface RPMockViewModel ()

@property(nonatomic)NSProgress *uploadProgress;

@end

@implementation RPMockViewModel

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

- (void)start
{
    // Empty
}

#pragma mark - Mock Methods

-(void)startFakeUploadWithInitialPercentage:(NSProgress *)initialPercentage;
{
    if (initialPercentage.fractionCompleted == 1.f)
    {
        return;
    }
    
    self.uploadProgress = initialPercentage;
    NSNumber *newPercentage = @([initialPercentage fractionCompleted]+.1f);
    
    [self performSelector:@selector(startFakeUploadWithInitialPercentage:) withObject:newPercentage afterDelay:1.3f];
}

@end
