//
//  Card.h
//  Matchismo
//
//  Created by Avishay Sheba on 1/2/14.
//  Copyright (c) 2014 Via Transportation Inc. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Card : NSObject

@property (strong, nonatomic) NSString *contents;

@property (nonatomic, getter=isChosen) BOOL chosen;
@property (nonatomic, getter=isMatched) BOOL matched;

- (int)match:(NSArray *)otherCards;
- (BOOL)isEqualToCard:(Card *)card;

@end
