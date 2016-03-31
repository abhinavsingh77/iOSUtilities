//
//  UINavigationController+LSTHelper.h
//
//  Created by Abhinav Singh on 9/2/15.
//

@import UIKit;

@interface UINavigationController (LSTHelper)

-(void)applyTransparentStyle;
-(void)applyOpaqueStyle;
-(void)removeShadowImage;

-(void)addModalButton;

-(NSArray*)allControllersUpTo:(UIViewController*)controller;
-(NSArray*)allControllersUptoControllerOfClass:(NSString*)classString;

-(void)dismissModalClicked:(UIBarButtonItem*)item;
-(UIViewController*)rootViewController;

@end
