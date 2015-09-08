//
//  SEServerAPIRequest.h
//  SEServerAPIClient
//
//  Created by Sergey Evseev on 19/05/15.
//  Copyright (c) 2015 Sergey Evseev. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface SEServerAPIRequest : NSObject

@property (nonatomic, retain) NSString *scheme;
@property (nonatomic, retain) NSString *method;
@property (nonatomic, retain) NSMutableURLRequest *request;

- (instancetype)initGetRequestWithURLString:(NSString *)urlString parameters:(NSDictionary *)parameters andMappingScheme:(NSString *)scheme;
- (instancetype)initPostRequestWithURLString:(NSString *)urlString parameters:(NSDictionary *)parameters andModelName:(NSString *)scheme;

- (void)setServerAPIToken:(NSString *)serverAPIToken;

@end
