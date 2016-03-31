//
//  NSDate+LSTHelper.h
//
//  Created by Abhinav Singh on 9/10/15.
//

@import Foundation;

@interface NSDate (LSTHelper)

+(NSDate*)dateFromAPIString:(NSString*)string;
-(NSString *)relativeDateString;
-(NSInteger)gapForCalendarUnit:(NSCalendarUnit)unit fromDate:(NSDate*)date;

-(NSDate*)midnightDate;

@end
