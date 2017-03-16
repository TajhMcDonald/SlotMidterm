//
//  ViewController.h
//  SlotMidterm
//
//  Created by Tajh McDonald on 11/16/16.
//  Copyright © 2016 McDonald's Computing INC. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Digit.h"

@class ViewController;

@protocol ViewControllerDelegate <NSObject>

- (void)ViewController :(ViewController *)viewController didCashOut:(NSInteger)coins;

@end

@interface ViewController : UIViewController <UIPickerViewDataSource, UIPickerViewDelegate>

@property (strong, nonatomic) IBOutlet UIPickerView *CoinPicker;
@property (strong, nonatomic) IBOutlet UIButton *spinButton;
@property (nonatomic, strong) NSMutableArray *gameHistory;

@property (strong, nonatomic) NSArray *numbersArray;
@property (nonatomic) NSInteger coins;

@property (weak, nonatomic) id<ViewControllerDelegate> delegate;

@end
