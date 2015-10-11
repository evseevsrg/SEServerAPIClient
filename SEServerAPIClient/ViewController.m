//
//  ViewController.m
//  SEServerAPIClient
//
//  Created by Sergey Evseev on 08/09/15.
//  Copyright (c) 2015 Sergey Evseev. All rights reserved.
//

#import "ViewController.h"
#import "SEServerAPIClient.h"
#import "SEMapperWrapper.h"
#import "SEServerAPIRPCService.h"
#import "SEAppConfig.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    [self performServerAPIRequest];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)performServerAPIRequest {
    [self.serverAPIClient loadCategoriesWithAllLevels:NO success:^(BOOL success) {
        NSLog(@"success");
    } failure:^(NSError *error) {
        NSLog(@"fail");
    }];
}

@end
