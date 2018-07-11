//
//  DataViewController.h
//  mopub-sharknark
//
//  Created by Jason C on 6/21/18.
//  Copyright © 2018 Jason C. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MPAdView.h"
#import "MPInterstitialAdController.h"
#import <AerServSDK/AerServSDK.h>


@interface DataViewController : UIViewController <MPAdViewDelegate, MPInterstitialAdControllerDelegate>

@property (strong, nonatomic) IBOutlet UILabel *dataLabel;
@property (nonatomic) MPAdView *adView;         // For MoPub Banner
@property (strong, nonatomic) id dataObject;

@end

