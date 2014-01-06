//
//  CardGameViewController.h
//  Matchismo
//
//  Created by Avishay Sheba on 1/2/14.
//  Copyright (c) 2014 Via Transportation Inc. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CardMatchingGame.h"

@interface CardGameViewController : UIViewController

- (CardMatchingGame *)createGameWithCardCount:(NSInteger) count;

@end
