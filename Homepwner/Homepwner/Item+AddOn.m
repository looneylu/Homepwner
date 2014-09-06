//
//  Item+AddOn.m
//  Homepwner
//
//  Created by Luis Carbuccia on 9/6/14.
//  Copyright (c) 2014 Luis Carbuccia. All rights reserved.
//

#import "Item+AddOn.h"

@implementation Item (AddOn)

- (instancetype)initWithItemName:(NSString *)name
                  valueInDollars:(NSNumber *)value
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
        self.valueInDollars = value;
        // set date created to current date and tiem
        self.dateCreated = [[NSDate alloc] init];
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
    return [NSString stringWithFormat:@"%@ (%@): Worth $ %@", self.name, self.serialNumber, self.valueInDollars];
}


@end
