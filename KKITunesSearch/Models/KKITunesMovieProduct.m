//
//  KKITunesMovieProduct.m
//  KKITunesSearch
//
//  Created by Louis-Alban KIM on 26/02/13.
//  Copyright (c) 2013 Kimkode. All rights reserved.
//

#import "KKITunesMovieProduct.h"

@implementation KKITunesMovieProduct

+ (KKITunesProductSection)sectionFromResult:(NSDictionary *)result {
    
    if ([result[@"kind"] isEqual:@"feature-movie"]) {
        return KKITunesMoviesSectionMovies;
    }

    if ([result[@"wrapperType"] isEqual:@"collection"] && [result[@"collectionType"] isEqual:@"TV Season"]) {
        return KKITunesMoviesSectionTVSeasons;
    }
    
    if ([result[@"kind"] isEqual:@"tv-episode"]) {
        return KKITunesMoviesSectionTVEpisodes;
    }
    
    return KKITunesProductSectionNone;
}

- (id)initWithResult:(NSDictionary *)result section:(KKITunesProductSection)section {
    
    self = [super initWithResult:result section:section];
    if (self) {
        
        switch (self.section) {
            case KKITunesMoviesSectionMovies:
                self.title = result[@"trackName"];
                break;
            case KKITunesMoviesSectionTVSeasons:
                self.title = result[@"collectionName"];
                break;
            case KKITunesMoviesSectionTVEpisodes:
                self.title = [NSString stringWithFormat:@"%@ - %@", result[@"trackNumber"], result[@"trackName"]];
                break;
            default:;
        }
    }
    return self;
}

@end
