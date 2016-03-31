//
//  UIView+Helpers.m
//
//  Created by Abhinav Singh on 9/2/15.
//

#import "UIView+LSTHelper.h"
#import "UIColor+LSTHelper.h"

@implementation UIView (LSTHelper)

+(instancetype)initWithDefaultXib {
	
	NSArray *allObjects = [[UINib nibWithNibName:NSStringFromClass(self) bundle:nil]
						   instantiateWithOwner:nil
						   options:nil];
	
	UIView *thisView = [allObjects firstObject];
	
	return thisView;
}

-(NSArray*)addBorderLineAtPosition:(BorderLinePosition)position ofMagnitude:(CGFloat)magn
						   andColor:(UIColor*)color andOffset:(CGFloat)offset{
	
	if (!magn) {
		magn = 0.5;
	}
	if (!color) {
		color = [UIColor colorWithGray:0.8];
	}
	
	NSMutableArray *lines = [NSMutableArray new];
	
	UIView * (^ defaultLineView)() = ^UIView * (){
		
		UIView *seperatorLine = [[UIView alloc] initWithFrame:CGRectZero];
		seperatorLine.translatesAutoresizingMaskIntoConstraints = NO;
		seperatorLine.backgroundColor = color;
		[self addSubview:seperatorLine];
		[lines addObject:seperatorLine];
		
		return seperatorLine;
	};
	
	
	UIView *selfView = self;
	
	if ((position&BorderLinePositionTop)) {
		
		UIView *viewAdded = defaultLineView();
		NSDictionary *views = NSDictionaryOfVariableBindings(selfView, viewAdded);
		
		[selfView addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:[NSString stringWithFormat:@"H:|-%f-[viewAdded]-0-|", offset] options:0 metrics:nil views:views]];
		[selfView addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:[NSString stringWithFormat:@"V:|-%f-[viewAdded(==%f)]",offset, magn] options:0 metrics:nil views:views]];
	}
	
	if ((position&BorderLinePositionBottom)) {
		
		UIView *viewAdded = defaultLineView();
		NSDictionary *views = NSDictionaryOfVariableBindings(selfView, viewAdded);
		
		[selfView addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:[NSString stringWithFormat:@"H:|-%f-[viewAdded]-0-|", offset] options:0 metrics:nil views:views]];
		[selfView addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:[NSString stringWithFormat:@"V:[viewAdded(==%f)]-0-|", magn] options:0 metrics:nil views:views]];
	}
	
	if ((position&BorderLinePositionLeft)) {
		
		UIView *viewAdded = defaultLineView();
		NSDictionary *views = NSDictionaryOfVariableBindings(selfView, viewAdded);
		
		[selfView addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:[NSString stringWithFormat:@"H:|-0-[viewAdded(==%f)]",magn] options:0 metrics:nil views:views]];
		[selfView addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:[NSString stringWithFormat:@"V:|-%f-[viewAdded]-0-|", offset] options:0 metrics:nil views:views]];
	}
	
	if ((position&BorderLinePositionRight)) {
		
		UIView *viewAdded = defaultLineView();
		NSDictionary *views = NSDictionaryOfVariableBindings(selfView, viewAdded);
		
		[selfView addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:[NSString stringWithFormat:@"H:[viewAdded(==%f)]-%f-|", magn, offset] options:0 metrics:nil views:views]];
		[selfView addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:[NSString stringWithFormat:@"V:|-%f-[viewAdded(==selfView)]-0-|",offset] options:0 metrics:nil views:views]];
	}
	
	if ((position&BorderLineHorizantalCenter)) {
		
		UIView *viewAdded = defaultLineView();
		NSDictionary *views = NSDictionaryOfVariableBindings(selfView, viewAdded);
		
		[selfView addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:[NSString stringWithFormat:@"H:|-%f-[viewAdded]-0-|", offset] options:0 metrics:nil views:views]];
		[selfView addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:[NSString stringWithFormat:@"V:[viewAdded(==%f)]", magn] options:0 metrics:nil views:views]];
		
		[selfView addConstraint:[NSLayoutConstraint constraintWithItem:viewAdded
															 attribute:NSLayoutAttributeCenterY
															 relatedBy:NSLayoutRelationEqual
																toItem:selfView
															 attribute:NSLayoutAttributeCenterY
															multiplier:1 constant:0]];
	}
	
	return lines;
}

-(NSArray*)addBorderLineAtPosition:(BorderLinePosition)position {
	
	return [self addBorderLineAtPosition:position ofMagnitude:0 andColor:nil andOffset:0];
}

-(UIView*)firstResponderSubview {
	
	UIView *responder = nil;
	for ( UIView *subs in self.subviews) {
		
		if ([subs isFirstResponder]) {
			responder = subs;
		}else {
			responder = [subs firstResponderSubview];
		}
		if (responder) {
			break;
		}
	}
	
	return responder;
}

#pragma mark - Snapshots

-(UIImage*)snapShotImage {
	
	UIGraphicsBeginImageContextWithOptions(self.bounds.size, NO, [UIScreen mainScreen].scale);
	[self drawViewHierarchyInRect:self.bounds afterScreenUpdates:YES];
	UIImage *snapshotImage = UIGraphicsGetImageFromCurrentImageContext();
	UIGraphicsEndImageContext();
	
	return snapshotImage;
}

@end
