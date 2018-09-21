//
//  AerServBidObject.h
//
//  Created by Ankit Pandey on 27/06/18.
//

#import <Foundation/Foundation.h>
#import "MPInterstitialAdController.h"
#import "MPAdView.h"
#import "AerServBidListener.h"
#import <AerServSDK/AerServSDK.h>

@interface AerServBidObject : NSObject <ASInterstitialViewControllerDelegate,ASAdViewDelegate>

@property(nonatomic,strong) ASInterstitialViewController* asInterstitial;
@property(nonatomic,strong) MPInterstitialAdController* mpInterstitialAdController;
@property(nonatomic,strong) id<AerServBidListenerDelegate> aerservBidListener;
@property(nonatomic,strong) NSString* placement;
@property(nonatomic,strong) MPAdView *mpAdView;
@property(nonatomic,strong) ASAdView* asBanner;

- (id) initBidObjectForPlacement:(NSString*)placement asInterstitial:(ASInterstitialViewController*)asInterstitial mopubInterstitial:(MPInterstitialAdController*)mpInterstitialAdController aerservBidListener:(id)aerservBidListener;
- (id) initBidObjectForPlacement:(NSString*)placement asBanner:(ASAdView*)asBanner mopubBanner:(MPAdView*)adView aerservBidListener:(id)aerservBidListener;
- (id) initBidObjectForPlacement:(NSString*)placement asRewardedInterstitial:(ASInterstitialViewController*)asRewardedInterstitial aerservBidListener:(id)aerservBidListener;

@end
