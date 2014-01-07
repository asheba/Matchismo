//
//  SetCard.h
//  Matchismo
//
//  Created by Avishay Sheba on 1/6/14.
//  Copyright (c) 2014 Via Transportation Inc. All rights reserved.
//

#import "Card.h"

@interface SetCard : Card

@property (nonatomic) NSUInteger shape;
@property (nonatomic) NSUInteger count;
@property (nonatomic) NSUInteger color;
@property (nonatomic) NSUInteger style;

+ (NSUInteger)typeCount;
+ (BOOL)isValid:(NSUInteger)property;

@end
