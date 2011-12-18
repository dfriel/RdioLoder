//
//  SongViewController.m
//  RdioLoder
//
//  Created by Dustin Friel on 11-12-17.
//  Copyright (c) 2011 __MyCompanyName__. All rights reserved.
//

#import "SongViewController.h"

@implementation SongViewController

@synthesize songs;
@synthesize rdio;
@synthesize accessToken;

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Release any cached data, images, etc that aren't in use.
}

#pragma mark - View lifecycle

- (void)viewDidLoad
{
    [super viewDidLoad];
    rdio = [[Rdio alloc] initWithConsumerKey:CONSUMER_KEY andSecret:CONSUMER_SECRET delegate:self]; 
    
    UIBarButtonItem *btnUpload = [[UIBarButtonItem alloc] 
                                initWithTitle:@"Uplod"                                            
                                style:UIBarButtonItemStyleBordered 
                                target:self 
                                action:@selector(upload:)];
    self.navigationItem.rightBarButtonItem = btnUpload;
}

- (void)viewDidUnload
{
    [super viewDidUnload];
    [rdio logout];
    self.accessToken = nil;
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    self.navigationController.navigationBar.hidden = NO;    
}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
}

- (void)viewWillDisappear:(BOOL)animated
{
	[super viewWillDisappear:animated];
}

- (void)viewDidDisappear:(BOOL)animated
{
	[super viewDidDisappear:animated];
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    // Return YES for supported orientations
    return (interfaceOrientation != UIInterfaceOrientationPortraitUpsideDown);
}

#pragma mark -
#pragma mark Rdio Delegate Methods

- (IBAction) upload:(id) button {
    if (accessToken == nil) {
        [rdio authorizeFromController:self];
    } else {
        [rdio authorizeUsingAccessToken:self.accessToken fromController:self];
    }
}

/**
 * Called when an authorize request finishes successfully. 
 * @param user A dictionary containing information about the user that was authorized. See http://developer.rdio.com/docs/read/rest/types
 * @param accessToken A token that can be used to automatically reauthorize the current user in subsequent sessions
 */
- (void)rdioDidAuthorizeUser:(NSDictionary *)user withAccessToken:(NSString *)token {
    self.accessToken = token;
}

/**
 * Called if authorization cannot be completed due to network or server problems.
 * The user will be notified from the login view before this method is called.
 * @param error A message describing what went wrong.
 */
- (void)rdioAuthorizationFailed:(NSString *)error {
    self.accessToken = nil;
}

/**
 * Called if the user aborts the authorization process.
 */
- (void)rdioAuthorizationCancelled {
    self.accessToken = nil;
}

/**
 * Called when logout completes.
 */
-(void)rdioDidLogout {
    self.accessToken = nil;
}


#pragma mark -
#pragma mark Table View Data Source Methods

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [self.songs count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSString *songIdentifier = @"SongIdentifier";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:songIdentifier];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:songIdentifier];
    }
    
    NSUInteger row = [indexPath row];    
    cell.textLabel.text = [[songs objectAtIndex:row] valueForProperty: MPMediaItemPropertyTitle];
    return cell;
}

@end
