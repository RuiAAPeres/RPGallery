//
//  RPRPImageUploaderSpec.m
//  Example
//
//  Created by Rui Peres on 18/04/2014.
//  Copyright (c) 2014 Rui Peres. All rights reserved.
//

#import "Kiwi.h"
#import "RPImageUploader.h"

SPEC_BEGIN(RPImageUploaderSpec)

describe(@"Image Uploader", ^{
    context(@"Initializer", ^{
        
        it(@"should be nil for init", ^{
            RPImageUploader *imageUploader = [[RPImageUploader alloc] init];
            [[imageUploader should] beNil];
        });
        
        it(@"should be nil for nil Request", ^{
            NSURLRequest *request;
            RPImageUploader *imageUploader = [[RPImageUploader alloc] initWithRequest:request];
            [[imageUploader should] beNil];
        });
        
        it(@"should be non nil for Request", ^{
            NSURLRequest *request = [[NSURLRequest alloc] init];
            RPImageUploader *imageUploader = [[RPImageUploader alloc] initWithRequest:request];
            [[imageUploader should] beNonNil];
        });
    });
    
    context(@"Mock Request", ^{

    });
    
});

SPEC_END
