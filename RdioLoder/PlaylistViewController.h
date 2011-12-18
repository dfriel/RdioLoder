//
//  RdioLoderFirstViewController.h
//  RdioLoder
//
//  Created by Dustin Friel on 11-12-16.
//  Copyright (c) 2011 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <MediaPlayer/MediaPlayer.h>
#import "SongViewController.h"

@interface PlaylistViewController : UIViewController <UITableViewDelegate,UITableViewDataSource> 

@property(nonatomic, retain) NSArray *playlists;

@end
