//
//  FaceView.h
//  Happiness
//
//  Created by Administrator on 1/17/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>

@class FaceView;

@protocol FaceViewDataSource <NSObject>

- (float)smileForFaceView:(FaceView *)sender;

@end


@interface FaceView : UIView

@property (nonatomic) CGFloat scale;

- (void) pinch:(UIPinchGestureRecognizer *)gesture;


@property (nonatomic, weak) IBOutlet id <FaceViewDataSource> dataSource;

@end
