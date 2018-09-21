//
//  AerservBidder.h
//
//  Created by Ankit Pandey on 18/06/18.
//

#import <Foundation/Foundation.h>
#import "MPInterstitialAdController.h"
#import "MPAdView.h"
#import "AerServBidListener.h"
#import <AerServSDK/AerServSDK.h>

@interface AerServBidder : NSObject

+ (NSMutableDictionary*) getAerservBiddingInfo;
+ (AerServBidder*) getSharedBidder;
- (void) updateBidPriceForInterstitial:(NSString*)placement mopubInterstitial:(MPInterstitialAdController*)mpInterstitialAdController aerservBidListener:(id)aerservBidListener;
- (void) updateBidPriceForBanner:(NSString*)placement mopubBanner:(MPAdView*)adView aerservBidListener:(id)aerservBidListener;
- (void) updateBidPriceForRewarded:(NSString*)placement aerservBidListener:(id)aerservBidListener;

@end
