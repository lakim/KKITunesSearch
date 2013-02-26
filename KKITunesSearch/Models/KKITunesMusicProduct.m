//
//  KKITunesMusicProduct.m
//  KKITunesSearch
//
//  Created by Louis-Alban KIM on 22/02/13.
//  Copyright (c) 2013 Kimkode. All rights reserved.
//

#import "KKITunesMusicProduct.h"

@implementation KKITunesMusicProduct

- (KKITunesProductSection)sectionFromResult:(NSDictionary *)result {
    
    if ([result[@"wrapperType"] isEqual:@"artist"]) {
        return KKITunesMusicSectionArtist;
    }
    
    if ([result[@"wrapperType"] isEqual:@"collection"]) {
        return KKITunesMusicSectionAlbum;
    }
    
    if ([result[@"wrapperType"] isEqual:@"track"]) {
        return KKITunesMusicSectionTrack;
    }
    
    NSLog(@"%@: Section not found for music product:", NSStringFromSelector(_cmd));
    NSLog(@"%@", result);
    return KKITunesProductSectionNone;
}

- (id)initWithResult:(NSDictionary *)result {
    
    self = [super initWithResult:result];
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

@end
