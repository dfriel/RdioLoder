//
//  ResultsViewController.m
//  RdioLoder
//
//  Created by Dustin Friel on 12-02-14.
//

#import "ResultsViewController.h"

@implementation ResultsViewController

@synthesize albums, popoverController;

- (id)initWithStyle:(UITableViewStyle)style
{
    // Override initWithStyle: if you create the controller programmatically and want to perform customization that is not appropriate for viewDidLoad.
    if ((self = [super initWithStyle:style])) {
		self.contentSizeForViewInPopover = CGSizeMake(275, 450);
    }
    return self;
}

- (void)didReceiveMemoryWarning
{
    // Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
    
    // Release any cached data, images, etc that aren't in use.
}

#pragma mark - View lifecycle

- (void)viewDidLoad
{
    [super viewDidLoad];

    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
 
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
    
 	self.tableView.rowHeight = 44.0;
	self.view.backgroundColor = [UIColor clearColor];   
}

- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
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
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    // Return the number of sections.
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    // Return the number of rows in the section.
    return [albums count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"Cell";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
    }
    
    cell.textLabel.textColor = [UIColor whiteColor];
    
    NSDictionary *data = [albums objectAtIndex:[indexPath row]];
    cell.textLabel.text = [data objectForKey:@"name"];
    
    return cell;
}

#pragma mark - Table view delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    RdioLoderAppDelegate *delegate = (RdioLoderAppDelegate *) [[UIApplication sharedApplication] delegate];
    NSUserDefaults *standardUserDefaults = [NSUserDefaults standardUserDefaults];
	
    NSString *accessToken;
	if (standardUserDefaults != nil) {
		accessToken = [standardUserDefaults objectForKey:@"accessToken"];    
    }
    
    [delegate.rdio authorizeUsingAccessToken:accessToken fromController:self];

    NSDictionary *data = [albums objectAtIndex:[indexPath row]];   
    
    NSString *tracks = [[[data objectForKey:@"trackKeys"] valueForKey:@"description"] componentsJoinedByString:@","];
    
    NSMutableDictionary *params = [NSMutableDictionary dictionaryWithObjectsAndKeys:tracks, @"keys", nil];
    
    [delegate.rdio callAPIMethod:@"addToCollection" withParameters:params delegate:self];       
}

/**
 * Our API call has returned successfully.
 * the data parameter can be an NSDictionary, NSArray, or NSData 
 * depending on the call we made.
 *
 * Here we will inspect the parameters property of the returned RDAPIRequest
 * to see what method has returned.
 */
- (void)rdioRequest:(RDAPIRequest *)request didLoadData:(id)data {
    [popoverController dismissPopoverAnimated:YES];
}

- (void)rdioRequest:(RDAPIRequest *)request didFailWithError:(NSError*)error {
    [popoverController dismissPopoverAnimated:YES];
}

@end
