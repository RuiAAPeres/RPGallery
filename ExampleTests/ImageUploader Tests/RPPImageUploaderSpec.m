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
        
        it(@"should be non nil with Request", ^{
            NSURLRequest *request = [[NSURLRequest alloc] init];
            RPImageUploader *imageUploader = [[RPImageUploader alloc] initWithRequest:request];
            [[imageUploader should] beNonNil];
        });

    });
    
    context(@"State", ^{
        it(@"should have isFinished and isFailed set to NO", ^{
            NSURLRequest *request = [[NSURLRequest alloc] init];
            RPImageUploader *imageUploader = [[RPImageUploader alloc] initWithRequest:request];
            
            [[theValue(imageUploader.isFinished) should] equal:@NO];
            [[theValue(imageUploader.isFailed) should] equal:@NO];
        });
        
        it(@"should have uploadProgress set to 0.0f", ^{
            NSURLRequest *request = [[NSURLRequest alloc] init];
            RPImageUploader *imageUploader = [[RPImageUploader alloc] initWithRequest:request];
            
            [[theValue(imageUploader.uploadProgress.fractionCompleted) should] equal:@0.0f];
        });
        
        it(@"should have isFinished set to YES when canceled", ^{
            NSURLRequest *request = [[NSURLRequest alloc] init];
            RPImageUploader *imageUploader = [[RPImageUploader alloc] initWithRequest:request];
            [imageUploader cancel];
            
            [[theValue(imageUploader.isFinished) should] equal:@YES];
        });
    });
});

SPEC_END
