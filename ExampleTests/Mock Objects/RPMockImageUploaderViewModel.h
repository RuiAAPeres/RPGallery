//
//  RPMockImageUploaderViewModel.h
//  Example
//
//  Created by Rui Peres on 12/04/2014.
//  Copyright (c) 2014 Rui Peres. All rights reserved.
//

#import "RPImageUploaderViewModel.h"

@interface RPMockImageUploaderViewModel : NSObject <RPImageUploaderViewModel>

@property(nonatomic,strong)NSProgress *uploadProgress;

@end
