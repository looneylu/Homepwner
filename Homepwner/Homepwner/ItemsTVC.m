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

@end

@implementation ItemsTVC


- (void)viewDidLoad
{
    [super viewDidLoad];
    
    if (self)
        for (int i = 0 ; i < 5 ; i++)
        {
            [[ItemStore sharedStore] createItem]; 
        }
    
    self.tableView.dataSource = self;
    self.tableView.delegate = self;
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


@end
