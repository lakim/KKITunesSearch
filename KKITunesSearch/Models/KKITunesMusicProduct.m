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
                self.id = result[@"artistId"];
                self.title = result[@"artistName"];
                self.url = [NSURL URLWithString:result[@"artistLinkUrl"]];
                break;
            case KKITunesMusicSectionAlbum:
                self.id = result[@"collectionId"];
                self.title = result[@"collectionName"];
                self.url = [NSURL URLWithString:result[@"collectionViewUrl"]];
                break;
            case KKITunesMusicSectionTrack:
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
