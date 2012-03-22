//
// SongViewController.m
// RdioLoder
//
// Created by Dustin Friel on 11-12-17.
//

#import "SongViewController.h"

@implementation SongViewController

@synthesize songs;
@synthesize album;
@synthesize accessToken;
@synthesize popoverController;
@synthesize uploadButton;

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Release any cached data, images, etc that aren't in use.
}

#pragma mark - View lifecycle

- (void)viewDidLoad
{
    [super viewDidLoad];

    NSUserDefaults *standardUserDefaults = [NSUserDefaults standardUserDefaults];
	
	if (standardUserDefaults != nil) {
		self.accessToken = [standardUserDefaults objectForKey:@"accessToken"];    
    }
    
    if (self.accessToken != nil) {
        uploadButton = [[UIBarButtonItem alloc] 
                        initWithTitle:@"Uplod"                                            
                        style:UIBarButtonItemStyleBordered 
                        target:self 
                        action:@selector(upload:)];         
    } else {
        uploadButton = [[UIBarButtonItem alloc] 
                        initWithTitle:@"Login"                                            
                        style:UIBarButtonItemStyleBordered 
                        target:self 
                        action:@selector(login:)];        
    }
    
    self.navigationItem.rightBarButtonItem = uploadButton;
}

- (void)viewDidUnload
{
    [super viewDidUnload];
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

- (IBAction) login:(id) button {
    RdioLoderAppDelegate *delegate = (RdioLoderAppDelegate *) [[UIApplication sharedApplication] delegate];
    [delegate.rdio authorizeFromController:self];
}

- (IBAction) upload:(id) button {
    RdioLoderAppDelegate *delegate = (RdioLoderAppDelegate *) [[UIApplication sharedApplication] delegate];
    
    [delegate.rdio authorizeUsingAccessToken:self.accessToken fromController:self];

    NSMutableDictionary *params = [NSMutableDictionary dictionaryWithObjectsAndKeys:@"albums", @"types", album, @"query", nil];
    
    [delegate.rdio callAPIMethod:@"search" withParameters:params delegate:self];         
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
    NSString *method = [request.parameters objectForKey:@"method"];
    if([method isEqualToString:@"search"]) {
        albums = [[NSMutableArray alloc] initWithArray:[data objectForKey:@"results"]];
                
        if (!self.popoverController) {
            ResultsViewController *resultsViewController = [[ResultsViewController alloc] initWithStyle:UITableViewStylePlain];
            self.popoverController = [[[WEPopoverController class] alloc] initWithContentViewController:resultsViewController];
            
            resultsViewController.albums = albums;
            resultsViewController.popoverController = self.popoverController;            
            self.popoverController.passthroughViews = [NSArray arrayWithObject:self.navigationController.navigationBar];
        }

        [self.popoverController presentPopoverFromBarButtonItem:uploadButton 
                                       permittedArrowDirections:(UIPopoverArrowDirectionUp|UIPopoverArrowDirectionDown) 
                                                       animated:YES];        
    }
}

- (void)rdioRequest:(RDAPIRequest *)request didFailWithError:(NSError*)error {
    
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
