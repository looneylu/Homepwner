//
//  ImageTransformerr.m
//  Homepwner
//
//  Created by Luis Carbuccia on 9/4/14.
//  Copyright (c) 2014 Luis Carbuccia. All rights reserved.
//

#import "ImageTransformer.h"

@implementation ImageTransformer

+ (Class) transformedValueClass
{
    return [NSData class];
}

- (id) transformedValue:(id)value
{
    if (!value)
        return nil;
    
    if ([value isKindOfClass:[NSData class]])
        return value;
    
    return UIImagePNGRepresentation(value);
    
}

- (id) reverseTransformedValue:(id)value
{
    return [UIImage imageWithData:value]; 
}

@end

