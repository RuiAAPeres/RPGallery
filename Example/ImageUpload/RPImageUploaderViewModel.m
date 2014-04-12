//
//  RPImageUploaderViewModel.m
//  Example
//
//  Created by Rui Peres on 12/04/2014.
//  Copyright (c) 2014 Rui Peres. All rights reserved.
//

#import "RPImageUploaderViewModel.h"
#import "RPImageUploader.h"

@interface RPImageUploaderViewModel ()

@property(nonatomic,strong)UIImage *imageToBeUploaded;
@property(nonatomic,strong)RPImageUploader *imageUploader;

@end

@implementation RPImageUploaderViewModel

#pragma mark - Initializer

- (instancetype)init
{
    NSAssert(NO, @"init method shouldn't be used. Use initWithImage:request: instead");
    return nil;
}

- (instancetype)initWithImage:(UIImage *)image request:(NSURLRequest *)request
{
    NSAssert(image, @"Image should be not nil");
    NSAssert(request, @"Request should be not nil");

    if (self = [super init])
    {
        _imageToBeUploaded = image;
        
        //TODO: There should possible to create an NSData from the picture in different ways
        NSData *imageData = UIImageJPEGRepresentation(image, 0.6);
        _imageUploader = [[RPImageUploader alloc] initWithRequest:request imageData:imageData];
    }
    
    return self;
}

@end
