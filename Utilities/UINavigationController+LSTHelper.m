//
//  UINavigationController+LSTHelper.m
//
//  Created by Abhinav Singh on 9/2/15.
//

#import "UINavigationController+LSTHelper.h"
#import "UIColor+LSTHelper.h"
#import "UIFont+LSTHelper.h"

@implementation UINavigationController (LSTHelper)

-(void)applyTransparentStyle {
	
	[self.navigationBar setTranslucent:YES];
	[self removeShadowImage];
}

-(void)applyOpaqueStyle {
	
	[self.navigationBar setTranslucent:NO];
	[self.navigationBar setBarTintColor:[UIColor appPrimaryColor]];
	[self.navigationBar setTintColor:[UIColor whiteColor]];
}

-(void)removeShadowImage {
	
	//changing only shadow image won't work.
	[self.navigationBar setBackgroundImage:[[UIImage alloc] init]
							forBarPosition:UIBarPositionAny
								barMetrics:UIBarMetricsDefault];
	
	[self.navigationBar setShadowImage:[UIImage new]];
}

-(void)addModalButton {
	
	UIViewController *root = [self rootViewController];
	
	root.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"Close"
																			 style:UIBarButtonItemStylePlain
																			target:self action:@selector(dismissModalClicked:)];
}

-(UIViewController*)rootViewController {
	
	return [[self viewControllers] firstObject];
}

-(NSArray*)allControllersUptoControllerOfClass:(NSString*)classString {
	
	NSArray *subArray = nil;
	for ( UIViewController *conts in self.viewControllers ) {
		if ([NSStringFromClass([conts class]) isEqualToString:classString]) {
			NSInteger index = [self.viewControllers indexOfObject:conts];
			subArray = [self.viewControllers subarrayWithRange:NSMakeRange(0, index+1)];
			break;
		}
	}
	
	return subArray;
}

-(NSArray*)allControllersUpTo:(UIViewController*)controller {
	
	NSArray *subArray = nil;
	NSInteger index = [self.viewControllers indexOfObject:controller];
	if (index != NSNotFound) {
		subArray = [self.viewControllers subarrayWithRange:NSMakeRange(0, index+1)];
	}
	
	return subArray;
}

- (void)dismissModalClicked:(UIBarButtonItem*)item {
	
	[self.view endEditing:YES];
	[self dismissViewControllerAnimated:YES completion:nil];
}

@end
