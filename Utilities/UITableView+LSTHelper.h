//
//  UITableView+LSTHelper.h
//
//  Created by Abhinav Singh on 9/8/15.
//

@import UIKit;

@interface UITableView (LSTHelper)

-(void)applyDefaultStyle;
-(void)registerCellClass:(Class)cellClass;
-(void)registerCellClass:(Class)cellClass withNib:(BOOL)isXib;

@end
