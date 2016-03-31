//
//  AppUtilities.h
//  iOSUtility
//
//  Created by Abhinav Singh on 3/31/16.
//  Copyright © 2016 No Name. All rights reserved.
//

@import Foundation;

#define DegreeToRadian(degree) (degree/57.2957795)
#define RadianToDegree(radian) (radian*57.2957795f)

typedef void (^ CompletionBlock)();
typedef void (^ DataCompletionBlock)(id data);
typedef void (^ SuccessBlock)(BOOL success);

#import "NSString+LSTHelper.h"
#import "UIColor+LSTHelper.h"
#import "UIFont+LSTHelper.h"
#import "NSDate+LSTHelper.h"
#import "NSNumber+LSTFormatting.h"
#import "NSObject+LSTHelper.h"
#import "UIImage+LSTResize.h"
#import "UINavigationController+LSTHelper.h"
#import "UIViewController+LSTHelper.h"
#import "UITableView+LSTHelper.h"
#import "UIView+LSTHelper.h"
#import "UIView+LSTLayout.h"