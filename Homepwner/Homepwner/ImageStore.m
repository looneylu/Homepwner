//
//  ImageStore.m
//  Homepwner
//
//  Created by Luis Carbuccia on 8/23/14.
//  Copyright (c) 2014 Luis Carbuccia. All rights reserved.
//

#import "ImageStore.h"

@interface ImageStore ()

@property (nonatomic, strong) NSMutableDictionary *dictionary;

@end

@implementation ImageStore

#pragma mark - Initializers

+(instancetype)sharedStore
{
    static ImageStore *sharedStore = nil;
    
    if (!sharedStore)
    {
        sharedStore = [[self alloc] initPrivate];
    }
    return sharedStore;
}


// no one should call init
-(instancetype)init
{
    @throw [NSException exceptionWithName:@"Singleton"
                                   reason:@"Use +[ImageStore sharedstore]"
                                 userInfo:nil];
    return nil;
}

// designated initializer
- (instancetype)initPrivate
{
    self = [super init];
    
    if (self)
        _dictionary = [[NSMutableDictionary alloc] init];
    return self;
}

- (void)setImage:(UIImage *)image forKey:(NSString *)key
{
//    [self.dictionary setObject:image forKey:key];
    self.dictionary[key] = image;
}

- (UIImage *)imageForKey:(NSString *)key
{
    return self.dictionary[key];
}

- (void)deleteImageForKey:(NSString *)key
{
    if (!key)
        return;
    
    [self.dictionary removeObjectForKey:key]; 
}
@end
