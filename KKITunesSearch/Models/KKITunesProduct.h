//
//  KKITunesProduct.h
//  KKITunesSearch
//
//  Created by Louis-Alban KIM on 21/02/13.
//  Copyright (c) 2013 Kimkode. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef NSInteger KKITunesProductSection;

extern NSInteger const KKITunesProductSectionNone;

typedef enum {
    KKITunesAppsSectionIPad = 0,
    KKITunesAppsSectionIPhone = 1,
    KKITunesAppsSectionUniversal = 2,
    KKITunesAppsSectionMacOS = 3,
    KKITunesAppsSectionCount = 4
} KKITunesAppsSection;

typedef enum {
    KKITunesMusicSectionArtist = 0,
    KKITunesMusicSectionAlbum = 1,
    KKITunesMusicSectionTrack = 2,
    KKITunesMusicSectionCount = 3
} KKITunesMusicSection;

@interface KKITunesProduct : NSObject

@property (assign, nonatomic) KKITunesProductSection section;
@property (strong, nonatomic) NSString *id;
@property (strong, nonatomic) NSString *title;
@property (strong, nonatomic) NSURL *thumbnailURL;

+ (id)productWithResult:(NSDictionary *)result;
+ (Class)productClassFromResult:(NSDictionary *)result;
- (KKITunesProductSection)sectionFromResult:(NSDictionary *)result;
- (id)initWithResult:(NSDictionary *)result;
- (BOOL)isEqual:(KKITunesProduct *)product;

@end
