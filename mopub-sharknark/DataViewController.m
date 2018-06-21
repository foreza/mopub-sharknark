//
//  DataViewController.m
//  mopub-sharknark
//
//  Created by Jason C on 6/21/18.
//  Copyright © 2018 Jason C. All rights reserved.
//

#import "DataViewController.h"
#import "MPGlobal.h"

@interface DataViewController ()
@property (nonatomic, retain) MPInterstitialAdController *interstitial;


@end

@implementation DataViewController

NSString *logTag = @"SharkNark~~";


    
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    self.title = @"Interstitial";
    
    // Instantiate the interstitial using the class convenience method.
    self.interstitial = [MPInterstitialAdController
                         interstitialAdControllerForAdUnitId:@"8ebb75051f774da8bd5bdb4fddb475df"];
    
    // Delegates send messages to you.
    self.interstitial.delegate = self;
    
    [self loadInterstitial];
    
    

    NSLog(@"%@", [logTag stringByAppendingString:@"DataViewController - viewDidLoad"]);

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