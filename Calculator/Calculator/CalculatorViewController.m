//
//  CalculatorViewController.m
//  Calculator
//
//  Created by Administrator on 1/7/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "CalculatorViewController.h"
#import "CalculatorBrain.h"

@interface CalculatorViewController()
@property (nonatomic) BOOL isUserInTheMiddleOfACalculation;
@property (nonatomic, strong) CalculatorBrain *brain;
@end

@implementation CalculatorViewController

@synthesize display = _display;
@synthesize isUserInTheMiddleOfACalculation = _isUserInTheMiddleOfACalculation;
@synthesize brain = _brain;

- (CalculatorBrain *)brain
{
    if (!_brain) _brain =  [[CalculatorBrain alloc] init];
    return _brain;
}

- (IBAction)memoryFunctionPressed:(UIButton *)sender {
    NSString *digit = [sender currentTitle];
    NSLog(@"Memory Fx pressed = %@", digit);
    
    double currentValue = [self.display.text doubleValue];
    
    if ([digit isEqualToString:@"Store"]){
        // store the memory in the brain
        [self.brain setMemoryStore:currentValue];
    }
    else if ([digit isEqualToString:@"Recall"]){
        // recall the memory from the brain
        // and update display
        currentValue = [self.brain memoryStore];
        self.display.text = [NSString stringWithFormat:@"%f", currentValue];
    }
    else if ([digit isEqualToString:@"M+"]){
        // add the value of the memory
        // in the brain to the current value
        double memoryValue = [self.brain memoryStore];
        [self.brain pushOperand:memoryValue];
        
       self.display.text = [NSString stringWithFormat:@"%g", [self.brain performOperation:@"+"]];
    }
    
}


- (IBAction)clearPressed {
    self.display.text = @"0";
    [self.brain clear]; // remove all objects
}


- (IBAction)fxPressed:(UIButton *)sender {
    
    NSString *digit = [sender currentTitle];
    NSLog(@"Fx pressed = %@", digit);
    
    double currentValue = [self.display.text doubleValue];
    if ([[sender currentTitle]isEqualToString:@"sin"]){
        self.display.text = [NSString stringWithFormat:@"%f", [CalculatorBrain sin:currentValue]];
    }
    else if ([[sender currentTitle]isEqualToString:@"cos"]){
        self.display.text = [NSString stringWithFormat:@"%f", [CalculatorBrain cos:currentValue]];
    }
    else if ([[sender currentTitle]isEqualToString:@"1/x"])
    {
        self.display.text = [NSString stringWithFormat:@"%f", [CalculatorBrain inverse:currentValue]];
    }
    else if ([[sender currentTitle]isEqualToString:@"+/-"])
    {
        NSString *currentDisplay = self.display.text;
        if ([currentDisplay hasPrefix:@"-"]) {
            // remove prefix
            self.display.text = [self.display.text substringFromIndex:1];
        } else {
            // add prefix
            self.display.text = [NSString stringWithFormat:@"%@%@", @"-", currentDisplay];
        }
        
    }
}


- (IBAction)digitPressed:(UIButton *)sender {
    NSString *digit = [sender currentTitle];
    NSLog(@"Digit pressed = %@", digit);
    NSString *currentDisplay = self.display.text;

    // Check for floating point. If digit already has
    // a decimal don't allow another.
    if (self.isUserInTheMiddleOfACalculation && [[sender currentTitle] isEqualToString:@"."]){
                
        NSRange range = [currentDisplay rangeOfString:@"."];
        if (range.location != NSNotFound) { 
            return; // decimal already exist
        } 
    }
    
    if([currentDisplay hasPrefix:@"."]){
        self.display.text = [NSString stringWithFormat:@"%@%@", @"0", currentDisplay];
    }
    
    if (self.isUserInTheMiddleOfACalculation){
        self.display.text = [self.display.text stringByAppendingString:digit];
    } else {
        self.display.text = digit;
        self.isUserInTheMiddleOfACalculation = YES;
    }
}

- (IBAction)enterPressed
{
    [self.brain pushOperand:[self.display.text doubleValue]];
    self.isUserInTheMiddleOfACalculation = NO;
}

- (IBAction)operationPressed:(UIButton *)sender 
{
    if (self.isUserInTheMiddleOfACalculation) {
        [self enterPressed];
    }
    double result = [self.brain performOperation:sender.currentTitle];
    NSString *resultString = [NSString stringWithFormat:@"%g", result];
    self.display.text = resultString;
}


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Release any cached data, images, etc that aren't in use.
}

#pragma mark - View lifecycle

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
}

- (void)viewDidUnload
{
    [self setDisplay:nil];
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
}

- (void)viewWillDisappear:(BOOL)animated
{
	[super viewWillDisappear:animated];
}

- (void)viewDidDisappear:(BOOL)animated
{
	[super viewDidDisappear:animated];
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    // Return YES for supported orientations
    return (interfaceOrientation != UIInterfaceOrientationPortraitUpsideDown);
}



@end
