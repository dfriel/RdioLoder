//
// PlaylistViewControllerTest.m
// RdioLoder
//
// Created by Dustin Friel on 12-04-08.
// Copyright (c) 2012 1421923 Alberta Ltd.
//

#import "PlaylistViewControllerTest.h"
#import <OCMock/OCMock.h>

@implementation PlaylistViewControllerTest

- (void)setUp
{
    [super setUp];
}

- (void)tearDown
{
    [super tearDown];
}

- (void)testExample
{
    id controller = [OCMockObject mockForClass:[PlaylistViewController class]];
    [[[controller stub] andReturn:[NSArray arrayWithObject:@"foo"]] playlists];   
    
    STAssertEquals((NSUInteger)1, [[controller playlists] count], @"The view controller should have a playlist with one item.");
}

@end
