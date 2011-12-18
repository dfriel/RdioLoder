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

@interface SongViewController : UIViewController <UITableViewDelegate, UITableViewDataSource, RdioDelegate> 

@property(nonatomic, retain) NSArray *songs;
@property(nonatomic, retain) Rdio *rdio;
@property(nonatomic, retain) NSString *accessToken;

- (IBAction) upload:(id) button;

@end
