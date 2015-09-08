//
//  SEAppConfigProtocol.h
//  SEServerAPIClient
//
//  Created by Sergey Evseev on 27/08/15.
//  Copyright (c) 2015 Sergey Evseev. All rights reserved.
//

@protocol SEAppConfigProtocol <NSObject>

- (id)getProperty:(NSString *)propertyName;
- (BOOL)setObject:(id)object forPropertyName:(NSString *)propertyName;

@end