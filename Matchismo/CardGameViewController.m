//
//  CardGameViewController.m
//  Matchismo
//
//  Created by Avishay Sheba on 1/2/14.
//  Copyright (c) 2014 Via Transportation Inc. All rights reserved.
//

#import "CardGameViewController.h"

@interface CardGameViewController ()

@property (strong, nonatomic) CardMatchingGame *game;
@property (strong, nonatomic) IBOutletCollection(UIButton) NSArray *cardButtons;
@property (weak, nonatomic) IBOutlet UILabel *scoreLabel;
@property (weak, nonatomic) IBOutlet UIButton *resetButton;
@property (weak, nonatomic) IBOutlet UISegmentedControl *matchButton;
@property (weak, nonatomic) IBOutlet UILabel *statusLabel;
@end

@implementation CardGameViewController

- (CardMatchingGame *)game
{
    if (!_game) _game = [self createGameWithCardCount:[self.cardButtons count]];
    return _game;
}

- (CardMatchingGame *)createGameWithCardCount:(NSInteger)count
{
    return nil;
}

- (IBAction)touchCardButton:(UIButton *)sender
{
    int chosenButtonIndex = [self.cardButtons indexOfObject:sender];
    [self.game chooseCardAtIndex:chosenButtonIndex];
    self.matchButton.enabled = NO;
    Card *card = [self.game cardAtIndex:chosenButtonIndex];
    NSString *action = (card.isChosen ? @"Selected" : @"Unselected");
    [self.statusLabel setText:[NSString stringWithFormat:@"%@ card: %@", action, card.contents]];
    [self updateUI];
}

- (IBAction)touchResetButton:(UIButton *)sender {
    [self.game reset];
    self.matchButton.enabled = YES;
    [self updateUI];
    [self.statusLabel setText:@"Restarted game."];
}

- (IBAction)touchMatchButton:(UISegmentedControl *)sender {
    NSString *title = [sender titleForSegmentAtIndex:sender.selectedSegmentIndex];
    [self.game setMatchType:[[title componentsSeparatedByString:@" "][1] integerValue]];
    [self.statusLabel setText:[NSString stringWithFormat:@"Changed game to \"%@\"", title]];
}

- (void)updateUI
{
    int oldScore = [[self.scoreLabel.text componentsSeparatedByString:@" "][1] integerValue];
    int scoreDiff = self.game.score - oldScore;
    
    for (UIButton *cardButton in self.cardButtons) {
        int cardButtonIndex = [self.cardButtons indexOfObject:cardButton];
        Card *card = [self.game cardAtIndex:cardButtonIndex];
        [cardButton setTitle:[self titleForCard:card] forState:UIControlStateNormal];
        [cardButton setBackgroundImage:[self backgroundImageForCard:card] forState:UIControlStateNormal];
        cardButton.enabled = !card.isMatched;
    }
    
    if (self.game.matchType == [self.game.currentSelection count]) {
        self.statusLabel.text = [NSString stringWithFormat:@"Got %d points for matching: %@",
                                 scoreDiff, [self.game.currentSelection componentsJoinedByString:@", "]];
    }
    self.scoreLabel.text = [NSString stringWithFormat:@"Score: %d", self.game.score];
}

- (NSString *)titleForCard:(Card *)card
{
    return card.isChosen ? card.contents : @"";
}

- (UIImage *)backgroundImageForCard:(Card *)card
{
    return [UIImage imageNamed:card.isChosen ? @"cardfront" : @"cardback"];
}

@end
