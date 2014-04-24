//
//  RPGallerySpec.m
//  Example
//
//  Created by Rui Peres on 21/04/2014.
//  Copyright (c) 2014 Rui Peres. All rights reserved.
//

#import "Kiwi.h"
#import "RPGallery.h"

SPEC_BEGIN(RPGallerySpec)

describe(@"Gallery", ^{
    context(@"Initializer", ^{
        
        it(@"should be nil for init", ^{
            RPGallery *gallery = [[RPGallery alloc] init];
            [[gallery should] beNil];
        });
    });
});

SPEC_END
