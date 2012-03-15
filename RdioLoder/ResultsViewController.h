//
//  ResultsViewController.h
//  RdioLoder
//
//  Created by Dustin Friel on 12-02-14.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "WEPopoverController.h"
#import "RdioLoderAppDelegate.h"

@interface ResultsViewController : UITableViewController <RDAPIRequestDelegate>

@property(nonatomic, retain) NSMutableArray* albums;
@property(nonatomic, retain) WEPopoverController *popoverController;

@end
