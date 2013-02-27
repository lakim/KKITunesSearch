//
//  KKITunesBookProduct.m
//  KKITunesSearch
//
//  Created by Louis-Alban KIM on 27/02/13.
//  Copyright (c) 2013 Kimkode. All rights reserved.
//

#import "KKITunesBookProduct.h"

@implementation KKITunesBookProduct

- (KKITunesProductSection)sectionFromResult:(NSDictionary *)result {
    
    if ([result[@"wrapperType"] isEqual:@"artist"]) {
        return KKITunesBooksSectionAuthor;
    }
    
    if ([result[@"kind"] isEqual:@"ebook"]) {
        return KKITunesBooksSectionIBooks;
    }
    
    if ([result[@"wrapperType"] isEqual:@"audiobook"]) {
        return KKITunesBooksSectionAudioBooks;
    }
    
    NSLog(@"%@: Section not found for book product:", NSStringFromSelector(_cmd));
    NSLog(@"%@", result);
    return KKITunesProductSectionNone;
}

- (id)initWithResult:(NSDictionary *)result {
    
    self = [super initWithResult:result];
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

@end
