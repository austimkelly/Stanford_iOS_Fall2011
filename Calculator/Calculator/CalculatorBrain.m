//
//  CalculatorBrain.m
//  Calculator
//
//  Created by Administrator on 1/7/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "CalculatorBrain.h"

@interface CalculatorBrain()
@property (nonatomic, strong) NSMutableArray *programStack;

@end

@implementation CalculatorBrain

@synthesize programStack = _programStack;
@synthesize memoryStore;



- (void)clear
{
    if([self.programStack count]){
       [self.programStack removeAllObjects];
    }
    
}
 
- (void)setOperandStack:(NSMutableArray *)programStack{
    _programStack = programStack;
}

- (NSMutableArray *)operandStack {
    if (_programStack == nil)
       _programStack = [[NSMutableArray alloc] init];
    return _programStack;
}

- (void)pushOperand:(double)operand{
    NSNumber *operandNumber = [NSNumber numberWithDouble:operand];
    [self.operandStack addObject:operandNumber];
}
 
- (double)performOperation:(NSString *)operation{
    
    [self.programStack addObject:operation];
    return [CalculatorBrain runProgram:self.program];
}
     
- (id) program {
    return [self.programStack copy];
}

+ (double)inverse:(double)input {
    if (input == 0) return 0;
    return 1/input;
}

+ (double)sin:(double)input {
    return sin(input);
}

+ (double)cos:(double)input {
    return cos(input);
}

+ (double)popOperandOffStack:(id)stack {
    double result = 0;
    
    id topOfStack = [stack lastObject];
    if (topOfStack) [stack removeLastObject];
    
    if ([topOfStack isKindOfClass:[NSNumber class]]){
        result = [topOfStack doubleValue];
    }
    else if ([topOfStack isKindOfClass:[NSString class]] ){
        NSString *operation = topOfStack;
        // do calculations
        if ([operation isEqualToString:@"+"]) {
            double d1 = [self popOperandOffStack:stack];
            double d2 = [self popOperandOffStack:stack];
            result = d1 + d2;
        }
        else if ([operation isEqualToString:@"-"]) {
            double sub = [self popOperandOffStack:stack];
            result = [self popOperandOffStack:stack] - sub;
        }
        else if ([operation isEqualToString:@"*"]) {
            double d1 = [self popOperandOffStack:stack];
            double d2 = [self popOperandOffStack:stack];
            result = d1 * d2;
        }
        else if ([operation isEqualToString:@"/"]) {
            double div = [self popOperandOffStack:stack];
            result = [self popOperandOffStack:stack] / div;
        }

    }
    
    return result;
}

+ (NSString *)descriptionOfProgram:(NSMutableArray *)program {
    return @"TODO: Implement description of program here.";
}

+ (double)runProgram:(id)program {
    NSMutableArray * stack;
    if ([program isKindOfClass:[NSArray class]]) {
        stack = [program mutableCopy];
    }
    
    return [self popOperandOffStack:stack];    
}


@end
