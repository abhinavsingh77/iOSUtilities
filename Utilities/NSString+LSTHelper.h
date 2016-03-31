//
//  NSString+LSTHelper.h
//
//  Created by Abhinav Singh on 3/30/16.
//

@import Foundation;

@interface NSString (LSTHelper)

-(NSString*)trimmedString;
-(NSString*)stringByRemovingExtraSpacesAndNewLine;
-(NSString*)subStringBetween:(NSString*)startString andString:(NSString*)endString;

-(BOOL)isValidEmailAddress;
+(NSString*)naturalLanguageDay:(NSInteger)day;

@end
