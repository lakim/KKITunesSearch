//
//  KKITunesSearchTests.m
//  KKITunesSearchTests
//
//  Created by Louis-Alban KIM on 14/02/13.
//  Copyright (c) 2013 Kimkode. All rights reserved.
//

#import "KKITunesSearchTests.h"
#import "KKITunesSearch.h"
#import "KKITunesProducts.h"
#import "SenTest+Async.h"

@implementation KKITunesSearchTests

- (void)testSearchApps {
    
    [self runTestWithBlock:^{
        
        [[KKITunesSearch sharedClient] search:@"Tactilize"
                                     withType:KKITunesProductTypeApps
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
                                     withType:KKITunesProductTypeMusic
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

- (void)testSearchMovies {
    
    [self runTestWithBlock:^{
        
        [[KKITunesSearch sharedClient] search:@"Dexter"
                                     withType:KKITunesProductTypeMovies
                                      success:^(NSUInteger count, NSArray *results) {
                                          STAssertTrue(count > 0, @"Count should not be zero");
                                          STAssertTrue(results.count > 0, @"Results array should contain objects");
                                          NSDictionary *result = results[0];
                                          STAssertTrue([result isKindOfClass:[NSDictionary class]], @"Result should be a dictionary");
                                          [self blockTestCompleted];
                                      } failure:^(NSError *error) {
                                          STFail(@"Couldn't search movies");
                                          [self blockTestCompleted];
                                      }];
    }];
}

- (void)testAppProduct {
    
    KKITunesProduct *product = [[KKITunesAppProduct alloc] init];
    product.section = KKITunesAppsSectionIPad;
    STAssertTrue(product.store == KKITunesStoreApp, @"Store should be App Store");
    product.section = KKITunesAppsSectionIPhone;
    STAssertTrue(product.store == KKITunesStoreApp, @"Store should be App Store");
    product.section = KKITunesAppsSectionUniversal;
    STAssertTrue(product.store == KKITunesStoreApp, @"Store should be App Store");
    product.section = KKITunesAppsSectionMacOS;
    STAssertTrue(product.store == KKITunesStoreMacApp, @"Store should be Mac App Store");
    
    product = [[KKITunesMusicProduct alloc] init];
    product.section = KKITunesMusicSectionArtist;
    STAssertTrue(product.store == KKITunesStoreITunes, @"Store should be iTunes");
    product.section = KKITunesMusicSectionAlbum;
    STAssertTrue(product.store == KKITunesStoreITunes, @"Store should be iTunes");
    product.section = KKITunesMusicSectionTrack;
    STAssertTrue(product.store == KKITunesStoreITunes, @"Store should be iTunes");
    
    product = [[KKITunesMovieProduct alloc] init];
    product.section = KKITunesMoviesSectionMovies;
    STAssertTrue(product.store == KKITunesStoreITunes, @"Store should be iTunes");
    product.section = KKITunesMoviesSectionTVSeasons;
    STAssertTrue(product.store == KKITunesStoreITunes, @"Store should be iTunes");
    product.section = KKITunesMoviesSectionTVEpisodes;
    STAssertTrue(product.store == KKITunesStoreITunes, @"Store should be iTunes");

    product = [[KKITunesBookProduct alloc] init];
    product.section = KKITunesBooksSectionAuthor;
    STAssertTrue(product.store == KKITunesStoreIBook, @"Store should be iBookstore");
    product.section = KKITunesBooksSectionIBooks;
    STAssertTrue(product.store == KKITunesStoreIBook, @"Store should be iBookstore");
    product.section = KKITunesBooksSectionAudioBooks;
    STAssertTrue(product.store == KKITunesStoreITunes, @"Store should be iTunes");
}

@end
