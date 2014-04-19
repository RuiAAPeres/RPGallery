//
//  RPImageUploaderViewModelSpec.m
//  Example
//
//  Created by Rui Peres on 19/04/2014.
//  Copyright (c) 2014 Rui Peres. All rights reserved.
//

#import "Kiwi.h"
#import "RPImageUploaderViewModel.h"

SPEC_BEGIN(RPImageUploaderViewModelSpec)

describe(@"Image Uploader ViewModel", ^{
    context(@"Initializer", ^{
        
        it(@"should be nil for init", ^{
            RPImageUploaderViewModel *imageUploaderViewModel = [[RPImageUploaderViewModel alloc] init];
            [[imageUploaderViewModel should] beNil];
        });
        
        it(@"should be nil for nil Request", ^{
            NSURLRequest *request;
            RPImageUploaderViewModel *imageUploaderViewModel = [[RPImageUploaderViewModel alloc] initWithRequest:request];
            [[imageUploaderViewModel should] beNil];
        });
        
        it(@"should be non nil for Request", ^{
            NSURLRequest *request = [[NSURLRequest alloc] init];
            RPImageUploaderViewModel *imageUploaderViewModel = [[RPImageUploaderViewModel alloc] initWithRequest:request];
            [[imageUploaderViewModel should] beNonNil];
        });
        
        it(@"should conform with the RPImageUploaderViewModel protocol", ^{
            NSURLRequest *request = [[NSURLRequest alloc] init];
            RPImageUploaderViewModel *imageUploaderViewModel = [[RPImageUploaderViewModel alloc] initWithRequest:request];
            
            [[imageUploaderViewModel should] conformToProtocol:@protocol(RPImageUploaderViewModel)];
        });
        
        it(@"should conform with the RPImageUploaderViewModel protocol", ^{
            NSURLRequest *request = [[NSURLRequest alloc] init];
            RPImageUploaderViewModel *imageUploaderViewModel = [[RPImageUploaderViewModel alloc] initWithRequest:request];
            
            [[imageUploaderViewModel should] conformToProtocol:@protocol(RPImageUploaderViewModel)];
        });
    });
    
    context(@"State", ^{
        it(@"should have the update progress set", ^{
            NSURLRequest *request = [[NSURLRequest alloc] init];
            RPImageUploaderViewModel *imageUploaderViewModel = [[RPImageUploaderViewModel alloc] initWithRequest:request];
            
            [[imageUploaderViewModel.uploadProgress should] beNonNil];
        });
    });
});

SPEC_END
