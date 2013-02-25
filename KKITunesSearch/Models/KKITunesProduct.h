//
//  KKITunesProduct.h
//  KKITunesSearch
//
//  Created by Louis-Alban KIM on 21/02/13.
//  Copyright (c) 2013 Kimkode. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef NSInteger KKITunesProductSection;

typedef enum {
    KKITunesAppsSectionIPad = 0,
    KKITunesAppsSectionIPhone = 1,
    KKITunesAppsSectionMacOS = 2,
    KKITunesAppsSectionCount = 3,
} KKITunesAppsSection;

typedef enum {
    KKITunesMusicSectionArtist = 0,
    KKITunesMusicSectionAlbum = 1,
    KKITunesMusicSectionTrack = 2,
    KKITunesMusicSectionCount = 3,
} KKITunesMusicSection;

@interface KKITunesProduct : NSObject

@property (assign, nonatomic) NSSet *sections;
@property (strong, nonatomic) NSString *id;
@property (strong, nonatomic) NSString *title;
@property (strong, nonatomic) NSURL *thumbnailURL;

+ (id)productWithResult:(NSDictionary *)result;
+ (Class)productClassFromResult:(NSDictionary *)result;
- (NSSet *)sectionsFromResult:(NSDictionary *)result;
- (id)initWithResult:(NSDictionary *)result;

@end
