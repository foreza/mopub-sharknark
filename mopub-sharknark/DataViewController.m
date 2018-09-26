//
//  DataViewController.m
//  mopub-sharknark
//
//  Created by Jason C on 6/21/18.
//  Copyright © 2018 Jason C. All rights reserved.
//

#import "DataViewController.h"

@interface DataViewController ()

//@property (nonatomic, retain) MPInterstitialAdController *interstitial;

@property (weak, nonatomic) IBOutlet UITextField *MoPubSDKVersion;
@property (weak, nonatomic) IBOutlet UITextField *AerServSDKVersion;
@property (weak, nonatomic) IBOutlet UITextField *AerServSDKGDPR;
@property (weak, nonatomic) IBOutlet UIScrollView *ScrollView;


@end

@implementation DataViewController


NSString *logTag = @"SharkNark~~";

// Placement / AdUnit IDs
NSString *MP_APPID = @"1010499";
NSString *MP_BANNERID = @"6e4d807aba354282a692b107bb60433a";         // Old: bc9158e63fc84368b070d0f39e479168
NSString *MP_INTERSTITIALID = @"0ac5282697c545c2a5e5b92b4112f70e";   // tablet: 77122b5593a9441697fb3c33bf337883 || older, 8ebb75051f774da8bd5bdb4fddb475df, 1ca8f0690bb04eb08891d5969fcb5255, 86ea3dd2b0934f7383c2e009f4301ecd
NSString *MP_REWARDEDID = @"689e91ffac404f159a926a83135138a2";       // TODO: Set this up properly in MP dashboard and programmatically
NSString *MP_CUSTOMNATIVEID = @"ef1226e2a6ce43da92da2d4f69997d1f";   // TODO: Set this up properly in MP dashboard and programmatically


- (void)viewDidLoad {

    
    // Init the AerServ SDK
    [AerServSDK initializeWithAppID:MP_APPID];
    
    // Set the scrollview content size to larger than the actual defined dimensions
    _ScrollView.contentSize = CGSizeMake(self.view.bounds.size.width, 900);
    
    // Set title and text information
    self.title = @"SHARK!";
    _AerServSDKVersion.text = [AerServSDK sdkVersion];
    _MoPubSDKVersion.text = MP_SDK_VERSION;

    NSLog(@"%@", [logTag stringByAppendingString:@"DataViewController - viewDidLoad"]);
    [super viewDidLoad];
    
    [self loadBanner];       // Load the banner
}


- (void)loadBanner {
    
    self.adView = [[MPAdView alloc] initWithAdUnitId:MP_BANNERID size:MOPUB_BANNER_SIZE];
    
    // Load the banner and add it to the view
    self.adView.frame = CGRectMake((self.view.bounds.size.width - MOPUB_BANNER_SIZE.width) / 2, self.view.bounds.size.height - MOPUB_BANNER_SIZE.height, MOPUB_BANNER_SIZE.width, MOPUB_BANNER_SIZE.height);
//    [_ScrollView addSubview:self.adView];
    [self.view addSubview:self.adView];
    self.adView.delegate = self;
    [self.adView loadAd];
    
    NSLog(@"%@", [logTag stringByAppendingString:@"DataViewController - loadBanner"]);

    
}


- (void)loadStaticNative {
    // TO DO: Implement
    
}

- (IBAction)loadInterstitial:(id)sender {
    
    self.interstitial = [MPInterstitialAdController interstitialAdControllerForAdUnitId:MP_INTERSTITIALID];
    
    // Delegates send messages to you.
    self.interstitial.delegate = self;
    [self.interstitial loadAd];
    NSLog(@"%@", [logTag stringByAppendingString:@"DataViewController - loadInterstitial"]);

}

- (IBAction)showInterstitial:(id)sender {

    if (self.interstitial.ready) {
        NSLog(@"%@", [logTag stringByAppendingString:@"showInterstitial from DataViewController"]);
        [self.interstitial showFromViewController:self];
    } else {
    NSLog(@"%@", [logTag stringByAppendingString:@"showInterstitial NOT READY!!"]);
    }
}

- (IBAction)loadRewarded:(id)sender {
    
    [MPRewardedVideo loadRewardedVideoAdWithAdUnitID:MP_REWARDEDID withMediationSettings:NULL];
    NSLog(@"%@", [logTag stringByAppendingString:@"loadRewarded"]);
    
}


- (IBAction)showRewarded:(id)sender {
    
    [MPRewardedVideo presentRewardedVideoAdForAdUnitID:MP_REWARDEDID fromViewController:self withReward:NULL];
    NSLog(@"%@", [logTag stringByAppendingString:@"showRewarded"]);

}



// Gets debug information for the application

- (void) setDebugText {
    // _MoPubSDKVersion.text = [];
    _AerServSDKVersion.text = [AerServSDK sdkVersion];
    
    if ([AerServSDK getGDPRConsentValue]){
        _AerServSDKGDPR.text = @"YES GDPR Consent";
    } else
        _AerServSDKGDPR.text = @"NO GDPR Consent";

}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    self.dataLabel.text = [self.dataObject description];
}
    






#pragma mark - <MPAdViewDelegate>


- (void)adViewDidLoadAd:(MPAdView *)view {
    // do something
}

//- (UIViewController *)viewControllerForPresentingModalView {
//    // do something
//}



#pragma mark - <MPInterstitialAdControllerDelegate>


- (void)interstitialDidLoadAd:(MPInterstitialAdController *)interstitial
{
    NSLog(@"%@", [logTag stringByAppendingString:@"interstitialDidLoadAd fired"]);
}

- (void)interstitialDidFailToLoadAd:(MPInterstitialAdController *)interstitial
{
    NSLog(@"%@", [logTag stringByAppendingString:@"interstitialDidFailToLoadAd"]);
    
}

- (void)interstitialDidExpire:(MPInterstitialAdController *)interstitial
{
    NSLog(@"%@", [logTag stringByAppendingString:@"interstitialDidExpire"]);
    
}


- (void)interstitialWillAppear:(MPInterstitialAdController *)interstitial {
    NSLog(@"%@", [logTag stringByAppendingString:@"interstitialWillAppear"]);
    
}

- (void)interstitialDidDisappear:(MPInterstitialAdController *)interstitial {
    NSLog(@"%@", [logTag stringByAppendingString:@"interstitialDidDisappear"]);
}


#pragma mark - <MPRewardedVideoDelegate>


- (void)rewardedVideoAdDidLoadForAdUnitID:(NSString *)adUnitID {
    NSLog(@"%@", [logTag stringByAppendingString:@"rewardedVideoAdDidLoadForAdUnitID"]);

}

- (void)rewardedVideoAdDidFailToPlayForAdUnitID:(NSString *)adUnitID error:(NSError *)error {
    NSLog(@"%@", [logTag stringByAppendingString:@"rewardedVideoAdDidFailToPlayForAdUnitID"]);
    
}
- (void)rewardedVideoAdWillAppearForAdUnitID:(NSString *)adUnitID {
    NSLog(@"%@", [logTag stringByAppendingString:@"rewardedVideoAdWillAppearForAdUnitID"]);

}
- (void)rewardedVideoAdDidAppearForAdUnitID:(NSString *)adUnitID {
    NSLog(@"%@", [logTag stringByAppendingString:@"rewardedVideoAdDidAppearForAdUnitID"]);

    
}
- (void)rewardedVideoAdWillDisappearForAdUnitID:(NSString *)adUnitID {
    NSLog(@"%@", [logTag stringByAppendingString:@"rewardedVideoAdWillDisappearForAdUnitID"]);

    
}
- (void)rewardedVideoAdDidDisappearForAdUnitID:(NSString *)adUnitID {
    NSLog(@"%@", [logTag stringByAppendingString:@"rewardedVideoAdDidDisappearForAdUnitID"]);

    
}
- (void)rewardedVideoAdDidExpireForAdUnitID:(NSString *)adUnitID {
    NSLog(@"%@", [logTag stringByAppendingString:@"rewardedVideoAdDidExpireForAdUnitID"]);

    
}
- (void)rewardedVideoAdDidReceiveTapEventForAdUnitID:(NSString *)adUnitID {
    NSLog(@"%@", [logTag stringByAppendingString:@"rewardedVideoAdDidReceiveTapEventForAdUnitID"]);

}
- (void)rewardedVideoAdShouldRewardForAdUnitID:(NSString *)adUnitID reward:(MPRewardedVideoReward *)reward {
    NSLog(@"%@", [logTag stringByAppendingString:@"rewardedVideoAdShouldRewardForAdUnitID"]);

    
}
- (void)rewardedVideoAdWillLeaveApplicationForAdUnitID:(NSString *)adUnitID {
    NSLog(@"%@", [logTag stringByAppendingString:@"rewardedVideoAdWillLeaveApplicationForAdUnitID"]);
}


@end
