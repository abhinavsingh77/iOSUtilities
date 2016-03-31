//
//  UIView+LSTHelper.h
//
//  Created by Abhinav Singh on 9/2/15.
//

@import UIKit;

typedef NS_ENUM(NSInteger, BorderLinePosition) {
	
	BorderLinePositionTop = 1 << 0,
	BorderLinePositionBottom = 1 << 1,
	BorderLinePositionLeft = 1 << 2,
	BorderLinePositionRight = 1 << 3,
	BorderLineHorizantalCenter = 1 << 4,
	BorderLineVerticalCenter = 1 << 5,
};

@interface UIView (LSTHelper)

+(instancetype)initWithDefaultXib;

-(NSArray*)addBorderLineAtPosition:(BorderLinePosition)position;
-(NSArray*)addBorderLineAtPosition:(BorderLinePosition)position
						ofMagnitude:(CGFloat)magn
						   andColor:(UIColor*)color
						  andOffset:(CGFloat)offset;

-(UIImage*)snapShotImage;
-(UIView*)firstResponderSubview;

@end
