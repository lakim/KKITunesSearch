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
                self.id = result[@"artistId"];
                self.title = result[@"artistName"];
                self.url = [NSURL URLWithString:result[@"artistLinkUrl"]];
                break;
            case KKITunesBooksSectionIBooks:
                break;
            case KKITunesBooksSectionAudioBooks:
                self.id = result[@"collectionId"];
                self.title = result[@"collectionName"];
                self.url = [NSURL URLWithString:result[@"collectionViewUrl"]];
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
