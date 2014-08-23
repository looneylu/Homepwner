//
//  ItemStore.m
//  Homepwner
//
//  Created by Luis Carbuccia on 8/23/14.
//  Copyright (c) 2014 Luis Carbuccia. All rights reserved.
//

#import "ItemStore.h"
#import "Item.h"

@interface ItemStore ()

@property (nonatomic, strong) NSMutableArray *privateItems;

@end

@implementation ItemStore

#pragma mark - Initializer

+ (instancetype)sharedStore
{
    static ItemStore *sharedStore = nil;
    
    // does a sharedStore need to be created?
    if (!sharedStore)
        sharedStore = [[self alloc] initPrivate];
    
    return sharedStore;
}

// if someone else calls [[ItemStore alloc] init], let that person know it's not possilble
- (instancetype) init
{
    @throw [NSException exceptionWithName: @"Singleton"
                                   reason: @"Use +[ItemStore sharedStore]"
                                 userInfo: nil];
    
    return nil;

}

// initializer
- (instancetype) initPrivate
{
    self = [super init];
    
    return self;
}

#pragma mark - Lazy Instantiation

// self.allItems is a read only property.
// in order to set self.Items, self.privateItems is a private property that will be used to do so
- (NSMutableArray *) privateItems
{
    if (!_privateItems)
        _privateItems = [[NSMutableArray alloc] init];
    
    return _privateItems;
}

- (NSArray *)allItems
{
    // set self.allItems to self.privateItems
    return self.privateItems;
}

#pragma mark - Methods

- (Item *) createItem
{
    Item *item = [Item randomItem];
    
    // add item to privateItems array
    [self.privateItems addObject:item];
    
    return item; 
}

@end
