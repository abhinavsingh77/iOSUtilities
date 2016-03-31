//
//  UIImage+LSTResize.m
//
//  Created by Abhinav Singh on 12/06/14.
//

#import "UIImage+LSTResize.h"

@implementation UIImage (LSTResize)

-(void)resizedImageForSize:(CGSize)targetSize completion:(ResizedImage)resized {

	UIImage *newImage = [self resizedImageForSize:targetSize];
	resized(newImage);
}

-(UIImage*)resizedImageForSize:(CGSize)targetSize {
	
	CGSize nowSize = self.size;
	targetSize = CGSizeMake((targetSize.width*[UIScreen mainScreen].scale), (targetSize.height*[UIScreen mainScreen].scale));
	
	float hfactor = nowSize.width / targetSize.width;
	float vfactor = nowSize.height / targetSize.height;
	
	float factor = fmax(hfactor, vfactor);
	
	float newWidth = nowSize.width / factor;
	float newHeight = nowSize.height / factor;
	
	float leftOffset = (targetSize.width - newWidth) / 2.0f;
	float topOffset = (targetSize.height - newHeight) / 2.0f;
	
	CGRect newRect = CGRectMake(leftOffset, topOffset, newWidth, newHeight);
	
	// Create the image context
    UIGraphicsBeginImageContextWithOptions( targetSize, NO, 1);
	
    [self drawInRect:newRect blendMode:kCGBlendModeDarken alpha:1];
	
    UIImage *snapshotImage = UIGraphicsGetImageFromCurrentImageContext();
	UIGraphicsEndImageContext();
	
	CGImageRef croppedRef = CGImageCreateWithImageInRect(snapshotImage.CGImage, newRect);
	UIImage *cropped = [UIImage imageWithCGImage:croppedRef];
	
	return cropped;
}

@end
