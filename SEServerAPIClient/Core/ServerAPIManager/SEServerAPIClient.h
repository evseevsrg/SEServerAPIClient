//
//  SEServerAPIClient.h
//  SEServerAPIClient
//
//  Created by Sergey Evseev on 19/05/15.
//  Copyright (c) 2015 Sergey Evseev. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "SEServerAPIConstants.h"
#import "SEServerAPIRPCServiceProtocol.h"
#import "SEServerAPIDataMapperProtocol.h"
#import "SEAppConfigProtocol.h"

@interface SEServerAPIClient : NSObject

@property (nonatomic, retain) id <SEServerAPIRPCServiceProtocol> rpcService;
@property (nonatomic, retain) id <SEServerAPIDataMapperProtocol> dataMapper;
@property (nonatomic, retain) id <SEAppConfigProtocol> appConfig;

- (NSNumber *)loadCategoriesWithAllLevels:(BOOL)allLevels success:(void(^)(BOOL success))success failure:(void(^)(NSError *error))failure;

@end
