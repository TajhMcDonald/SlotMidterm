//
//  ViewController_V2.m
//  SlotMidterm
//
//  Created by Tajh McDonald on 11/16/16.
//  Copyright © 2016 McDonald's Computing INC. All rights reserved.
//

#import "ViewController_V2.h"
#import "HistoryViewController.h"
@interface ViewController_V2 ()

- (IBAction)spin:(id)sender;

@property (weak, nonatomic) IBOutlet UILabel *currentCoinAmount;
@property (weak, nonatomic) IBOutlet UILabel *totalCoinWinnings;

@property (weak, nonatomic) IBOutlet UILabel *notificationOneLabel;
@property (weak, nonatomic) IBOutlet UILabel *notificationTwoLabel;
@property (weak, nonatomic) IBOutlet UILabel *detailLabel;
@property (strong,nonatomic) NSMutableArray *flipHistory;

@property (weak, nonatomic) IBOutlet UIButton *rulesAndRanksButton;

@property (nonatomic) NSInteger amountOfcoinsWon;
@property (nonatomic) BOOL justWon;
@property (nonatomic) BOOL componentOneHeld;
@property (nonatomic) BOOL componentTwoHeld;
@property (nonatomic) BOOL componentThreeHeld;
@property (nonatomic) BOOL componentFourHeld;
@property (nonatomic) BOOL componentFiveHeld;

@property (nonatomic) NSUInteger rowOne;
@property (nonatomic) NSUInteger rowTwo;
@property (nonatomic) NSUInteger rowThree;

@end

@implementation ViewController_V2

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.numbersArray = @[@"1", @"2", @"3", @"4", @"5", @"6", @"7", @"8", @"9", @"0",@"1", @"2", @"3", @"4", @"5", @"6", @"7", @"8", @"9", @"0",@"1", @"2", @"3", @"4", @"5", @"6", @"7", @"8", @"9", @"0",@"1", @"2", @"3", @"4", @"5", @"6", @"7", @"8", @"9", @"0",@"0",@"1", @"2", @"3", @"4", @"5", @"6", @"7", @"8", @"9"];
    
    self.CoinPicker.dataSource = self;
    self.CoinPicker.delegate = self;
    
    self.notificationOneLabel.text = @"";
    self.notificationTwoLabel.text = @"";
    
    self.coins = 100;
    self.currentCoinAmount.text = [NSString stringWithFormat:@"Your coins: %li", self.coins];
    self.totalCoinWinnings.text = @"Total coins Won: 0";
    
    self.rulesAndRanksButton.layer.cornerRadius = self.rulesAndRanksButton.frame.size.height/2;
    
    for (NSUInteger i = 0; i < self.CoinPicker.numberOfComponents; i++)
    {
        NSUInteger randomRow = arc4random_uniform((int)self.numbersArray.count);
        [self.CoinPicker selectRow:randomRow inComponent:i animated:YES];
    }
    self.justWon = NO;
}
-(NSMutableArray*)flipHistory
{
    if(!_flipHistory)_flipHistory = [[NSMutableArray alloc] init];
    return _flipHistory;
}
- (UIView *)pickerView:(UIPickerView *)pickerView viewForRow:(NSInteger)row forComponent:(NSInteger)component reusingView:(UIView *)view{
    CGFloat hue = ( arc4random() % 256 / 256.0 );  //  0.0 to 1.0
    CGFloat saturation = ( arc4random() % 128 / 256.0 ) + 0.5;  //  0.5 to 1.0, away from white
    CGFloat brightness = ( arc4random() % 128 / 256.0 ) + 0.5;  //  0.5 to 1.0, away from black
    UIColor *color = [UIColor colorWithHue:hue saturation:saturation brightness:brightness alpha:1];
    UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(0, 0,0, 44)];
    label.backgroundColor = [UIColor grayColor];
    label.textColor = color;
    label.font = [UIFont fontWithName:@"HelveticaNeue-Bold" size:18];
    label.text = _numbersArray[row];
    return label;
}


- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView
{
    return 5;
}

- (NSInteger)pickerView:(UIPickerView *)pickerView
numberOfRowsInComponent:(NSInteger)component
{
    return self.numbersArray.count;
}

- (NSString *)pickerView:(UIPickerView *)pickerView
             titleForRow:(NSInteger)row
            forComponent:(NSInteger)component
{
    return self.numbersArray[row];
}

- (IBAction)spin:(UIPickerView *)sender
{
    [self playerHasCoins];
}

- (void)playerHasCoins
{
    BOOL playerHasCoins = YES;
 
    
    if (playerHasCoins && self.coins >= 2)
    {
        self.coins -= 2;
        self.currentCoinAmount.text = [NSString stringWithFormat:@"Your coins: %li", self.coins];
        [self spinTheNumbers];
    }
}


- (void)showHiddenNotifcationLabels
{
    self.notificationOneLabel.hidden = NO;
    self.notificationTwoLabel.hidden = NO;
}
-(void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component
{
    NSMutableAttributedString *textsult=[[NSMutableAttributedString alloc] init];
    
    NSString *resultString = _numbersArray[row];
    [textsult appendAttributedString:[[NSAttributedString alloc]initWithString:resultString ]];
    resultString = _numbersArray[row];
    self.detailLabel.text = resultString;
    [self.flipHistory addObject:textsult];
    
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if ([segue.identifier isEqualToString:@"Show history"]) {
        if ([segue.destinationViewController isKindOfClass:[HistoryViewController class]]) {
            HistoryViewController *hsvc = (HistoryViewController *)segue.destinationViewController;
            hsvc.flipHistory = self.flipHistory;
        }
    }
    
}

- (void)spinTheNumbers
{
    self.notificationOneLabel.hidden = YES;
    self.notificationTwoLabel.hidden = YES;
    
    NSUInteger randomRow = 0;
    NSUInteger amountofCoins = self.numbersArray.count;
    
    if (!self.componentOneHeld)
    {
        randomRow = arc4random_uniform((int)amountofCoins);
        [self.CoinPicker selectRow:randomRow inComponent:0 animated:YES];
    }
    if (!self.componentTwoHeld)
    {
        randomRow = arc4random_uniform((int)amountofCoins);
        [self.CoinPicker selectRow:randomRow inComponent:1 animated:YES];
    }
    if (!self.componentThreeHeld)
    {
        randomRow = arc4random_uniform((int)amountofCoins);
        [self.CoinPicker selectRow:randomRow inComponent:2 animated:YES];
    }
    if (!self.componentFourHeld)
    {
        randomRow = arc4random_uniform((int)amountofCoins);
        [self.CoinPicker selectRow:randomRow inComponent:3 animated:YES];
    }
    if (!self.componentFiveHeld)
    {
        randomRow = arc4random_uniform((int)amountofCoins);
        [self.CoinPicker selectRow:randomRow inComponent:4 animated:YES];
    }
    [self postSpinActions];
}

- (void)postSpinActions
{
    BOOL playerWinsALot = [self playerHasWonThreeInARow];
    BOOL playerWinsALittle = [self playerHasWonTwoInARow];
    
    NSString *title = @"";
    NSMutableAttributedString *textsult=[[NSMutableAttributedString alloc] init];
    NSString *message = @"";
    
    
    
    if (playerWinsALot)
    {
        NSUInteger winnings = [self playersWinningsWithNumbersInARow:3];
        self.amountOfcoinsWon += winnings;
        self.coins += winnings;
        self.justWon = YES;
        
        title = [title stringByAppendingString:[NSString stringWithFormat:@"You've won %lu coins!", winnings]];
        [textsult appendAttributedString:[[NSAttributedString alloc]initWithString:title ]];
        self.detailLabel.attributedText = textsult;
        [self.flipHistory addObject:textsult];
        message = @"Wanna play again?";
    }
    else if (playerWinsALittle)
    {
        NSUInteger winnings = [self playersWinningsWithNumbersInARow:2];
        self.amountOfcoinsWon += winnings;
        self.coins += winnings;
        self.justWon = YES;
        
        title = [title stringByAppendingString:[NSString stringWithFormat:@"You've won %lu coins!", winnings]];
        [textsult appendAttributedString:[[NSAttributedString alloc]initWithString:title ]];
        self.detailLabel.attributedText = textsult;
        [self.flipHistory addObject:textsult];
        message = @"Wanna play again?";
    }
    else
    {
        self.justWon = NO;
    }
    self.totalCoinWinnings.text = [NSString stringWithFormat:@"Total Coins Won: %li", self.amountOfcoinsWon];
    self.currentCoinAmount.text = [NSString stringWithFormat:@"Your Coins: %li", self.coins];
    
    self.notificationOneLabel.text = title;
    self.notificationTwoLabel.text = message;
    
    [self showHiddenNotifcationLabels];
    }

- (BOOL)playerHasWonFiveInARow
{
    NSUInteger rowOne = [self.CoinPicker selectedRowInComponent:0];
    NSUInteger rowTwo = [self.CoinPicker selectedRowInComponent:1];
    NSUInteger rowThree = [self.CoinPicker selectedRowInComponent:2];
    NSUInteger rowFour = [self.CoinPicker selectedRowInComponent:3];
    NSUInteger rowFive = [self.CoinPicker selectedRowInComponent:4];

    
    return (self.numbersArray[rowOne] == self.numbersArray[rowTwo] && self.numbersArray[rowTwo] == self.numbersArray[rowThree] && self.numbersArray[rowThree] == self.numbersArray[rowFour] && self.numbersArray[rowFour] == self.numbersArray[rowFive]);
}
- (BOOL)playerHasWonFourInARow
{
    NSUInteger rowOne = [self.CoinPicker selectedRowInComponent:0];
    NSUInteger rowTwo = [self.CoinPicker selectedRowInComponent:1];
    NSUInteger rowThree = [self.CoinPicker selectedRowInComponent:2];
    NSUInteger rowFour = [self.CoinPicker selectedRowInComponent:3];

    
    return (self.numbersArray[rowOne] == self.numbersArray[rowTwo] && self.numbersArray[rowTwo] == self.numbersArray[rowThree] && self.numbersArray[rowThree] == self.numbersArray[rowFour]);
}
- (BOOL)playerHasWonThreeInARow
{
    NSUInteger rowOne = [self.CoinPicker selectedRowInComponent:0];
    NSUInteger rowTwo = [self.CoinPicker selectedRowInComponent:1];
    NSUInteger rowThree = [self.CoinPicker selectedRowInComponent:2];
    
    return (self.numbersArray[rowOne] == self.numbersArray[rowTwo] && self.numbersArray[rowTwo] == self.numbersArray[rowThree]);
}

- (BOOL)playerHasWonTwoInARow
{
    NSUInteger rowOne = [self.CoinPicker selectedRowInComponent:0];
    NSUInteger rowTwo = [self.CoinPicker selectedRowInComponent:1];
    
    return self.numbersArray[rowOne] == self.numbersArray[rowTwo];
}

- (NSInteger)playersWinningsWithNumbersInARow:(NSUInteger)amountOfNumbersInARow
{
    NSUInteger rowOne = [self.CoinPicker selectedRowInComponent:0];
    NSUInteger winnings = 0;
    if (amountOfNumbersInARow == 5)
    {
        if ([self.numbersArray[rowOne] isEqualToString:@"1"])
        {
            winnings = 500;
        }
        else if ([self.numbersArray[rowOne] isEqualToString:@"2"])
        {
            winnings = 1000;
        }
        else if ([self.numbersArray[rowOne] isEqualToString:@"3"])
        {
            winnings = 2500;
        }
        else if ([self.numbersArray[rowOne] isEqualToString:@"4"])
        {
            winnings = 5000;
        }
        else if ([self.numbersArray[rowOne] isEqualToString:@"5"])
        {
            winnings = 7500;
        }
        else if ([self.numbersArray[rowOne] isEqualToString:@"6"])
        {
            winnings = 10000;
        }
        else if ([self.numbersArray[rowOne] isEqualToString:@"7"])
        {
            winnings = 15000;
        }
        else if ([self.numbersArray[rowOne] isEqualToString:@"8"])
        {
            winnings = 50000;
        }
        else if ([self.numbersArray[rowOne] isEqualToString:@"9"])
        {
            winnings = 100000;
        }
    }

    else if (amountOfNumbersInARow == 4)
    {
        if ([self.numbersArray[rowOne] isEqualToString:@"1"])
        {
            winnings = 25;
        }
        else if ([self.numbersArray[rowOne] isEqualToString:@"2"])
        {
            winnings = 50;
        }
        else if ([self.numbersArray[rowOne] isEqualToString:@"3"])
        {
            winnings = 150;
        }
        else if ([self.numbersArray[rowOne] isEqualToString:@"4"])
        {
            winnings = 400;
        }
        else if ([self.numbersArray[rowOne] isEqualToString:@"5"])
        {
            winnings = 650;
        }
        else if ([self.numbersArray[rowOne] isEqualToString:@"6"])
        {
            winnings = 900;
        }
        else if ([self.numbersArray[rowOne] isEqualToString:@"7"])
        {
            winnings = 1000;
        }
        else if ([self.numbersArray[rowOne] isEqualToString:@"8"])
        {
            winnings = 4000;
        }
        else if ([self.numbersArray[rowOne] isEqualToString:@"9"])
        {
            winnings = 20000;
        }
    }

    else if (amountOfNumbersInARow == 3)
    {
        if ([self.numbersArray[rowOne] isEqualToString:@"1"])
        {
            winnings = 50;
        }
        else if ([self.numbersArray[rowOne] isEqualToString:@"2"])
        {
            winnings = 100;
        }
        else if ([self.numbersArray[rowOne] isEqualToString:@"3"])
        {
            winnings = 250;
        }
        else if ([self.numbersArray[rowOne] isEqualToString:@"4"])
        {
            winnings = 500;
        }
        else if ([self.numbersArray[rowOne] isEqualToString:@"5"])
        {
            winnings = 750;
        }
        else if ([self.numbersArray[rowOne] isEqualToString:@"6"])
        {
            winnings = 1000;
        }
        else if ([self.numbersArray[rowOne] isEqualToString:@"7"])
        {
            winnings = 1500;
        }
        else if ([self.numbersArray[rowOne] isEqualToString:@"8"])
        {
            winnings = 5000;
        }
        else if ([self.numbersArray[rowOne] isEqualToString:@"9"])
        {
            winnings = 10000;
        }
    }
    else if (amountOfNumbersInARow == 2)
    {
        if ([self.numbersArray[rowOne] isEqualToString:@"1"])
        {
            winnings = 5;
        }
        else if ([self.numbersArray[rowOne] isEqualToString:@"2"])
        {
            winnings = 10;
        }
        else if ([self.numbersArray[rowOne] isEqualToString:@"3"])
        {
            winnings = 25;
        }
        else if ([self.numbersArray[rowOne] isEqualToString:@"4"])
        {
            winnings = 50;
        }
        else if ([self.numbersArray[rowOne] isEqualToString:@"5"])
        {
            winnings = 75;
        }
        else if ([self.numbersArray[rowOne] isEqualToString:@"6"])
        {
            winnings = 100;
        }
        else if ([self.numbersArray[rowOne] isEqualToString:@"7"])
        {
            winnings = 150;
        }
        else if ([self.numbersArray[rowOne] isEqualToString:@"8"])
        {
            winnings = 500;
        }
        else if ([self.numbersArray[rowOne] isEqualToString:@"9"])
        {
            winnings = 1000;
        }
        
    }
    return winnings;
}

- (void)holdingSlotsError
{
    self.notificationOneLabel.text = @"You can't hold slots";
    self.notificationTwoLabel.text = @"when you've just won.";
    
    [self showHiddenNotifcationLabels];
}

- (IBAction)cashOutButtonTapped:(id)sender
{
    self.coins = 100;
    self.currentCoinAmount.text = [NSString stringWithFormat:@"Your coins: %li", self.coins];
    self.totalCoinWinnings.text = @"Total coins Won: 0";
    self.amountOfcoinsWon -= 100;
    self.flipHistory = nil;
}
@end
