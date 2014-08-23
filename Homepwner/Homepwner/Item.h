//
//  Item.h
//  Homepwner
//
//  Created by Luis Carbuccia on 8/23/14.
//  Copyright (c) 2014 Luis Carbuccia. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Item : NSObject

@property (nonatomic, strong) NSString *name;
@property (nonatomic, strong) NSString *serialNumber;
@property (nonatomic) int value;
@property (nonatomic, strong) NSDate *dateOfCreation;

@end
