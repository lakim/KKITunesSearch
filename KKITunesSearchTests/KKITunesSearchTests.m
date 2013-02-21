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
        
        [[KKITunesSearch sharedClient] search:@"Tactilize"
                                     withType:KKITunesSearchTypeApps
                                      success:^(NSUInteger count, NSArray *results) {
            STAssertTrue(count > 0, @"Count should not be zero");
            STAssertTrue(results.count > 0, @"Results array should contain objects");
            NSUInteger index = [results indexOfObjectPassingTest:^BOOL(id obj, NSUInteger idx, BOOL *stop) {
                return [obj[@"trackName"] isEqual:@"Tactilize"];
            }];
            if (index == NSNotFound) {
                STFail(@"Couldn't find Tactilize app");
            } else {
                NSDictionary *tactilizeApp = results[index];
                STAssertTrue([tactilizeApp isKindOfClass:[NSDictionary class]], @"Result should be a dictionary");
            }
            [self blockTestCompleted];
        } failure:^(NSError *error) {
            STFail(@"Couldn't search apps");
            [self blockTestCompleted];
        }];
    }];
}

- (void)testSearchMusic {
    
    [self runTestWithBlock:^{
        
        [[KKITunesSearch sharedClient] search:@"Let It Be"
                                     withType:KKITunesSearchTypeMusic
                                      success:^(NSUInteger count, NSArray *results) {
            STAssertTrue(count > 0, @"Count should not be zero");
            STAssertTrue(results.count > 0, @"Results array should contain objects");
            NSDictionary *result = results[0];
            STAssertTrue([result isKindOfClass:[NSDictionary class]], @"Result should be a dictionary");
            [self blockTestCompleted];
        } failure:^(NSError *error) {
            STFail(@"Couldn't search music");
            [self blockTestCompleted];
        }];
    }];
}

@end
