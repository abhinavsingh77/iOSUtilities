//
//  UIViewController+LSTHelper.h
//
//  Created by Abhinav Singh on 3/31/16.
//

#import <UIKit/UIKit.h>

typedef NS_ENUM(NSInteger, LSTTransactionDirection) {
	
	LSTTransactionDirectionNone = -1,
	LSTTransactionDirectionTop = 0,
	LSTTransactionDirectionBottom,
	LSTTransactionDirectionLeft,
	LSTTransactionDirectionRight
};

@interface UIViewController (LSTHelper)

+(instancetype)initWithDefaultXIB;

-(void)addController:(UIViewController*)toController
		   replacing:(UIViewController*)fromController
	transactionStyle:(LSTTransactionDirection)trascation;

@end
