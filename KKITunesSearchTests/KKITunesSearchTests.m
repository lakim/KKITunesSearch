//
//  KKITunesSearchTests.m
//  KKITunesSearchTests
//
//  Created by Louis-Alban KIM on 14/02/13.
//  Copyright (c) 2013 Kimkode. All rights reserved.
//

#import "KKITunesSearchTests.h"
#import "KKITunesSearch.h"
#import "SenTest+Async.h"

@implementation KKITunesSearchTests

- (void)testSearchApps {
    
    [self runTestWithBlock:^{
        
        [[KKITunesSearch sharedClient] searchApps:@"Tactilize" success:^(NSUInteger count, NSArray *results) {
            STAssertTrue(count > 0, @"Count should not be zero");
            STAssertTrue(results.count > 0, @"Results array should contain objects");
            STAssertTrue([results[0] isKindOfClass:[NSDictionary class]], @"Results should be a dictionary");
            [self blockTestCompleted];
        } failure:^(NSError *error) {
            STFail(@"Couldn't search apps");
            [self blockTestCompleted];
        }];
    }];
}

@end
