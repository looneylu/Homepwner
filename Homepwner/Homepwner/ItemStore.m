//
//  ItemStore.m
//  Homepwner
//
//  Created by Luis Carbuccia on 8/23/14.
//  Copyright (c) 2014 Luis Carbuccia. All rights reserved.
//

#import "ItemStore.h"
#import "Item.h"
#import "ImageStore.h"

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

- (void) addItem:(Item *) item
{
    // add item to privateItems array
    [self.privateItems addObject:item]; 
}

- (void)removeItem:(Item *)item
{
    [self.privateItems removeObjectIdenticalTo:item];
    [[ImageStore sharedStore] deleteImageForKey:item.key]; 
}

- (void) moveItemAtIndex:(NSUInteger)fromIndex  toIndex:(NSUInteger)toIndex
{
    if (fromIndex == toIndex)
        return;
    
    // Get pointer to object being moved in order to re-insert it
    Item *item = self.privateItems[fromIndex];
    
    // Remove item from array
    [self.privateItems removeObjectAtIndex:fromIndex];
    
    // re-insert item into array
    [self.privateItems insertObject:item atIndex:toIndex];
}

@end
