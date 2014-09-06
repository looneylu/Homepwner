//
//  Item.m
//  Homepwner
//
//  Created by Luis Carbuccia on 8/23/14.
//  Copyright (c) 2014 Luis Carbuccia. All rights reserved.
//

#import "Item.h"

@implementation Item

- (instancetype)initWithItemName:(NSString *)name
                  valueInDollars:(int)value
                    serialNumber:(NSString *)sNumber
{
    // call the superclass' desidnated initializer
    self = [super init];
    
    // did the superclass' designated initializer succed?
    if (self)
    {
        // the instance variable initial value
        self.name = name;
        self.serialNumber = sNumber;
        self.value = value;
        // set date created to current date and tiem
        self.dateOfCreation = [[NSDate alloc] init];
    }
    
    // create an NSUUID object - and get its string representation
    NSUUID *uuid = [[NSUUID alloc] init];
    NSString *key = [uuid UUIDString];
    self.key = key;
    
    return self; 
}

- (NSString *) description
{
    // returns description of item
    return [NSString stringWithFormat:@"%@ (%@): Worth $ %i", self.name, self.serialNumber, self.value];
}

+ (instancetype) randomItem
{
    // create an immutable array of three adjectives
    NSArray *randomAdjectiveList = @[@"Fluffy", @"Rusty", @"Shiny"];
    // create an immutable array of three nouns
    NSArray *randomNounList = @[@"Bear", @"Spork", @"Mac"];
    
    // Get the index of a random adjective/noun from the lists
    NSInteger adjectiveIndex = arc4random() % [randomAdjectiveList count];
    NSInteger nounIndex = arc4random() % [randomNounList count];
    
    NSString *randomName = [NSString stringWithFormat:@"%@ %@", randomAdjectiveList[adjectiveIndex], randomNounList[nounIndex]];
    
    int randomValue = arc4random() % 100;
    NSString *randomSerialNumber = [NSString stringWithFormat:@"%c%c%c%c%c", 'O'+arc4random() % 10, 'A'+arc4random() % 26, 'O'+arc4random() % 10, 'A'+arc4random() % 26, 'O' + arc4random() %10];
    
    Item *newItem = [[self alloc] initWithItemName:randomName
                                    valueInDollars:randomValue
                                      serialNumber:randomSerialNumber];
    return newItem;
}

#pragma mark - Archiving

- (void) encodeWithCoder:(NSCoder *)aCoder
{
    // encode properties into NSCoder object pass into method for archiving purposes
    [aCoder encodeObject:self.name forKey:@"itemName"];
    [aCoder encodeObject:self.serialNumber forKey:@"serialNumber"];
    [aCoder encodeObject:self.dateOfCreation forKey:@"dateCreated"];
    [aCoder encodeObject:self.key forKey:@"itemKey"];
    [aCoder encodeInt:self.value forKey:@"valueInDollars"];
}

- (instancetype) initWithCoder:(NSCoder *)aDecoder
{
    self = [super init];
    
    if (self)
    {
        _name = [aDecoder decodeObjectForKey:@"itemName"];
        _serialNumber = [aDecoder decodeObjectForKey:@"serialNumber"];
        _dateOfCreation = [aDecoder decodeObjectForKey:@"dateCreated"];
        _key = [aDecoder decodeObjectForKey:@"itemKey"];
        
        _value = [aDecoder decodeIntForKey:@"valueInDollars"];
    }
    
    return self; 
}

@end
