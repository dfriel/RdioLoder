//
// RdioLoderAppDelegate.m
// RdioLoder
//
// Created by Dustin Friel on 11-12-16.
//

#import "RdioLoderAppDelegate.h"

@implementation RdioLoderAppDelegate

@synthesize window = _window;
@synthesize rdio;

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    // Override point for customization after application launch.  
    rdio = [[Rdio alloc] initWithConsumerKey:CONSUMER_KEY andSecret:CONSUMER_SECRET delegate:self]; 
    
    return YES;
}
							
- (void)applicationWillResignActive:(UIApplication *)application
{
    /*
     Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
     Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the gae.
     */
}

- (void)applicationDidEnterBackground:(UIApplication *)application
{
    /*
     Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later. 
     If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
     */
}

- (void)applicationWillEnterForeground:(UIApplication *)application
{
    /*
     Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
     */
}

- (void)applicationDidBecomeActive:(UIApplication *)application
{
    /*
     Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
     */
}

- (void)applicationWillTerminate:(UIApplication *)application
{
    /*
     Called when the application is about to terminate.
     Save data if appropriate.
     See also applicationDidEnterBackground:.
     */
}

/**
 * Called when an authorize request finishes successfully. 
 * @param user A dictionary containing information about the user that was authorized. See http://developer.rdio.com/docs/read/rest/types
 * @param accessToken A token that can be used to automatically reauthorize the current user in subsequent sessions
 */
- (void)rdioDidAuthorizeUser:(NSDictionary *)user withAccessToken:(NSString *)token {  
    NSUserDefaults *standardUserDefaults = [NSUserDefaults standardUserDefaults];
    
	if (standardUserDefaults != nil) {
		[standardUserDefaults setObject:token forKey:@"accessToken"];
		[standardUserDefaults synchronize];
	}
}
/**
 * Called if authorization cannot be completed due to network or server problems.
 * The user will be notified from the login view before this method is called.
 * @param error A message describing what went wrong.
 */
- (void)rdioAuthorizationFailed:(NSString *)error {
    NSUserDefaults *standardUserDefaults = [NSUserDefaults standardUserDefaults];
    
	if (standardUserDefaults != nil) {
		[standardUserDefaults removeObjectForKey:@"accessToken"];
		[standardUserDefaults synchronize];
	}
}

/**
 * Called if the user aborts the authorization process.
 */
- (void)rdioAuthorizationCancelled {
    NSUserDefaults *standardUserDefaults = [NSUserDefaults standardUserDefaults];
    
	if (standardUserDefaults != nil) {
		[standardUserDefaults removeObjectForKey:@"accessToken"];
		[standardUserDefaults synchronize];
	}    
}

/**
 * Called when logout completes.
 */
-(void)rdioDidLogout {
    NSUserDefaults *standardUserDefaults = [NSUserDefaults standardUserDefaults];
    
	if (standardUserDefaults != nil) {
		[standardUserDefaults removeObjectForKey:@"accessToken"];
		[standardUserDefaults synchronize];
	}
}

@end
