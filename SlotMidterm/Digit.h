//
//  Digit.h
//  SlotMidterm
//
//  Created by Tajh McDonald on 12/6/16.
//  Copyright © 2016 McDonald's Computing INC. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface Digit : NSObject

@property (nonatomic, readonly) NSUInteger myNumber;
@property (nonatomic, strong, readonly) UIColor *myColor;

@property (strong, nonatomic, readonly) NSAttributedString *digit;

- (void)randomize;


@end
