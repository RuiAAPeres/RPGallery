# RPGallery

RPGallery is a UI Control used to display a collection of `UIImageViews`, that will be uploaded sequencially to a server. Initially an `UIImageView` has an `FXBlurView` on top of it and is progressively removed while the image is being uploaded.

### Components

Right now only the Core classes have been created:

* `RPImageUploader`
* `RPImageUploaderView`
* `RPImageUploaderViewModel`

These follow an [MVVM](http://en.wikipedia.org/wiki/Model_View_ViewModel) pattern, with the help of [ReactiveCocoa](https://github.com/ReactiveCocoa/ReactiveCocoa) powerful bindings. 

### Usage

Even without the `RPGallery` piece, you can still upload images:

```objc
UIImage *image = [UIImage imageNamed:@"example.png"];
NSData *imageData = UIImagePNGRepresentation(image);
    
NSMutableURLRequest *request = [[AFHTTPRequestSerializer serializer]multipartFormRequestWithMethod:@"POST"URLString:@"<your server url>"parameters:nil constructingBodyWithBlock:^(id<AFMultipartFormData> formData) {
	[formData appendPartWithFileData:imageData name:@"file" fileName:@"file.png" mimeType:@"image/png"];
} error:nil];
    
RPImageUploaderViewModel *imageUploaderViewModel = [[RPImageUploaderViewModel alloc] initWithRequest:request];
    
RPImageUploaderView *blurredImageView = [[RPImageUploaderView alloc] initWithFrame:CGRectMake(10.0f, 50.0f, 300.0f, 200) image:image uploaderViewModel:imageUploaderViewModel];
    
[[self view] addSubview:blurredImageView];
[imageUploaderViewModel startWithCompletionHandler:^(NSError *error) {
        
}];
```

### TODO

* Finalise the `RPGallery` component
* Add the component to Cocoapods
* Add an animated Gif

### Behind the scenes

Some reasoning about this library can be found [here](http://codeplease.io).