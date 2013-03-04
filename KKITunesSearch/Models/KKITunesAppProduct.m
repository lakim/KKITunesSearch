//
//  KKITunesAppProduct.m
//  KKITunesSearch
//
//  Created by Louis-Alban KIM on 21/02/13.
//  Copyright (c) 2013 Kimkode. All rights reserved.
//

#import "KKITunesAppProduct.h"

@implementation KKITunesAppProduct

+ (KKITunesProductSection)sectionFromResult:(NSDictionary *)result {
    
    if ([result[@"kind"] isEqual:@"mac-software"]) {
        
        return KKITunesAppsSectionMacOS;
    }

    if ([result[@"features"] containsObject:@"iosUniversal"]) {
        return KKITunesAppsSectionUniversal;
    }
    
    if ([result[@"ipadScreenshotUrls"] count] > 0) {
        return KKITunesAppsSectionIPad;
    }
    
    if ([result[@"screenshotUrls"] count] > 0) {
        return KKITunesAppsSectionIPhone;
    }
    
    return KKITunesProductSectionNone;
}

- (KKITunesStore)store {
    
    if (self.section == KKITunesAppsSectionMacOS) {
        return KKITunesStoreMacApp;
    };
    return KKITunesStoreApp;
}

@end
