//
//  NSNumber+LSTFormatting.h
//
//  Created by Abhinav Singh on 9/11/15.
//

@import Foundation;

@interface NSNumber (LSTFormatting)

-(NSString*)displayString;
-(NSString*)displayCurrencyString;
-(NSString*)displayRoundedCurrencyString;

@end
