//
//  PlayingCard.h
//  Matchismo
//
//  Created by Avishay Sheba on 1/2/14.
//  Copyright (c) 2014 Via Transportation Inc. All rights reserved.
//

#import "Card.h"

@interface PlayingCard : Card

@property (strong, nonatomic) NSString *suit;
@property (nonatomic) NSUInteger rank;

- (BOOL)isBlack;

+ (NSArray *)validSuites;
+ (NSUInteger)maxRank;

@end
