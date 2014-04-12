//
//  RPExampleViewController.m
//  Example
//
//  Created by Rui Peres on 12/04/2014.
//  Copyright (c) 2014 Rui Peres. All rights reserved.
//

#import "RPExampleViewController.h"

#import "RPImageUploaderViewModel.h"
#import "RPBlurredImageView.h"
#import "RPMockViewModel.h"

@interface RPExampleViewController ()

@end

@implementation RPExampleViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];    
    
    {
        NSURLRequest *request = [NSURLRequest requestWithURL:[NSURL URLWithString:@"www.google.com"]];
        UIImage *image = [UIImage imageNamed:@"example.png"];
      //  RPImageUploaderViewModel *imageUploaderViewModel = [[RPImageUploaderViewModel alloc] initWithImage:image request:request];
        
        RPMockViewModel *mockViewModel = [[RPMockViewModel alloc] initWithImage:image request:request];
        
        RPBlurredImageView *blurredImageView = [[RPBlurredImageView alloc] initWithFrame:CGRectMake(10.0f, 50.0f, 300.0f, 200) uploaderViewModel:mockViewModel];
        
        [[self view] addSubview:blurredImageView];
        
        
        [mockViewModel startFakeUpload];
    }
}


@end
