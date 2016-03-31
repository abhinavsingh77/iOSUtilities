//
//  NSNumber+LSTFormatting.m
//
//  Created by Abhinav Singh on 9/11/15.
//

#import "NSNumber+LSTFormatting.h"

@implementation NSNumber (LSTFormatting)

NSNumberFormatter* DefaultNumberFormatter () {
	
	static __strong NSNumberFormatter *numberFormatter = nil;
	static dispatch_once_t onceToken;
	dispatch_once(&onceToken, ^{
		
		numberFormatter = [[NSNumberFormatter alloc] init];
		[numberFormatter setNumberStyle:NSNumberFormatterDecimalStyle];
		[numberFormatter setAllowsFloats:YES];
		[numberFormatter setMaximumFractionDigits:2];
	});
	
	return numberFormatter;
}

NSNumberFormatter* DefaultCurrencyFormatter () {
	
	static __strong NSNumberFormatter *currencyFormatter = nil;
	static dispatch_once_t onceToken;
	dispatch_once(&onceToken, ^{
		
		currencyFormatter = [[NSNumberFormatter alloc] init];
		[currencyFormatter setNumberStyle:NSNumberFormatterCurrencyStyle];
		[currencyFormatter setCurrencySymbol:@"₹"];
		[currencyFormatter setAllowsFloats:YES];
		[currencyFormatter setMaximumFractionDigits:2];
	});
	
	return currencyFormatter;
}

NSNumberFormatter* DefaultCurrencyRoundedFormatter () {
	
	static __strong NSNumberFormatter *currencyFormatter = nil;
	static dispatch_once_t onceToken;
	dispatch_once(&onceToken, ^{
		currencyFormatter = [[NSNumberFormatter alloc] init];
		[currencyFormatter setNumberStyle:NSNumberFormatterCurrencyStyle];
		[currencyFormatter setCurrencySymbol:@"₹"];
		[currencyFormatter setAllowsFloats:NO];
		[currencyFormatter setMaximumFractionDigits:0];
	});
	
	return currencyFormatter;
}

-(NSString*)displayString {
	NSNumberFormatter *numberFormatter = DefaultNumberFormatter();
	return [numberFormatter stringFromNumber:self];
}

-(NSString*)displayCurrencyString {
	NSNumberFormatter *currencyFormatter = DefaultCurrencyFormatter();
	return [currencyFormatter stringFromNumber:self];
}

-(NSString*)displayRoundedCurrencyString {
	NSNumberFormatter *currencyFormatter = DefaultCurrencyRoundedFormatter();
	return [currencyFormatter stringFromNumber:self];
}

@end
