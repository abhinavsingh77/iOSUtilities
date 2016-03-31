//
//  UITableView+LSTHelper.m
//
//  Created by Abhinav Singh on 9/8/15.
//

#import "UITableView+LSTHelper.h"
#import "UIView+LSTLayout.h"

@implementation UITableView (LSTHelper)

-(void)applyDefaultStyle {
	
	UIView *headerView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, self.width, 0.1)];
	self.tableHeaderView = headerView;
	
	self.tableFooterView = [[UIView alloc] initWithFrame:CGRectZero];
	
	UIView *tableBack = [[UIView alloc] initWithFrame:CGRectZero];
	tableBack.backgroundColor = [UIColor clearColor];
	
	self.backgroundView = tableBack;
	self.backgroundColor = tableBack.backgroundColor;
}

-(void)registerCellClass:(Class)cellClass withNib:(BOOL)isXib{
	
	if (isXib) {
		
		NSString *nibName = NSStringFromClass(cellClass);
		[self registerNib:[UINib nibWithNibName:nibName bundle:nil] forCellReuseIdentifier:nibName];
	}else {
		[self registerClass:cellClass forCellReuseIdentifier:NSStringFromClass(cellClass)];
	}
}

-(void)registerCellClass:(Class)cellClass {
	
	[self registerCellClass:cellClass withNib:YES];
}

@end
