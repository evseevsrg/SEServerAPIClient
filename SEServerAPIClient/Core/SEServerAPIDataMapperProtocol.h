//
//  SEServerAPIDataMapperProtocol.h
//  SEServerAPIClient
//
//  Created by Sergey Evseev on 19/05/15.
//  Copyright (c) 2015 Sergey Evseev. All rights reserved.
//

@protocol SEServerAPIDataMapperProtocol <NSObject>

- (void)parseJSON:(id)jsonString withMappingScheme:(NSString *)scheme
          success:(void(^)(id result))success
          failure:(void(^)(NSError *error))failure;

@end
