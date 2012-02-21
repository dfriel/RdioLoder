//
//  SongViewController.h
//  RdioLoder
//
//  Created by Dustin Friel on 11-12-17.
//  Copyright (c) 2011 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <MediaPlayer/MediaPlayer.h>
#import <Rdio/Rdio.h>
#import "ConsumerCredentials.h"
#import "WEPopoverController.h"
#import "ResultsViewController.h"

@interface SongViewController : UIViewController <UITableViewDelegate, UITableViewDataSource, RdioDelegate, RDAPIRequestDelegate> 
{
    NSMutableArray* albums;
}

@property(nonatomic, retain) NSArray *songs;
@property(nonatomic, retain) NSString *album;
@property(nonatomic, retain) UIBarButtonItem *uploadButton;
@property(nonatomic, retain) Rdio *rdio;
@property(nonatomic, retain) NSString *accessToken;
@property(nonatomic, retain) WEPopoverController *popoverController;

- (IBAction) upload:(id) button;

@end
