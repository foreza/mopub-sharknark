//
//  DataViewController.h
//  mopub-sharknark
//
//  Created by Jason C on 6/21/18.
//  Copyright © 2018 Jason C. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MPInterstitialAdController.h"



@interface DataViewController : UIViewController <MPInterstitialAdControllerDelegate>

@property (strong, nonatomic) IBOutlet UILabel *dataLabel;
@property (strong, nonatomic) id dataObject;

@end

