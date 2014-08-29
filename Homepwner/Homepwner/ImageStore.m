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
    
//    if (!sharedStore)
//    {
//        sharedStore = [[self alloc] initPrivate];
//    }

    // multi-thread safe singleton
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{ sharedStore = [[self alloc] initPrivate];});
    
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

    // create a full path for image
    NSString *imagePath = [self imagePathForKey:key];
    
    // turn image into jpeg data
    NSData *data = UIImageJPEGRepresentation(image, .8);
    
    //write image to full path
    [data writeToFile:imagePath atomically:YES];
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
    
    // when an image is deleted from store, it is also deleted from file system
    NSString *imagePath = [self imagePathForKey:key];
    [[NSFileManager defaultManager] removeItemAtPath:imagePath error:nil]; 
}

#pragma mark - Archiving

- (NSString *)imagePathForKey:(NSString *)key
{
    NSArray *documentDirectories = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *documentDirectory = [documentDirectories firstObject];
    
    return [documentDirectory stringByAppendingString:key];
}

@end
