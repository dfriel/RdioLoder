//
//  RdioLoderSecondViewController.m
//  RdioLoder
//
//  Created by Dustin Friel on 11-12-16.
//

#import "AlbumViewController.h"

@implementation AlbumViewController

@synthesize albums;

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Release any cached data, images, etc that aren't in use.
}

#pragma mark - View lifecycle

- (void)viewDidLoad
{
    [super viewDidLoad];

    MPMediaQuery *myAlbumsQuery = [MPMediaQuery albumsQuery];
    self.albums = [myAlbumsQuery collections];    
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
    self.navigationController.navigationBar.hidden = YES;
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
#pragma mark Table View Data Source Methods

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [self.albums count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSString *albumIdentifier = @"AlbumIdentifier";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:albumIdentifier];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:albumIdentifier];
        cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;        
    }
    
    NSUInteger row = [indexPath row];    
    NSString *titleIDKey = [MPMediaItem titlePropertyForGroupingType: MPMediaGroupingAlbum];
    NSString *artistIDKey = [MPMediaItem titlePropertyForGroupingType: MPMediaGroupingArtist];
    cell.textLabel.text = [[[self.albums objectAtIndex:row] representativeItem] valueForProperty: titleIDKey];
    cell.detailTextLabel.text = [[[self.albums objectAtIndex:row] representativeItem] valueForProperty: artistIDKey];
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    SongViewController *songViewController = [self.storyboard instantiateViewControllerWithIdentifier:@"SongViewController"];
    NSUInteger row = [indexPath row];  
    songViewController.songs = [[self.albums objectAtIndex:row] items];
    NSString *titleIDKey = [MPMediaItem titlePropertyForGroupingType: MPMediaGroupingAlbum];
    songViewController.album = [[[self.albums objectAtIndex:row] representativeItem] valueForProperty: titleIDKey];
    [self.navigationController pushViewController:songViewController animated:YES];
}


@end
