//
//  AssetType.h
//  Homepwner
//
//  Created by Luis Carbuccia on 9/5/14.
//  Copyright (c) 2014 Luis Carbuccia. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@class Item;

@interface AssetType : NSManagedObject

@property (nonatomic, retain) NSString * label;
@property (nonatomic, retain) NSSet *assetType;
@end

@interface AssetType (CoreDataGeneratedAccessors)

- (void)addAssetTypeObject:(Item *)value;
- (void)removeAssetTypeObject:(Item *)value;
- (void)addAssetType:(NSSet *)values;
- (void)removeAssetType:(NSSet *)values;

@end
