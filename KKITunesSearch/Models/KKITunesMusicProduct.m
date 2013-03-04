//
//  KKITunesMusicProduct.m
//  KKITunesSearch
//
//  Created by Louis-Alban KIM on 22/02/13.
//  Copyright (c) 2013 Kimkode. All rights reserved.
//

#import "KKITunesMusicProduct.h"

@implementation KKITunesMusicProduct

+ (KKITunesProductSection)sectionFromResult:(NSDictionary *)result {
    
    if ([result[@"wrapperType"] isEqual:@"artist"] && [result[@"artistType"] isEqual:@"Artist"]) {
        return KKITunesMusicSectionArtist;
    }
    
    if ([result[@"wrapperType"] isEqual:@"collection"] && ([result[@"collectionType"] isEqual:@"Album"] || [result[@"collectionType"] isEqual:@"Compilation"])) {
        return KKITunesMusicSectionAlbum;
    }
    
    if ([result[@"wrapperType"] isEqual:@"track"] && [result[@"kind"] isEqual:@"song"]) {
        return KKITunesMusicSectionTrack;
    }
    
    return KKITunesProductSectionNone;
}

- (id)initWithResult:(NSDictionary *)result section:(KKITunesProductSection)section {
    
    self = [super initWithResult:result section:section];
    if (self) {
        
        switch (self.section) {
            case KKITunesMusicSectionArtist:
                self.title = result[@"artistName"];
                break;
            case KKITunesMusicSectionAlbum:
                self.title = result[@"collectionName"];
                break;
            case KKITunesMusicSectionTrack:
                self.title = result[@"trackName"];
                break;
            default:;
        }
    }
    return self;
}

- (KKITunesStore)store {
    
    return KKITunesStoreITunes;
}

@end
