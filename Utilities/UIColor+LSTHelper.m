//
//  UIColor+LSTHelper.m
//  
//  Created by Abhinav Singh on 3/30/16.
//

#import "UIColor+LSTHelper.h"

@implementation UIColor (LSTHelper)

+(UIColor*)appPrimaryColor {
	return [UIColor colorWithRed:0.88 green:0.25 blue:0.22 alpha:1.00];
}

+(UIColor*)appSecondryColor {
	return [UIColor colorWithRed:0.14 green:0.49 blue:0.94 alpha:1.00];
}

+(UIColor*)appLightTextColor {
	return [self colorWithGray:0];
}

+(UIColor*)appMediumTextColor {
	return [self colorWithGray:0.5];
}

+(UIColor*)appDarkTextColor {
	return [self colorWithGray:1];
}

+(UIColor*)appDarkBackgroundColor {
	return [UIColor colorWithRed:0.91 green:0.69 blue:0.33 alpha:1.00];
}

+(UIColor*)appLightBackgroundColor {
	return [UIColor colorWithRed:0.93 green:0.76 blue:0.48 alpha:1.00];
}

+(UIColor*)appDefaultBackgroundColor {
	return [self appDarkBackgroundColor];
}

+(UIColor*)colorWithGray:(CGFloat)gray {
	return nil;
}

@end
