//
//  RPGallery.h
//  Example
//
//  Created by Rui Peres on 21/04/2014.
//  Copyright (c) 2014 Rui Peres. All rights reserved.
//

@class RPImageUploaderView;
@class RPGallery;

@protocol RPGalleryDataSource <NSObject>

@required

// Acts as collectionView:cellForItemAtIndexPath:. You should return a RPImageUploaderView
// to be processed.
- (RPImageUploaderView *)gallery:(RPGallery *)gallery uploadImageAtIndex:(NSUInteger)index;

// Acts as a collectionView:numberOfItemsInSection:. You should return the number of uploads you will do.
- (NSUInteger)numberOfUploadImagesInGallery:(RPGallery *)gallery;

@end

/**
 RPGallery is an abstraction of an UICollectionView. It will show a collection of RPImageUploaderView, that will
 then upload the image they are showing. It provides a similar behaviour in terms of data source/delegateFlowLayout
 as an UICollectionView.
 */
@interface RPGallery : UIView

@property (nonatomic,strong) id<RPGalleryDataSource> dataSource;

- (void)reloadData;

@end
