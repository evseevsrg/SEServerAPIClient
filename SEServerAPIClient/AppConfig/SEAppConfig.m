//
//  SEAppConfig.m
//  SEServerAPIClient
//
//  Created by Sergey Evseev on 14/08/15.
//  Copyright (c) 2015 Sergey Evseev. All rights reserved.
//



/* Application configuration manager stub */



#import "SEAppConfig.h"
#import "SEServerAPIConstants.h"

@implementation SEAppConfig


- (instancetype)init {
    if (self = [super init]) {
        [self setObject:@"en" forPropertyName:kConfigCurrentLanguage];
        [self setObject:@"https://API_URL" forPropertyName:kConfigBaseAPIURL];
    }
    return self;
}


- (id)getProperty:(NSString *)propertyName {
    return [[NSUserDefaults standardUserDefaults] objectForKey:propertyName];
}

- (BOOL)setObject:(id)object forPropertyName:(NSString *)propertyName {
    [[NSUserDefaults standardUserDefaults] setObject:object forKey:propertyName];
    [[NSUserDefaults standardUserDefaults] synchronize];
    return YES;
}

@end
