//
//  RPExampleViewController.m
//  Example
//
//  Created by Rui Peres on 12/04/2014.
//  Copyright (c) 2014 Rui Peres. All rights reserved.
//

#import "RPExampleViewController.h"

#import "RPImageUploaderViewModel.h"
#import "RPImageUploaderView.h"
#import "AFURLSessionManager.h"
#import "AFURLRequestSerialization.h"

@interface RPExampleViewController ()

@end

@implementation RPExampleViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    UIImage *image = [UIImage imageNamed:@"example.png"];
    NSData *imageData = UIImagePNGRepresentation(image);
    
    NSMutableURLRequest *request = [[AFHTTPRequestSerializer serializer]multipartFormRequestWithMethod:@"POST"URLString:@"http://38161330.ngrok.com/upload"parameters:nil constructingBodyWithBlock:^(id<AFMultipartFormData> formData) {
        [formData appendPartWithFileData:imageData name:@"file" fileName:@"file.png" mimeType:@"image/png"];
    } error:nil];
    
    RPImageUploaderViewModel *imageUploaderViewModel = [[RPImageUploaderViewModel alloc] initWithRequest:request];
    
    
    RPImageUploaderView *blurredImageView = [[RPImageUploaderView alloc] initWithFrame:CGRectMake(10.0f, 50.0f, 300.0f, 200) image:image uploaderViewModel:imageUploaderViewModel];
    
    [[self view] addSubview:blurredImageView];
    [imageUploaderViewModel startWithCompletionHandler:^(NSError *error) {
        
    }];
}

@end
