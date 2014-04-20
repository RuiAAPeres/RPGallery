//
//  RPImageUploaderViewSpec.m
//  Example
//
//  Created by Rui Peres on 19/04/2014.
//  Copyright (c) 2014 Rui Peres. All rights reserved.
//

#import "Kiwi.h"
#import "RPImageUploaderView.h"
#import "FXBlurView.h"
#import "RPImageUploaderView+PrivatePropertiesExposure.h"
#import "RPMockImageUploaderViewModel.h"

SPEC_BEGIN(RPImageUploaderViewSpec)

describe(@"Image Uploader ViewModel", ^{
    context(@"Initializer", ^{
        
        it(@"should be nil for init", ^{
            RPImageUploaderView *imageUploaderView = [[RPImageUploaderView alloc] init];
            
            [[imageUploaderView should] beNil];
        });
        
        it(@"should be nil for initWithFrame:", ^{
            RPImageUploaderView *imageUploaderView = [[RPImageUploaderView alloc] initWithFrame:CGRectZero];
            
            [[imageUploaderView should] beNil];
        });
        
        it(@"should be nil with nil Image", ^{
            
            RPMockImageUploaderViewModel *mockImageUploaderViewModel = [[RPMockImageUploaderViewModel alloc] initWithRequest:[[NSURLRequest alloc] init]];
            
            RPImageUploaderView *imageUploaderView = [[RPImageUploaderView alloc] initWithFrame:CGRectZero image:nil uploaderViewModel:mockImageUploaderViewModel];
            
            [[imageUploaderView should] beNil];
        });
        
        it(@"should be nil with nil ViewModel", ^{
            
            RPImageUploaderView *imageUploaderView = [[RPImageUploaderView alloc] initWithFrame:CGRectZero image:[[UIImage alloc] init] uploaderViewModel:nil];
            
            [[imageUploaderView should] beNil];
        });
        
        it(@"should be non nil with valid input ", ^{
            
            RPMockImageUploaderViewModel *mockImageUploaderViewModel = [[RPMockImageUploaderViewModel alloc] initWithRequest:[[NSURLRequest alloc] init]];
            
            RPImageUploaderView *imageUploaderView = [[RPImageUploaderView alloc] initWithFrame:CGRectZero image:[[UIImage alloc] init] uploaderViewModel:mockImageUploaderViewModel];
            
            [[imageUploaderView should] beNonNil];
        });
        
        it(@"should be an UIImageView's subclass", ^{
            RPMockImageUploaderViewModel *mockImageUploaderViewModel = [[RPMockImageUploaderViewModel alloc] initWithRequest:[[NSURLRequest alloc] init]];
            
            RPImageUploaderView *imageUploaderView = [[RPImageUploaderView alloc] initWithFrame:CGRectZero image:[[UIImage alloc] init] uploaderViewModel:mockImageUploaderViewModel];
            
            [[imageUploaderView should] beKindOfClass:[UIImageView class]];
        });
    });
    
    context(@"State", ^{
        
        CGRect frame = CGRectMake(0.0f, 0.0f, 100.0f, 100.0f);
        
        it(@"should have equal frame initially", ^{
            
            RPMockImageUploaderViewModel *mockImageUploaderViewModel = [[RPMockImageUploaderViewModel alloc] initWithRequest:[[NSURLRequest alloc] init]];
            
            RPImageUploaderView *imageUploaderView = [[RPImageUploaderView alloc] initWithFrame:frame image:[[UIImage alloc] init] uploaderViewModel:mockImageUploaderViewModel];
            
            BOOL areFramesEqual =CGRectEqualToRect(imageUploaderView.blurredView.frame, imageUploaderView.bounds);
            [[theValue(areFramesEqual) should] equal:@YES];
        });
        
        it(@"BlurredView should have half width at 50% upload", ^{
            
            RPMockImageUploaderViewModel *mockImageUploaderViewModel = [[RPMockImageUploaderViewModel alloc] initWithRequest:[[NSURLRequest alloc] init]];
            
            NSProgress *halfProgress = [NSProgress progressWithTotalUnitCount:10];
            [halfProgress setCompletedUnitCount:5];
            [mockImageUploaderViewModel setUploadProgress:halfProgress];
            
            RPImageUploaderView *imageUploaderView = [[RPImageUploaderView alloc] initWithFrame:frame image:[[UIImage alloc] init] uploaderViewModel:mockImageUploaderViewModel];
            
            BOOL isWidthHalf = (imageUploaderView.frame.size.width/2 == imageUploaderView.blurredView.frame.size.width);
            [[theValue(isWidthHalf) should] equal:@YES];
        });
        
        it(@"BlurredView should have zero width at 100% upload", ^{
            
            RPMockImageUploaderViewModel *mockImageUploaderViewModel = [[RPMockImageUploaderViewModel alloc] initWithRequest:[[NSURLRequest alloc] init]];
            
            NSProgress *halfProgress = [NSProgress progressWithTotalUnitCount:10];
            [halfProgress setCompletedUnitCount:10];
            [mockImageUploaderViewModel setUploadProgress:halfProgress];
            
            RPImageUploaderView *imageUploaderView = [[RPImageUploaderView alloc] initWithFrame:frame image:[[UIImage alloc] init] uploaderViewModel:mockImageUploaderViewModel];
            
            BOOL isWidthZero = (imageUploaderView.blurredView.frame.size.width == 0);
            [[theValue(isWidthZero) should] equal:@YES];
        });
    });
});

SPEC_END
