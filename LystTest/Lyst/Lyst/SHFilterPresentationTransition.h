//
//  SHFilterPresentationTransition.h
//  r2r
//
//  Created by Samuel Hervás on 6/4/17.
//  Copyright © 2017 Samuel Hervas. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SHFilterPresentationTransition : NSObject <UIViewControllerAnimatedTransitioning>

@property (nonatomic, assign, getter=isDissmisTransition) BOOL dissmisTransition;

@end
