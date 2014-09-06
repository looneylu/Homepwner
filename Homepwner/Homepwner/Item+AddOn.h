//
//  Item+AddOn.h
//  Homepwner
//
//  Created by Luis Carbuccia on 9/6/14.
//  Copyright (c) 2014 Luis Carbuccia. All rights reserved.
//

#import "Item.h"

@interface Item (AddOn)

- (NSString *) description;
- (instancetype) initWithItemName:(NSString *)name
                   valueInDollars:(NSNumber *) value
                     serialNumber:(NSString *)sNumber;

@end
