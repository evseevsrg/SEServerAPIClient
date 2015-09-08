//
//  LALeftMenuItem.m
//  SEServerAPIClient
//
//  Created by Sergey Evseev on 14/08/15.
//  Copyright (c) 2015 Sergey Evseev. All rights reserved.
//

#import "SECategories.h"

@implementation SECategories

+ (NSDictionary *)JSONKeyPathsByPropertyKey {
    return @{
             @"categoryId": @"category_id",
             @"name": @"name",
             @"key": @"key",
             @"children": @"children",
             };
}

+ (NSValueTransformer *)childrenJSONTransformer {
    return [MTLJSONAdapter arrayTransformerWithModelClass:[SECategories class]];
}

@end
