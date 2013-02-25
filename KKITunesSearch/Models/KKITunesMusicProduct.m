//
//  KKITunesMusicProduct.m
//  KKITunesSearch
//
//  Created by Louis-Alban KIM on 22/02/13.
//  Copyright (c) 2013 Kimkode. All rights reserved.
//

#import "KKITunesMusicProduct.h"

@implementation KKITunesMusicProduct

- (NSSet *)sectionsFromResult:(NSDictionary *)result {
    
    NSMutableSet *sections = [NSMutableSet set];
    
    if ([result[@"wrapperType"] isEqual:@"artist"]) {
        [sections addObject:[NSNumber numberWithInteger:KKITunesMusicSectionArtist]];
    } else if ([result[@"wrapperType"] isEqual:@"album"]) {
        [sections addObject:[NSNumber numberWithInteger:KKITunesMusicSectionAlbum]];
    } else if ([result[@"wrapperType"] isEqual:@"track"]) {
        [sections addObject:[NSNumber numberWithInteger:KKITunesMusicSectionTrack]];
    }
    
    return sections;
}

- (id)initWithResult:(NSDictionary *)result {
    
    self = [super initWithResult:result];
    if (self) {
        if ([self.sections containsObject:[NSNumber numberWithInteger:KKITunesMusicSectionArtist]]) {
            self.title = result[@"artistName"];
        } else if ([self.sections containsObject:[NSNumber numberWithInteger:KKITunesMusicSectionAlbum]]) {
            self.title = result[@"collectionName"];
        } else if ([self.sections containsObject:[NSNumber numberWithInteger:KKITunesMusicSectionTrack]]) {
            self.title = result[@"trackName"];
        }
    }
    return self;
}

@end
