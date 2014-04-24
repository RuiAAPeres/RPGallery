//
//  RPGallery.m
//  Example
//
//  Created by Rui Peres on 21/04/2014.
//  Copyright (c) 2014 Rui Peres. All rights reserved.
//

#import "RPGallery.h"
#import "RPGalleryFlowLayout.h"

@interface RPGallery () <UICollectionViewDataSource, UICollectionViewDelegateFlowLayout>

@property(nonatomic,strong) UICollectionView *collectionView;

@end

@implementation RPGallery

#pragma mark - Initializer

- (id)init
{
    return nil;
}

- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame])
    {
        [self initialSetup];
    }
    
    return self;
}

- (instancetype)initWithCoder:(NSCoder *)aDecoder
{
    if (self = [super initWithCoder:aDecoder])
    {
        [self initialSetup];
    }
    
    return self;
}

#pragma mark - Setup

- (void)initialSetup
{
    RPGalleryFlowLayout *flowLayout = [[RPGalleryFlowLayout alloc] init];
    self.collectionView = [[UICollectionView alloc] initWithFrame:self.bounds collectionViewLayout:flowLayout];
    self.collectionView.delegate = self;
	self.collectionView.dataSource = self;
    
    [self addSubview:self.collectionView];
}

#pragma mark - UICollectionViewDataSource

-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    return nil;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return 0;
}

#pragma mark - UICollectionViewDelegateFlowLayout

@end
