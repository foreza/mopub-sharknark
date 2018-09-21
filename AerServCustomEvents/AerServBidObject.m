//
//  AerServBidObject.m
//
//  Created by Ankit Pandey on 27/06/18.
//

#import "AerServBidObject.h"
#import "AerServBidder.h"

@implementation AerServBidObject

Boolean rewardedFlag = false;

- (id) initBidObjectForPlacement:(NSString*)placement asInterstitial:(ASInterstitialViewController*)asInterstitial mopubInterstitial:(MPInterstitialAdController*)mpInterstitialAdController aerservBidListener:(id)aerservBidListener{
    AerServBidObject* aerservBidObject = [self initMembers:placement rewardedFlag:false aerservBidListener:aerservBidListener];
    aerservBidObject.asInterstitial = asInterstitial;
    aerservBidObject.mpInterstitialAdController = mpInterstitialAdController;
    aerservBidObject.asInterstitial.delegate = self;
    NSLog(@"AerServBidObject, initBidObjectForPlacement:Loading Aerserv Interstitial Bid Price");
    [aerservBidObject.asInterstitial loadAd];
    return aerservBidObject;
}

- (id) initBidObjectForPlacement:(NSString*)placement asRewardedInterstitial:(ASInterstitialViewController*)asRewardedInterstitial aerservBidListener:(id)aerservBidListener{
    AerServBidObject* aerservBidObject = [self initMembers:placement rewardedFlag:true aerservBidListener:aerservBidListener];
    aerservBidObject.asInterstitial = asRewardedInterstitial;
    aerservBidObject.asInterstitial.delegate = self;
    NSLog(@"AerServBidObject, initBidObjectForPlacement:Loading Aerserv Rewarded Bid Price");
    [aerservBidObject.asInterstitial loadAd];
    return aerservBidObject;
}

- (id) initBidObjectForPlacement:(NSString*)placement asBanner:(ASAdView*)asBanner mopubBanner:(MPAdView*)adView aerservBidListener:(id)aerservBidListener{
    AerServBidObject* aerservBidObject = [self initMembers:placement rewardedFlag:false aerservBidListener:aerservBidListener];
    aerservBidObject.asBanner = asBanner;
    aerservBidObject.mpAdView = adView;
    aerservBidObject.asBanner.delegate = self;
    NSLog(@"AerServBidObject, initBidObjectForPlacement:Loading Aerserv Banner Bid Price");
    [aerservBidObject.asBanner loadAd];
    return aerservBidObject;
}

- (id) initMembers:(NSString*)placement rewardedFlag:(Boolean)RewardedFlag aerservBidListener:(id)aerservBidListener{
    self = [super init];
    self.placement = placement;
    rewardedFlag = RewardedFlag;
    self.aerservBidListener = aerservBidListener;
    return self;
}

#pragma mark - method to fetch keywords for Aerserv Rewarded Ad

- (NSString*) getKeywordsForRewarded:(NSString*) buyerprice placement:(NSString*) placement{
    double buyerPrice = [buyerprice doubleValue];
    NSString* keywords = @"";
    NSString* aerservPrefix = [NSString stringWithFormat:@"AS_%@:", placement];
    NSString* bidPrice = [self getKeywordForIntervalAndThreshold:buyerPrice interval:@"0.50" lowThreshold:10.00 highThreshold:25.00];
    keywords = [NSString stringWithFormat:@"%@%@", aerservPrefix,bidPrice];
    return keywords;
}

#pragma mark - method to fetch keywords for Aerserv Interstitial Ad

- (void) setKeywordsForInterstitial:(NSString*) buyerprice placement:(NSString*) placement{
    double buyerPrice = [buyerprice doubleValue];
    NSString* aerservPrefix = [NSString stringWithFormat:@"AS_%@:", placement];
    NSString* bidPrice = [self getKeywordForIntervalAndThreshold:buyerPrice interval:@"0.50" lowThreshold:10.00 highThreshold:25.00];
    self.mpInterstitialAdController.keywords = [NSString stringWithFormat:@"%@%@", aerservPrefix,bidPrice];
}

#pragma mark - method to fetch keywords for Aerserv Banner Ad

- (void) setKeywordsForBanner:(NSString*) buyerprice placement:(NSString*) placement{
    double buyerPrice = [buyerprice doubleValue];
    NSString* aerservPrefix = [NSString stringWithFormat:@"AS_%@:", placement];
    NSString* bidPrice = [self getKeywordForIntervalAndThreshold:buyerPrice interval:@"0.25" lowThreshold:5.00 highThreshold:10.00];
    self.mpAdView.keywords = [NSString stringWithFormat:@"%@%@", aerservPrefix,bidPrice];
}

#pragma mark - method to set the keywords given the interval pricing and threshold values
- (NSString*) getKeywordForIntervalAndThreshold:(double)buyerPrice interval:(NSString*)interval lowThreshold:(double)lowThreshold highThreshold:(double)highThreshold{
    NSString* keywords = @"";
    if(buyerPrice >= highThreshold){
        NSNumber* buyerPriceNumber = [NSNumber numberWithDouble:highThreshold];
        keywords = [buyerPriceNumber stringValue];
    }
    else{
        if(buyerPrice < lowThreshold){
            double decimal = buyerPrice - (int) (buyerPrice);
            buyerPrice = buyerPrice - decimal;
            if([interval isEqualToString:@"0.50"]){
                if(decimal >= 0.50)
                    decimal = 0.50;
                else
                    decimal = 0.0;
            }
            else if([interval isEqualToString:@"0.25"]){
                if(decimal < 0.25)
                    decimal = 0.0;
                else if(decimal>=0.25 && decimal<0.50)
                    decimal = 0.25;
                else if(decimal>=0.50 && decimal<0.75)
                    decimal = 0.50;
                else if(decimal>=0.75)
                    decimal=0.75;
            }
            buyerPrice = buyerPrice + decimal;
            NSNumber* buyerPriceNumber = [NSNumber numberWithDouble:buyerPrice];
            keywords = [buyerPriceNumber stringValue];
            
        }
        else{
            double decimal = buyerPrice - (int) (buyerPrice);
            buyerPrice = buyerPrice - decimal;
            NSNumber* buyerPriceNumber = [NSNumber numberWithDouble:buyerPrice];
            keywords = [buyerPriceNumber stringValue];
        }
    }
    return keywords;
}

#pragma mark - ASInterstitialViewControllerDelegate methods

- (void)interstitialViewControllerDidPreloadAd:(ASInterstitialViewController*)viewController {
    NSLog(@"AerServBidObject, interstitialViewControllerDidPreloadAd:Aerserv bid interstitial ad loaded.");
}

- (void)interstitialViewControllerAdFailedToLoad:(ASInterstitialViewController*)viewController withError:(NSError *)error {
    NSLog(@"AerServBidObject, interstitialViewControllerAdFailedToLoad: Aerserv bid interstitial ad failed: %@", error);
    self.asInterstitial = nil;
    [self.aerservBidListener bidFailedToLoad:self.mpInterstitialAdController error:error];
}

- (void)interstitialViewController:(ASInterstitialViewController*)viewController didLoadAdWithTransactionInfo:(NSDictionary*)transactionInfo {
    NSLog(@"AerServBidObject, didLoadAdWithTransactionInfo: Interstitial ad did load with transaction info: %@", transactionInfo);
    NSString* buyerprice = transactionInfo[@"buyerPrice"];
    NSMutableDictionary* aerservBiddingInfo = [AerServBidder getAerservBiddingInfo];
    if(self.asInterstitial != nil){
        if(rewardedFlag){
            NSLog(@"AerServBidObject, didLoadAdWithTransactionInfo: Loading rewarded keywords");
            NSString* mopubRewardedKeywords = [self getKeywordsForRewarded:buyerprice placement:self.placement];
            [aerservBiddingInfo setObject:self.asInterstitial forKey:self.placement];
            [self.aerservBidListener bidReceived:mopubRewardedKeywords];
        }
        else{
            NSLog(@"AerServBidObject, didLoadAdWithTransactionInfo: Loading interstitial keywords");
            [self setKeywordsForInterstitial:buyerprice placement:self.placement];
            [aerservBiddingInfo setObject:self.asInterstitial forKey:self.placement];
            [self.aerservBidListener bidReceived:self.mpInterstitialAdController];
        }
    }
}

- (void)interstitialViewController:(ASInterstitialViewController*)viewController didShowAdWithTransactionInfo:(NSDictionary*)transactionInfo{
    NSLog(@"AerServBidObject, didShowAdWithTransactionInfo: Interstitial ad did show with transaction info: %@", transactionInfo);
}

- (void)interstitialViewControllerDidAppear:(ASInterstitialViewController*)viewController{
    NSLog(@"AerServBidObject, interstitialViewControllerDidAppear:Aerserv bid interstitial ad shown.");
    self.asInterstitial = nil;
}

#pragma mark - ASAdViewDelegate methods

- (void)adViewDidLoadAd:(ASAdView*)adView {
    NSLog(@"AerServBidObject, adViewDidLoadAd:AerServ banner ad loaded.");
}

- (void)adViewDidFailToLoadAd:(ASAdView*)adView withError:(NSError*)error {
    NSLog(@"AerServBidObject, adViewDidFailToLoadAd:AerServ banner failed: %@", error);
    self.asBanner = nil;
    [self.aerservBidListener bidFailedToLoad:self.mpAdView error:error];
}

- (void)adView:(ASAdView*)adView didLoadAdWithTransactionInfo:(NSDictionary*)transactionInfo{
    NSLog(@"AerServBidObject, didLoadAdWithTransactionInfo: Banner ad did load with transaction info: %@", transactionInfo);
    NSString* buyerprice = transactionInfo[@"buyerPrice"];
    NSMutableDictionary* aerservBiddingInfo = [AerServBidder getAerservBiddingInfo];
    if(self.asBanner != nil){
        [self setKeywordsForBanner:buyerprice placement:self.placement];
        [aerservBiddingInfo setObject:self.asBanner forKey:self.placement];
        [self.aerservBidListener bidReceived:self.mpAdView];
    }
}

- (void)adView:(ASAdView*)adView didShowAdWithTransactionInfo:(NSDictionary*)transactionInfo{
    NSLog(@"AerServBidObject, didShowAdWithTransactionInfo: Banner ad did show with transaction info: %@", transactionInfo);
    self.asBanner = nil;
}

@end
