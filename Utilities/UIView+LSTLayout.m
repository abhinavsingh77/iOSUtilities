//
//  UIView+LSTLayout.m
//  iOSUtility
//
//  Created by Abhinav Singh on 3/31/16.
//  Copyright © 2016 No Name. All rights reserved.
//

#import "UIView+LSTLayout.h"

@implementation UIView (LSTLayout)

#pragma mark - Autolayout

-(void)checkFoAmbiguousLayout {
	
	for ( UIView *subs in self.subviews) {
		[subs checkFoAmbiguousLayout];
	}
	
	[self exerciseAmbiguityInLayout];
	
	if ([self hasAmbiguousLayout]) {
		
		self.backgroundColor = [UIColor redColor];
		NSLog(@"---------------View:%@", self);
	}
}

-(void)centerVerticallySubViews:(NSArray*)subs withPading:(CGFloat)pading{
	
	UILabel *topPadding = [[UILabel alloc] initWithFrame:CGRectZero];
	topPadding.translatesAutoresizingMaskIntoConstraints = NO;
	[self addSubview:topPadding];
	
	UILabel *bottomPadding = [[UILabel alloc] initWithFrame:CGRectZero];
	bottomPadding.translatesAutoresizingMaskIntoConstraints = NO;
	[self addSubview:bottomPadding];
	
	UIView *topView = [subs firstObject];
	UIView *lastView = [subs lastObject];
	
	NSDictionary *dict = NSDictionaryOfVariableBindings(topPadding, topView, lastView, bottomPadding);
	
	[self addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:|-0-[topPadding(==bottomPadding)]-0-[topView]" options:0 metrics:nil views:dict]];
	[self addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:[lastView]-0-[bottomPadding(==topPadding)]-0-|" options:0 metrics:nil views:dict]];
	
	[self addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|-0-[topPadding]-0-|" options:0 metrics:nil views:dict]];
	[self addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|-0-[bottomPadding]-0-|" options:0 metrics:nil views:dict]];
	
	UIView *lastAdded = nil;
	for ( UIView *subV in subs ) {
		
		if (lastAdded) {
			
			[self addConstraint:[NSLayoutConstraint constraintWithItem:subV
															 attribute:NSLayoutAttributeTop
															 relatedBy:NSLayoutRelationEqual
																toItem:lastAdded
															 attribute:NSLayoutAttributeBottom
															multiplier:1 constant:pading]];
		}
		
		lastAdded = subV;
	}
}

#pragma mark - Frames

-(CGFloat)maxX {
	return (self.frame.size.width+self.frame.origin.x);
}

-(CGFloat)maxY {
	return (self.frame.size.height+self.frame.origin.y);
}

-(CGSize)size {
	return self.frame.size;
}

-(void)setSize:(CGSize)size {
	
	CGRect prev = self.frame;
	prev.size.height = size.height;
	prev.size.width = size.width;
	self.frame = prev;
}

-(CGFloat)originX {
	return self.frame.origin.x;
}

- (void)setOriginX:(CGFloat)xAxics {
	CGRect prev = self.frame;
	prev.origin.x = xAxics;
	self.frame = prev;
}

-(CGFloat)originY {
	return self.frame.origin.y;
}

-(void)setOriginY:(CGFloat)yAxics {
	CGRect prev = self.frame;
	prev.origin.y = yAxics;
	self.frame = prev;
}

-(CGFloat)height {
	return self.frame.size.height;
}

-(void)setHeight:(CGFloat)height {
	CGRect prev = self.frame;
	prev.size.height = height;
	self.frame = prev;
}

-(CGFloat)width {
	return self.frame.size.width;
}

-(void)setWidth:(CGFloat)width {
	CGRect prev = self.frame;
	prev.size.width = width;
	self.frame = prev;
}

-(CGPoint)centerPoint {
	return CGPointMake(self.width/2, self.height/2);
}

@end
