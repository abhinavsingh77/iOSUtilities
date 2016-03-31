//
//  NSDate+Helpers.m
//
//  Created by Abhinav Singh on 9/10/15.
//

#import "NSDate+LSTHelper.h"

@import UIKit;

@implementation NSDate (LSTHelper)

NSDateFormatter* APIDateTimeFormatter () {
	
	static __strong NSDateFormatter *dateFormatter = nil;
	static dispatch_once_t onceToken;
	dispatch_once(&onceToken, ^{
		
		dateFormatter = [[NSDateFormatter alloc] init];
		[dateFormatter setLocale:[[NSLocale alloc] initWithLocaleIdentifier:@"en_US"]];
//TODO: Change date formatter to match your api
		[dateFormatter setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
	});
	
	return dateFormatter;
}

NSDateFormatter* DisplayDateTimeFormatter () {
    
    static __strong NSDateFormatter *dateFormatter = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        
        dateFormatter = [[NSDateFormatter alloc] init];
        [dateFormatter setLocale:[[NSLocale alloc] initWithLocaleIdentifier:@"en_US"]];
//TODO: Change date formatter
        [dateFormatter setDateFormat:@"dd MMM yyyy"];
    });
    
    return dateFormatter;
}


+(NSDate*)dateFromAPIString:(NSString*)string {
	
	return [APIDateTimeFormatter() dateFromString:string];
}

-(NSString *)relativeDateString {
	
    NSCalendarUnit units = 0;
    if ([UIVisualEffect class]) {
        units = (NSCalendarUnitSecond | NSCalendarUnitMinute | NSCalendarUnitHour | NSCalendarUnitDay | NSCalendarUnitMonth | NSCalendarUnitYear);
    }
    else {
        units = (NSSecondCalendarUnit | NSMinuteCalendarUnit | NSHourCalendarUnit | NSDayCalendarUnit | NSMonthCalendarUnit | NSYearCalendarUnit);
    }
    
	NSDateComponents *components = [[NSCalendar currentCalendar] components:units
                                                                   fromDate:self
																	 toDate:[NSDate date]
																	options:NSCalendarMatchLast];
	NSString *returned = nil;
	
	if (components.year >= 1) {
		
		if (components.year == 1){
			returned = @"a year ago";
		}else {
			returned = [NSString stringWithFormat:@"%ld years ago", (long)components.year];
		}
	}
	else if (components.month >= 1) {
		
		if (components.month == 1){
			returned = @"a month ago";
		}else {
			returned = [NSString stringWithFormat:@"%ld months ago", (long)components.month];
		}
	}
	else if (components.day >= 1){
		
		if (components.day == 1){
			returned = @"Yesterday";
		}
		else{
			returned = [NSString stringWithFormat:@"%ld days ago", (long)components.day];
		}
	}
	else if (components.hour > 0) {
		if (components.hour == 1){
			returned = [NSString stringWithFormat:@"%ld hour ago", (long)components.hour];
		}
		else {
			returned = [NSString stringWithFormat:@"%ld hours ago", (long)components.hour];
		}
	}
	else if (components.minute > 0) {
		if (components.minute == 1){
			returned = [NSString stringWithFormat:@"%ld min ago", (long)components.minute];
		}
		else {
			returned = [NSString stringWithFormat:@"%ld mins ago", (long)components.minute];
		}
	}
	else if (components.second > 0) {
		
		returned = [NSString stringWithFormat:@"%ld sec ago", (long)components.second];
	}
	else {
		returned = @"JUST NOW";
	}
	
	return returned;
}

-(NSInteger)gapForCalendarUnit:(NSCalendarUnit)unit fromDate:(NSDate*)date {
    
    NSDateComponents *components = [[NSCalendar currentCalendar] components:unit
                                                                   fromDate:self
                                                                     toDate:date
                                                                    options:0];
    NSInteger retValue = NSNotFound;
    switch (unit) {
        case NSCalendarUnitSecond:
            retValue = components.second;
            break;
        case NSCalendarUnitMinute:
            retValue = components.minute;
            break;
        case NSCalendarUnitHour:
            retValue = components.hour;
            break;
        case NSCalendarUnitDay:
            retValue = components.day;
            break;
        case NSCalendarUnitMonth:
            retValue = components.month;
            break;
        case NSCalendarUnitYear:
            retValue = components.year;
            break;
        default:
            break;
    }
    
    return retValue;
}

-(NSDate*)midnightDate {
	
	NSCalendar *calender = [NSCalendar currentCalendar];
	
	NSUInteger components = (NSCalendarUnitYear| NSCalendarUnitMonth| NSCalendarUnitDay);
	return [calender dateFromComponents:[calender components:components fromDate:self]];
}

@end
