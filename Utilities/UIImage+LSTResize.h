//
//  UIImage+LSTResize.h
//
//  Created by Abhinav Singh on 12/06/14.
//

@import UIKit;

typedef void (^ ResizedImage)(UIImage *newImage);

@interface UIImage (LSTResize)

-(void)resizedImageForSize:(CGSize)targetSize completion:(ResizedImage)resized;
-(UIImage*)resizedImageForSize:(CGSize)targetSize;

@end
