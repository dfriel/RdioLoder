//
//  RdioLoderAppDelegate.h
//  RdioLoder
//
//  Created by Dustin Friel on 11-12-16.
//  Copyright (c) 2011 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <Rdio/Rdio.h>
#import "ConsumerCredentials.h"

@interface RdioLoderAppDelegate : UIResponder <UIApplicationDelegate, RdioDelegate> 

@property (strong, nonatomic) UIWindow *window;
@property(nonatomic, retain) Rdio *rdio;

@end
