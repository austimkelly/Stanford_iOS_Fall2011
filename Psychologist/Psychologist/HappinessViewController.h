//
//  HappinessViewController.h
//  Happiness
//
//  Created by Administrator on 1/17/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SplitViewBarButtonItemPresenterProtocol.h"

@interface HappinessViewController : UIViewController<SplitViewBarButtonItemPresenterProtocol>

@property (nonatomic) int happiness; // 0 is sad, 100 is really happy

@end
