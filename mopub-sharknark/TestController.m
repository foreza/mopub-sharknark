//
//  TestController.m
//  mopub-sharknark
//
//  Created by Jason C on 8/23/18.
//  Copyright © 2018 Jason C. All rights reserved.
//

#import "TestController.h"

@interface TestController ()

//@property (nonatomic, retain) MPInterstitialAdController *interstitial;

@end

@implementation TestController

NSString *logTagT = @"SharkNark TEST CONTROLLER~~";
MPInterstitialAdController *interstitialT;


- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    interstitialT = [MPInterstitialAdController interstitialAdControllerForAdUnitId:@"86ea3dd2b0934f7383c2e009f4301ecd"];
//    interstitialT = [MPInterstitialAdController interstitialAdControllerForAdUnitId:@"4155795d0d844c59a412a9747e6dc472"];

    
    interstitialT.delegate = self;
    [interstitialT loadAd];

    NSLog(@"%@", [logTagT stringByAppendingString:@"viewDidLoad - loadInterstitial"]);
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


- (void)interstitialDidLoadAd:(MPInterstitialAdController *)interstitial
{
    NSLog(@"%@", [logTagT stringByAppendingString:@"interstitialDidLoadAd fired"]);
}

- (void)interstitialDidFailToLoadAd:(MPInterstitialAdController *)interstitial
{
    NSLog(@"%@", [logTagT stringByAppendingString:@"interstitialDidFailToLoadAd"]);
    
}

- (void)interstitialDidExpire:(MPInterstitialAdController *)interstitial
{
    NSLog(@"%@", [logTagT stringByAppendingString:@"interstitialDidExpire"]);
    
}



- (void)interstitialWillAppear:(MPInterstitialAdController *)interstitial {
    NSLog(@"%@", [logTagT stringByAppendingString:@"interstitialWillAppear"]);
    
}

- (void)interstitialDidDisappear:(MPInterstitialAdController *)interstitial {
    NSLog(@"%@", [logTagT stringByAppendingString:@"interstitialDidDisappear"]);
}


/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
