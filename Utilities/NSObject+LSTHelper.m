//
//  NSObject+LSTHelper.m
//
//  Created by Abhinav Singh on 9/10/15.
//

#import "NSObject+LSTHelper.h"

@implementation NSObject (LSTHelper)

#pragma mark - Sanitize

-(id)nullCheck {
	if ([self isKindOfClass:[NSNull class]]) {
		return nil;
	}
	return self;
}

-(id)stringCheckValue {
	if ([self isKindOfClass:[NSNull class]]) {
		return nil;
	}else if ([self isKindOfClass:[NSNumber class]]) {
		return ((NSNumber*)self).stringValue;
	}
	return self;
}

-(id)numberCheckValue {
	if ([self isKindOfClass:[NSNull class]]) {
		return nil;
	}else if ([self isKindOfClass:[NSString class]]) {
		return @(((NSString*)self).doubleValue);
	}
	return self;
}

#pragma mark - Error's

-(void)showAlertForNetworkError:(NSError*)error dismissBlock:(CompletionBlock)block {
	
//	NSString *title = nil;
//	NSString *message = nil;
//	
//	[PractoErrorUtility message:&message andTitle:&title forError:error];
//	if (message.length) {
//		
//		[UIAlertView alertViewWithTitle:title message:message cancelButtonTitle:@"Okay" otherButtonTitles:nil
//							  onDismiss:^(NSInteger buttonIndex) {
//							  } onCancel:^{
//								  if (block) {
//									  block();
//								  }
//							  }];
//	}else {
//		
//		if (block) {
//			block();
//		}
//	}
}

-(void)showAlertForNetworkError:(NSError*)error {
	
	[self showAlertForNetworkError:error dismissBlock:nil];
}

@end
