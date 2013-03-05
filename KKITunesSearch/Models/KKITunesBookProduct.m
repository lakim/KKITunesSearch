//
//  KKITunesBookProduct.m
//  KKITunesSearch
//
//  Created by Louis-Alban KIM on 27/02/13.
//  Copyright (c) 2013 Kimkode. All rights reserved.
//

#import "KKITunesBookProduct.h"

@implementation KKITunesBookProduct

+ (KKITunesProductSection)sectionFromResult:(NSDictionary *)result {
    
    if ([result[@"wrapperType"] isEqual:@"artist"]) {
        return KKITunesBooksSectionAuthor;
    }
    
    if ([result[@"kind"] isEqual:@"ebook"]) {
        return KKITunesBooksSectionIBooks;
    }
    
    if ([result[@"wrapperType"] isEqual:@"audiobook"]) {
        return KKITunesBooksSectionAudioBooks;
    }
    
    return KKITunesProductSectionNone;
}

- (id)initWithResult:(NSDictionary *)result section:(KKITunesProductSection)section {
    
    self = [super initWithResult:result section:section];
    if (self) {
        
        switch (self.section) {
            case KKITunesBooksSectionAuthor:
                self.title = result[@"artistName"];
                break;
            case KKITunesBooksSectionIBooks:
                self.title = result[@"trackName"];
                break;
            case KKITunesBooksSectionAudioBooks:
                self.title = result[@"collectionName"];
                break;
            default:;
        }
    }
    return self;
}

- (KKITunesStore)store {
    
    if (self.section == KKITunesBooksSectionAudioBooks) {
        return KKITunesStoreITunes;
    }
    return KKITunesStoreIBook;
}

@end
