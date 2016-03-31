//
//  UIColor+LSTHelper.h
//  
//  Created by Abhinav Singh on 3/30/16.
//

@import UIKit;

@interface UIColor (LSTHelper)

+(UIColor*)appPrimaryColor;
+(UIColor*)appSecondryColor;

+(UIColor*)appDarkTextColor;
+(UIColor*)appLightTextColor;
+(UIColor*)appMediumTextColor;

+(UIColor*)appDarkBackgroundColor;
+(UIColor*)appLightBackgroundColor;
+(UIColor*)appDefaultBackgroundColor;

+(UIColor*)colorWithGray:(CGFloat)gray;

@end
