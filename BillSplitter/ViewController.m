//
//  ViewController.m
//  BillSplitter
//
//  Created by ruijia lin on 4/21/18.
//  Copyright © 2018 ruijia lin. All rights reserved.
//

#import "ViewController.h"

@interface ViewController () <UITextFieldDelegate>
@property (weak, nonatomic) IBOutlet UITextField *billAmount;
@property (weak, nonatomic) IBOutlet UILabel *totalAmount;
@property (weak, nonatomic) IBOutlet UISlider *numberOfPeopleSlider;
@property (weak, nonatomic) IBOutlet UISlider *tipPercentSlider;
@property (weak, nonatomic) IBOutlet UILabel *numberOfPeopleLabel;
@property (weak, nonatomic) IBOutlet UILabel *tipPercentLabel;
@property NSNumberFormatter *numberFormatter;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    self.billAmount.keyboardType = UIKeyboardTypeNumberPad;
    self.billAmount.textAlignment = NSTextAlignmentRight;
    self.numberFormatter = [NSNumberFormatter new];
    [self.numberFormatter setMaximumFractionDigits:2];
    [self.numberFormatter setRoundingMode:NSNumberFormatterRoundDown];
    [self.numberFormatter setNumberStyle:NSNumberFormatterCurrencyStyle];
}

- (IBAction)calculateTotal:(UIButton *)sender {
    
    [self getTotal];
}

- (IBAction)numberOfPeople:(UISlider *)sender {
    float roundedNumber = 0.0;
    roundedNumber = roundf(sender.value / 1.0 * 1.0);
    [sender setValue:roundedNumber animated:YES];
    self.numberOfPeopleLabel.text = [NSString stringWithFormat:@"%.0f people",roundedNumber];
    
    [self getTotal];
}

- (IBAction)tipPercent:(UISlider *)sender {
    float roundedNumber = 0.0;
    roundedNumber = roundf(sender.value / 1.0 * 1.0);
    [sender setValue:roundedNumber animated:YES];
    self.tipPercentLabel.text = [NSString stringWithFormat:@"Tip %.0f%%",roundedNumber];
    
    [self getTotal];
}

-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    
    [self.billAmount resignFirstResponder];
    
}

-(void)getTotal{
    //remove $ from bill amount text and convert to float
    if ([self.billAmount.text isEqualToString:@""] || [self.billAmount.text isEqualToString:@"$"]){
        self.billAmount.text = @"0.00";
    }
    NSDecimalNumber *billAmt = [[NSDecimalNumber alloc] initWithString:self.billAmount.text];
    NSDecimalNumber *numberOfPeople = [[NSDecimalNumber alloc] initWithFloat:self.numberOfPeopleSlider.value];
    NSDecimalNumber *tipPercent = [[NSDecimalNumber alloc] initWithFloat: 1.0 +(self.tipPercentSlider.value / 100.0)];
    
    //    self.totalAmount.text = self.billAmount.text
    self.totalAmount.text = [self.numberFormatter stringFromNumber:[[billAmt decimalNumberByDividingBy:numberOfPeople] decimalNumberByMultiplyingBy:tipPercent]];
}
@end
