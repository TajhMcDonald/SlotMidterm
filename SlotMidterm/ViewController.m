//
//  ViewController.m
//  SlotMidterm
//
//  Created by Tajh McDonald on 11/16/16.
//  Copyright © 2016 McDonald's Computing INC. All rights reserved.
//

#import "ViewController.h"
#import "HistoryViewController.h"
#import "Digit.h"
@interface ViewController ()

- (IBAction)spin:(id)sender;

@property (weak, nonatomic) IBOutlet UILabel *currentCoinAmount;
@property (weak, nonatomic) IBOutlet UILabel *totalCoinWinnings;
@property (nonatomic, strong) NSMutableArray *digits;

@property (weak, nonatomic) IBOutlet UILabel *notificationOneLabel;
@property (weak, nonatomic) IBOutlet UILabel *notificationTwoLabel;
@property (strong,nonatomic) NSMutableArray *flipHistory;

@property (weak, nonatomic) IBOutlet UIButton *rulesAndRanksButton;
@property (weak, nonatomic) IBOutlet UILabel *detailLabel;

@property (nonatomic) NSInteger amountOfcoinsWon;
@property (nonatomic) BOOL justWon;
@property (nonatomic) BOOL componentOneHeld;
@property (nonatomic) BOOL componentTwoHeld;
@property (nonatomic) BOOL componentThreeHeld;
@property (nonatomic) NSUInteger rowOne;
@property (nonatomic) NSUInteger rowTwo;
@property (nonatomic) NSUInteger rowThree;
@property (nonatomic) NSUInteger myNumber;
@property (nonatomic, strong) UIColor *myColor;

@end

@implementation ViewController
- (NSMutableArray *)digits {
    if (!_digits) {
        _digits = [[NSMutableArray alloc] init];
    }
    return _digits;
}
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

- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView
{
    return 3;
}
-(NSMutableArray*)flipHistory
{
    if(!_flipHistory)_flipHistory = [[NSMutableArray alloc] init];
    return _flipHistory;
}
- (NSInteger)pickerView:(UIPickerView *)pickerView
numberOfRowsInComponent:(NSInteger)component
{
    return self.numbersArray.count;
}
- (UIView *)pickerView:(UIPickerView *)pickerView viewForRow:(NSInteger)row forComponent:(NSInteger)component reusingView:(UIView *)view{

    UIColor *color;
    switch (arc4random()%4) {
        case 0: color = [UIColor redColor]; break;
        case 1: color = [UIColor blueColor]; break;
        case 2: color = [UIColor greenColor]; break;
        case 3: color = [UIColor purpleColor]; break;
    }

    NSString *text;
    
    if(component == 0) {
        text = self.numbersArray[row];
    } else if(component == 1) {
        text = self.numbersArray[row];
    } else if(component ==2){
        text = self.numbersArray[row];
    }
    UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(0, 0,0, 44)];
    if(view == nil) {
        label.backgroundColor = [UIColor grayColor];
        label.textColor = color;
        label.font = [UIFont fontWithName:@"HelveticaNeue-Bold" size:18];
        label.text = text;
        
    }
    return label;

}


-(void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component
{
    NSMutableAttributedString *textsult=[[NSMutableAttributedString alloc] init];

    NSString *resultString = _numbersArray[row];
    [textsult appendAttributedString:[[NSAttributedString alloc]initWithString:resultString ]];
    resultString = _numbersArray[row];
    self.detailLabel.text = resultString;
    [self addToHistory];
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
- (NSAttributedString *)pickerView:(UIPickerView *)pickerView
             titleForRow:(NSInteger)row
            forComponent:(NSInteger)component
{
    return self.numbersArray[row];

}

- (IBAction)spin:(UIPickerView *)sender
{
    
    [self playerHasEnoughcoins];

}

- (void)playerHasEnoughcoins
{
    BOOL playerHasEnoughcoins = YES;
    
    if (playerHasEnoughcoins && self.coins >= 2)
    {
        self.coins -= 2;
        self.currentCoinAmount.text = [NSString stringWithFormat:@"Your coins: %li", self.coins];
        [self spinTheNumbers];
    }
        [self showHiddenNotifcationLabels];
}


- (void)showHiddenNotifcationLabels
{
    self.notificationOneLabel.hidden = NO;
    self.notificationTwoLabel.hidden = NO;
}
- (NSArray *)gameHistory {
    if (!_gameHistory) {
        _gameHistory = [[NSMutableArray alloc] init];
    }
    return _gameHistory;
}

- (void)spinTheNumbers
{
    
    self.notificationOneLabel.hidden = YES;
    self.notificationTwoLabel.hidden = YES; //make this into separate method?
    
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
    [self postSpinActions];
    [self addToHistory];


}
- (void)addToHistory {
    
    NSMutableString *s = [[NSMutableString alloc] init];
    for (Digit *d in self.digits) {
        [s appendString:[NSString stringWithFormat:@"%lu ", d.myNumber]];
    }
    
    UIFont *font = [UIFont fontWithName:@"Courier" size:32.0];
    
    NSMutableAttributedString *entry = [[NSMutableAttributedString alloc] initWithString:s];
    
    for ( int i = 0 ; i < [self.digits count] ; i++ ) {
        Digit *d = [self.numbersArray objectAtIndex:i];
        [entry setAttributes:@{NSForegroundColorAttributeName:d.myColor,
                               NSFontAttributeName:font}
                       range:NSMakeRange(i*2, 1)];
    }
    
    [self.flipHistory addObject:entry];
}
- (Digit *)getDigit: (int)index {
    return [self.numbersArray objectAtIndex:index];
}

- (void)postSpinActions
{
    BOOL playerWinsALot = [self playerHasWonThreeInARow];
    BOOL playerWinsALittle = [self playerHasWonTwoInARow];
    
    NSString *title = @"";
    NSString *message = @"";
    NSMutableAttributedString *textsult=[[NSMutableAttributedString alloc] init];

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
    self.totalCoinWinnings.text = [NSString stringWithFormat:@"Total coins Won: %li", self.amountOfcoinsWon];
    self.currentCoinAmount.text = [NSString stringWithFormat:@"Your coins: %li", self.coins];
    
    self.notificationOneLabel.text = title;
    self.notificationTwoLabel.text = message;
    
    [self showHiddenNotifcationLabels];

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

- (NSInteger)playersWinningsWithNumbersInARow:(NSUInteger)amountOfcoinsInARow
{
    NSUInteger rowOne = [self.CoinPicker selectedRowInComponent:0];
    NSUInteger winnings = 0;

    if (amountOfcoinsInARow == 3)
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
    else if (amountOfcoinsInARow == 2)
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
- (IBAction)cashOutButtonTapped:(id)sender
{
    self.coins = 100;
    self.currentCoinAmount.text = [NSString stringWithFormat:@"Your coins: %li", self.coins];
    self.totalCoinWinnings.text = @"Total coins Won: 0";
    self.amountOfcoinsWon -= 100;
    self.flipHistory = nil;
}
@end
