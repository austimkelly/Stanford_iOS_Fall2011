//
//  CalculatorBrain.h
//  Calculator
//
//  Created by Administrator on 1/7/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface CalculatorBrain : NSObject

- (void)pushOperand:(double)operand;
- (double)performOperation:(NSString *)operation;
- (void)clear;

@property (readonly) id program;
@property (nonatomic, readwrite) double memoryStore;

+ (double)runProgram:(id)program;
+ (NSString *)descriptionOfProgram:(id)program;
+ (double)inverse:(double)input;
+ (double)sin:(double)input;
+ (double)cos:(double)input;


@end
