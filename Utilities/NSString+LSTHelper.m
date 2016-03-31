//
//  NSString+LSTHelper.m
//
//  Created by Abhinav Singh on 3/30/16.
//

#import "NSString+LSTHelper.h"

@implementation NSString (LSTHelper)

NSCharacterSet* ToTrimCharacterSet() {
	
	static __strong NSCharacterSet *set = nil;
	static dispatch_once_t onceToken;
	
	dispatch_once(&onceToken, ^{
		set = [NSCharacterSet whitespaceAndNewlineCharacterSet];
	});
	
	return set;
}

-(NSString*)trimmedString {
	
	return [self stringByTrimmingCharactersInSet:ToTrimCharacterSet()];
}

-(NSString*)stringByRemovingExtraSpacesAndNewLine {
	
	NSString *string = self;
	string = [string trimmedString];
	
	NSArray *components = [string componentsSeparatedByCharactersInSet:ToTrimCharacterSet()];
	components = [components filteredArrayUsingPredicate:[NSPredicate predicateWithFormat:@"self <> ''"]];
	
	return [components componentsJoinedByString:@" "];
}

+(NSString*)naturalLanguageDay:(NSInteger)day {
	
	NSString *suffix = @"th";
	if (!((day % 100) >= 10 && (day % 100) < 21)) {
		NSInteger lastDigit = day % 10;
		switch (lastDigit) {
			case 1:
				suffix = @"st";
				break;
				
			case 2:
				suffix = @"nd";
				break;
				
			case 3:
				suffix = @"rd";
				break;
				
			default:
				break;
		}
	}
	
	return suffix;
}

-(NSString*)subStringBetween:(NSString*)startString andString:(NSString*)endString {
	
	NSString *retString = nil;
	NSRange startRange = [self rangeOfString:startString];
	if (startRange.location != NSNotFound) {
		
		NSString *remaing = [self substringFromIndex:(startRange.location+startRange.length)];
		NSRange endRange = [remaing rangeOfString:endString];
		if (endRange.location != NSNotFound) {
			
			retString = [remaing substringWithRange:NSMakeRange(0, endRange.location)];
		}
	}
	
	return retString;
}

-(BOOL)isValidEmailAddress{
	
	// For some obscure reason, escaping the % in the directly in the format string (using %%) does not work and crashes at runtime! But creating the
	// regex outside and inser.ting it into the control string works. Are control strings in Objective-C really standard?
	// Not perfect, but should suit 98% of the e-mail addresses
	
	static NSPredicate *emailPredicate = nil;
	static dispatch_once_t onceToken;
	
	dispatch_once(&onceToken, ^{
		
		NSString *emailRegex = @"[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,4}";
		emailPredicate = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", emailRegex];
	});
	
	return [emailPredicate evaluateWithObject:self];
}

@end
