//
//  DLTempTexTNode.m
//  PocketSLH
//
//  Created by sml2 on 2020/6/11.
//

#import "DLTempTexTNode.h"

@implementation DLTempTexTNode

- (void)dealloc{
    NSLog(@"---%@--",@"DLTempTexTNode dealloc");

}

- (void)didExitDisplayState{
    [super didExitDisplayState];
    NSLog(@"---%@--",@"DLTempTexTNode didExitDisplayState");

}

@end
