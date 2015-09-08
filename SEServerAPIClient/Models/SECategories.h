//
//  LALeftMenuItem.h
//  SEServerAPIClient
//
//  Created by Sergey Evseev on 14/08/15.
//  Copyright (c) 2015 Sergey Evseev. All rights reserved.
//

#import "MTLModel.h"
#import "Mantle.h"


@interface SECategories : MTLModel <MTLJSONSerializing>

// Mapped values
@property (nonatomic, assign) int categoryId;
@property (nonatomic, retain) NSString *name;
@property (nonatomic, retain) NSString *key;
@property (nonatomic, retain) NSMutableArray *children;


@end
