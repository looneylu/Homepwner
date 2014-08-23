//
//  ItemsTVC.m
//  Homepwner
//
//  Created by Luis Carbuccia on 8/23/14.
//  Copyright (c) 2014 Luis Carbuccia. All rights reserved.
//

#import "ItemsTVC.h"
#import "ItemStore.h"
#import "Item.h"

@interface ItemsTVC () <UITableViewDataSource, UITableViewDelegate>

@property (strong, nonatomic) IBOutlet UITableView *tableView;
@property (strong, nonatomic) IBOutlet UIBarButtonItem *editButton;

@end

@implementation ItemsTVC


- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.tableView.dataSource = self;
    self.tableView.delegate = self;
}


#pragma mark - TableView DataSource & Delegate Methods

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    // Return the number of sections.
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    // Return the number of rows in the section.
    return [[[ItemStore sharedStore] allItems] count];
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"Cell" forIndexPath:indexPath];
    
    // Configure the cell...
    NSArray *items = [[ItemStore sharedStore] allItems];
    Item *item = [items objectAtIndex:indexPath.row];
    
    cell.textLabel.text = [item description]; 
    
    return cell;
}

- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath
{
    // allow editing of row in table view
    return YES;
}

- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    // if the tableView is asking to delete an object
    if (editingStyle == UITableViewCellEditingStyleDelete)
    {
        // remove item from ItemStore
        NSArray *items = [[ItemStore sharedStore] allItems];
        Item *item = items[indexPath.row];
        [[ItemStore sharedStore] removeItem:item];
        
//        [self.tableView reloadData];
        //remove the last row from array
        [self.tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    }
}

- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)sourceIndexPath toIndexPath:(NSIndexPath *)destinationIndexPath
{
    [[ItemStore sharedStore] moveItemAtIndex:sourceIndexPath.row toIndex:destinationIndexPath.row]; 
}

#pragma mark - IBAction Methods

- (IBAction)editButtonPressed:(UIBarButtonItem *)sender
{
    // if the table view is in edit mode, turn off edit mode and relabel button
    if (self.tableView.editing)
    {
        self.tableView.editing = NO;
        self.editButton.title = @"Edit";
    }
    // if the table view isn't in edit mode, turn on edit mode and relabel button
    else
    {
        self.tableView.editing = YES;
        self.editButton.title = @"Done";
    }
}

- (IBAction)addButtonPressed:(UIBarButtonItem *)sender
{
    // create a new Item and add it to the store
    [[ItemStore sharedStore] createItem];
    [self.tableView reloadData];
}

@end
