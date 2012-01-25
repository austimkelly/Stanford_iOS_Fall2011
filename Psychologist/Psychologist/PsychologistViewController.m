//
//  PsychologistViewController.m
//  Psychologist
//
//  Created by Administrator on 1/19/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "PsychologistViewController.h"
#import "HappinessViewController.h"

@interface PsychologistViewController() 
@property (nonatomic) int diagnosis;

@end

@implementation PsychologistViewController

@synthesize diagnosis = _diagnosis;

- (HappinessViewController *)splitViewHappinessViewController {
    id hvc = [self.splitViewController.viewControllers lastObject];
    if (![hvc isKindOfClass:[HappinessViewController class]]){
        hvc = nil;
    }
    return hvc;
}

- (void)setAndShowDiagnosis:(int)diagnosis {
    self.diagnosis = diagnosis;
    //seque
    if ([self splitViewHappinessViewController]){
        [self splitViewHappinessViewController].happiness = diagnosis;
    } else {
        [self performSegueWithIdentifier:@"ShowDiagnosis" sender:self];
    }
}

-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender{
    if ([segue.identifier isEqualToString:@"ShowDiagnosis"]){
        [segue.destinationViewController setHappiness:self.diagnosis];
    }
    else if ([segue.identifier isEqualToString:@"Celebrity"]){
        [segue.destinationViewController setHappiness:100];
    }
    else if ([segue.identifier isEqualToString:@"Sick"]){
        [segue.destinationViewController setHappiness:20];
    }
    else if ([segue.identifier isEqualToString:@"TVKook"]){
        [segue.destinationViewController setHappiness:50];
    }
}

- (IBAction)flying {
    [self setAndShowDiagnosis:85];
}
- (IBAction)steelApple {
    [self setAndShowDiagnosis:100];
}
- (IBAction)dragons {
    [self setAndShowDiagnosis:20];
}

- (IBAction)celebrity {
    [self setAndShowDiagnosis:85];
}
- (IBAction)seriousProblem {
    [self setAndShowDiagnosis:10];
}
- (IBAction)tvKook {
    [self setAndShowDiagnosis:60];
}


- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    // Return YES for supported orientations
    return YES;
}

@end
