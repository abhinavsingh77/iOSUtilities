//
//  NSObject+LSTHelper.h
//
//  Created by Abhinav Singh on 9/10/15.
//

#import "AppUtilities.h"

@interface NSObject (LSTHelper)

-(id)nullCheck;
-(id)stringCheckValue;
-(id)numberCheckValue;

-(void)showAlertForNetworkError:(NSError*)error dismissBlock:(CompletionBlock)block;
-(void)showAlertForNetworkError:(NSError*)error;

@end
