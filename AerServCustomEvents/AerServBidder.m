//
//  AerservBidder.m
//
//  Created by Ankit Pandey on 18/06/18.
//

#import "AerServBidder.h"
#import <AerServSDK/AerServSDK.h>
#import "AerServCustomEventUtils.h"
#import "AerServBidObject.h"

@implementation AerServBidder

static NSMutableDictionary* aerservBiddingInfo = nil;
AerServBidObject* aerservBidObject;

#pragma mark Singleton Method for AerservBidder

+ (AerServBidder*) getSharedBidder{
    static AerServBidder *aerservBidder = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        NSLog(@"AerServBidder, getSharedBidder:Initialising the Aerserv Bidder");
        aerservBidder = [self new];
    });
    return aerservBidder;
}

+ (NSMutableDictionary*) getAerservBiddingInfo{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        if(aerservBiddingInfo == nil){
            aerservBiddingInfo = [[NSMutableDictionary alloc] init];
        }
    });
    return aerservBiddingInfo;
}

- (void) updateBidPriceForInterstitial:(NSString*)placement mopubInterstitial:(MPInterstitialAdController*)mpInterstitialAdController aerservBidListener:(id)aerservBidListener{
    @try {
        if(placement != nil && ![placement isEqualToString:@""]){
            ASInterstitialViewController* asInterstitial = [ASInterstitialViewController viewControllerForPlacementID:placement withDelegate:aerservBidObject];
            asInterstitial.isPreload = YES;
            aerservBidObject = [[AerServBidObject alloc] initBidObjectForPlacement:placement asInterstitial:asInterstitial mopubInterstitial:mpInterstitialAdController aerservBidListener:aerservBidListener];
        }
        else {
            NSLog(@"AerServBidder, updateBidPriceForInterstitial:Aerserv placement cannot be null or empty");
        }
    }
    @catch(NSException* e) {
        NSLog(@"AerServBidder, updateBidPriceForInterstitial:AerServ bid interstitial ad failed to load with error: %@", e);
    }
}

- (void) updateBidPriceForBanner:(NSString*)placement mopubBanner:(MPAdView*)adView aerservBidListener:(id)aerservBidListener{
    @try {
        CGSize ASBannerSize = {320, 50};
        if(placement != nil && ![placement isEqualToString:@""]){
            ASAdView* asBanner = [ASAdView viewWithPlacementID:placement andAdSize:ASBannerSize];
            asBanner.bannerRefreshTimeInterval = 0;
            asBanner.sizeAdToFit = YES;
            asBanner.isPreload = true;
            aerservBidObject = [[AerServBidObject alloc] initBidObjectForPlacement:placement asBanner:asBanner mopubBanner:adView aerservBidListener:aerservBidListener];
        }
        else {
            NSLog(@"AerServBidder, updateBidPriceForBanner:Aerserv placement cannot be null or empty");
        }
    }
    @catch(NSException* e) {
        NSLog(@"AerServBidder, updateBidPriceForBanner:AerServ bid banner ad failed to load with error: %@", e);
    }
}

- (void) updateBidPriceForRewarded:(NSString*)placement aerservBidListener:(id)aerservBidListener{
    @try {
        if(placement != nil && ![placement isEqualToString:@""]){
            ASInterstitialViewController* asInterstitial = [ASInterstitialViewController viewControllerForPlacementID:placement withDelegate:aerservBidObject];
            asInterstitial.isPreload = YES;
            aerservBidObject = [[AerServBidObject alloc] initBidObjectForPlacement:placement asRewardedInterstitial:asInterstitial aerservBidListener:aerservBidListener];
        }
        else {
            NSLog(@"AerServBidder, updateBidPriceForRewarded:Aerserv placement cannot be null or empty");
        }
    }
    @catch(NSException* e) {
        NSLog(@"AerServBidder, updateBidPriceForRewarded:AerServ bid rewarded ad failed to load with error: %@", e);
    }
}

@end
