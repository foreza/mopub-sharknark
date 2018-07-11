//
//  DataViewController.m
//  mopub-sharknark
//
//  Created by Jason C on 6/21/18.
//  Copyright © 2018 Jason C. All rights reserved.
//

#import "DataViewController.h"

@interface DataViewController ()
@property (nonatomic, retain) MPInterstitialAdController *interstitial;

@property (weak, nonatomic) IBOutlet UITextField *MoPubSDKVersion;
@property (weak, nonatomic) IBOutlet UITextField *AerServSDKVersion;
@property (weak, nonatomic) IBOutlet UITextField *AerServSDKGDPR;
@property (weak, nonatomic) IBOutlet UIScrollView *ScrollView;




@end

@implementation DataViewController

NSString *logTag = @"SharkNark~~";

    
- (void)viewDidLoad {

    
    // Init the AerServ SDK
    [AerServSDK initializeWithAppID:@"380000"];
    
    
    self.title = @"SHARK!";
    
    _AerServSDKVersion.text = [AerServSDK sdkVersion];
    _MoPubSDKVersion.text = MP_SDK_VERSION;
    
    // Set the scrollview content size to larger than the actual defined dimensions
    _ScrollView.contentSize = CGSizeMake(self.view.bounds.size.width, 900);
    
    // Instantiate the banners and interstitial using the class convenience method.
    self.adView = [[MPAdView alloc] initWithAdUnitId:@"c6f63589809349deb3a6572e12f5e714" size:MOPUB_BANNER_SIZE];
    self.interstitial = [MPInterstitialAdController interstitialAdControllerForAdUnitId:@"8ebb75051f774da8bd5bdb4fddb475df"];
    
    
    // Delegates send messages to you.
    self.adView.delegate = self;
    self.interstitial.delegate = self;
    
    
    // Load the banner and add it to the view
    self.adView.frame = CGRectMake((self.view.bounds.size.width - MOPUB_BANNER_SIZE.width) / 2, self.view.bounds.size.height - MOPUB_BANNER_SIZE.height, MOPUB_BANNER_SIZE.width, MOPUB_BANNER_SIZE.height);
    [_ScrollView addSubview:self.adView];
    [self.adView loadAd];
    
    
    // Load Interstitial
    // [self loadInterstitial];
    

    NSLog(@"%@", [logTag stringByAppendingString:@"DataViewController - viewDidLoad"]);


    
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    
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
    

    
- (void)loadInterstitial {
    // Fetch the interstitial ad.
    [self.interstitial loadAd];
    NSLog(@"%@", [logTag stringByAppendingString:@"DataViewController - loadInterstitial"]);

}


#pragma mark - <MPAdViewDelegate>


- (void)adViewDidLoadAd:(MPAdView *)view
{ // something
}


#pragma mark - <MPInterstitialAdControllerDelegate>






- (void)interstitialDidLoadAd:(MPInterstitialAdController *)interstitial
{
    if (self.interstitial.ready) {
        [self.interstitial showFromViewController:self];
        NSLog(@"%@", [logTag stringByAppendingString:@"interstitialDidLoadAd"]);
    } else {
        NSLog(@"%@", [logTag stringByAppendingString:@"interstitialDidLoadAd NOT READY!!"]);
    }

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



@end
