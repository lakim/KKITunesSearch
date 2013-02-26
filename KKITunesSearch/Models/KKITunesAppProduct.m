//
//  KKITunesAppProduct.m
//  KKITunesSearch
//
//  Created by Louis-Alban KIM on 21/02/13.
//  Copyright (c) 2013 Kimkode. All rights reserved.
//

#import "KKITunesAppProduct.h"

@implementation KKITunesAppProduct

- (KKITunesProductSection)sectionFromResult:(NSDictionary *)result {
    
    if ([result[@"kind"] isEqual:@"mac-software"]) {
        
        return KKITunesAppsSectionMacOS;
    }

    if ([result[@"features"] containsObject:@"iosUniversal"]) {
        return KKITunesAppsSectionUniversal;
    }
    
    NSArray *devices = result[@"supportedDevices"];
    
    if ([devices indexOfObjectPassingTest:^BOOL(id obj, NSUInteger idx, BOOL *stop) {
        return [obj rangeOfString:@"iPad"].location != NSNotFound;
    }] != NSNotFound) {
        return KKITunesAppsSectionIPad;
    }
    
    if ([devices indexOfObjectPassingTest:^BOOL(id obj, NSUInteger idx, BOOL *stop) {
        return ([obj rangeOfString:@"iPhone"].location != NSNotFound) || [obj isEqual:@"all"];
    }] != NSNotFound) {
        return KKITunesAppsSectionIPhone;
    }
    
    NSLog(@"%@: Section not found for app product:", NSStringFromSelector(_cmd));
    NSLog(@"%@", result);
    return KKITunesProductSectionNone;
}

@end
