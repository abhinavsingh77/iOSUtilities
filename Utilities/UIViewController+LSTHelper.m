//
//  UIViewController+LSTHelper.m
//
//  Created by Abhinav Singh on 3/31/16.
//

#import "UIViewController+LSTHelper.h"
#import "UIView+LSTLayout.h"

@implementation UIViewController (LSTHelper)


+(instancetype)initWithDefaultXIB {
	
	UIViewController *controller = [[[self class] alloc] initWithNibName:NSStringFromClass([self class]) bundle:nil];
	return controller;
}

-(id)controllerWithIdentifier:(NSString*)identifier {
	return [self.storyboard instantiateViewControllerWithIdentifier:identifier];
}

- (void)addController:(UIViewController*)toController
			replacing:(UIViewController*)fromController
	 transactionStyle:(LSTTransactionDirection)trasacation {
	
	CGFloat fromAnimationDuration = 0.5;
	CGFloat toAnimationDuration = 0.3;
	
	if (!fromController) {
		
		trasacation = LSTTransactionDirectionNone;
		
		fromAnimationDuration = 0;
		toAnimationDuration = 0;
	}
	
	void (^ animateToController)(CGRect startFrame) = ^void (CGRect startFrame){
		
		toController.view.frame = startFrame;
		[self.view addSubview:toController.view];
		[self addChildViewController:toController];
		
		CGRect finalFrame = self.view.bounds;
		
		[UIView animateWithDuration:toAnimationDuration animations:^{
			
			toController.view.frame = finalFrame;
			[toController setNeedsStatusBarAppearanceUpdate];
		} completion:^(BOOL finished) {
			
			[toController didMoveToParentViewController:self];
		}];
	};
	
	void (^ animateFromController)(CGRect finalFrame) = ^void (CGRect finalFrame){
		
		[UIView animateWithDuration:fromAnimationDuration animations:^{
			
			fromController.view.frame = finalFrame;
		} completion:^(BOOL finished) {
			
			[fromController.view removeFromSuperview];
			[fromController removeFromParentViewController];
		}];
	};
	
	switch (trasacation) {
		case LSTTransactionDirectionNone: {
			
			CGRect rectStart = self.view.bounds;
			animateToController(rectStart);
			
			if (fromController) {
			    CGRect rectFinal = fromController.view.frame;
				rectFinal.origin.y = self.view.height;
				animateFromController(rectFinal);
			}
		}
		break;
		case LSTTransactionDirectionTop: {
			
			CGRect rectStart = self.view.bounds;
			rectStart.origin.y = -self.view.height;
			
			animateToController(rectStart);
			
			CGRect rectFinal = fromController.view.frame;
			rectFinal.origin.y = self.view.height;
			animateFromController(rectFinal);
		}
		break;
		case LSTTransactionDirectionBottom: {
			
			CGRect rectStart = self.view.bounds;
			rectStart.origin.y = self.view.height;
			
			animateToController(rectStart);
			
			CGRect rectFinal = fromController.view.frame;
			rectFinal.origin.y = -self.view.height;
			animateFromController(rectFinal);
		}
		break;
		case LSTTransactionDirectionLeft: {
			
			CGRect rectStart = self.view.bounds;
			rectStart.origin.x = -self.view.width;
			
			animateToController(rectStart);
			
			CGRect rectFinal = fromController.view.frame;
			rectFinal.origin.x = self.view.width;
			animateFromController(rectFinal);
		}
		break;
		case LSTTransactionDirectionRight: {
			
			CGRect rectStart = self.view.bounds;
			rectStart.origin.x = self.view.width;
			
			animateToController(rectStart);
			
			CGRect rectFinal = fromController.view.frame;
			rectFinal.origin.x = -self.view.height;
			animateFromController(rectFinal);
		}
			break;
	  default:
			break;
	}
}

@end
