//
//  UIView+LSTLayout.h
//  iOSUtility
//
//  Created by Abhinav Singh on 3/31/16.
//  Copyright © 2016 No Name. All rights reserved.
//

@import UIKit;

@interface UIView (LSTLayout)

-(void)checkFoAmbiguousLayout;
-(void)centerVerticallySubViews:(NSArray*)subs withPading:(CGFloat)pading;

#pragma mark - Frames

-(CGFloat)maxX;
-(CGFloat)maxY;

-(CGSize)size;
-(void)setSize:(CGSize)size;

-(CGFloat)originX;
-(void)setOriginX:(CGFloat)xAxics;

-(CGFloat)originY;
-(void)setOriginY:(CGFloat)yAxics;

-(CGFloat)height;
-(void)setHeight:(CGFloat)height;

-(CGFloat)width;
-(void)setWidth:(CGFloat)width;

-(CGPoint)centerPoint;

@end
