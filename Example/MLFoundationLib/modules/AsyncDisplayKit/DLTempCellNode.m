//
//  DLTempCellNode.m
//  PocketSLH
//
//  Created by sml2 on 2020/6/12.
//

#import "DLTempCellNode.h"

@interface DLTempCellNode ()

@property (nonatomic, strong) ASTextNode *nameNode;

@property (nonatomic, strong) ASTextNode *descNode;

@end

@implementation DLTempCellNode

- (instancetype)init
{
    self = [super init];
    if (self) {
        NSLog(@"---%@--",@"DLTempCellNode init");

        _nameNode = [[ASTextNode alloc] init];
        _nameNode.attributedText = [[NSMutableAttributedString alloc] initWithString:@"nameNode:18888888882181923712878"];
        
//        _descNode = [[ASTextNode alloc] init];
//        _descNode.attributedText = [[NSMutableAttributedString alloc] initWithString:@"descNode:18888888882181923712878"];
//        _descNode.backgroundColor = [UIColor grayColor];
        
        [self addSubnode:_nameNode];
//        [self addSubnode:_descNode];
        
//        __weak typeof(self) weakSelf = self;

//        self.layoutSpecBlock = ^ASLayoutSpec * _Nonnull(__kindof DLTempCellNode * _Nonnull node, ASSizeRange constrainedSize) {
////            return [ASStackLayoutSpec stackLayoutSpecWithDirection:ASStackLayoutDirectionVertical spacing:20 justifyContent:ASStackLayoutJustifyContentCenter alignItems:ASStackLayoutAlignItemsCenter children:@[
////                [ASStackLayoutSpec
////                              stackLayoutSpecWithDirection:ASStackLayoutDirectionVertical
////                              spacing:0.0
////                              justifyContent:ASStackLayoutJustifyContentStart
////                              alignItems:ASStackLayoutAlignItemsCenter children:@[
////                                  [weakSelf.nameNode styledWithBlock:^(ASLayoutElementStyle *style) {
////                                                    style.flexShrink = 1.0;
////                                                  }]
////                              ]]
////            ]];
//              ASStackLayoutSpec *mainStack = [ASStackLayoutSpec stackLayoutSpecWithDirection:ASStackLayoutDirectionHorizontal
//                                   spacing:6.0
//                            justifyContent:ASStackLayoutJustifyContentStart
//                                alignItems:ASStackLayoutAlignItemsCenter
//                                  children:@[node.nameNode, node.descNode]];
//
//              // Set some constrained size to the stack
//              mainStack.style.minWidth = ASDimensionMakeWithPoints(60.0);
//              mainStack.style.maxHeight = ASDimensionMakeWithPoints(40.0);
//
//              return mainStack;
//        };
    }
    return self;
}


//- (ASLayoutSpec *)layoutSpecThatFits:(ASSizeRange)constrainedSize
//{
//  return [ASInsetLayoutSpec insetLayoutSpecWithInsets:UIEdgeInsetsMake(30, 30, 30, 30) child:self.nameNode];
//}


//- (ASLayoutSpec *)layoutSpecThatFits:(ASSizeRange)constrainedSize
//{
//  ASStackLayoutSpec *mainStack = [ASStackLayoutSpec stackLayoutSpecWithDirection:ASStackLayoutDirectionHorizontal
//                       spacing:6.0
//                justifyContent:ASStackLayoutJustifyContentStart
//                    alignItems:ASStackLayoutAlignItemsCenter
//                      children:@[_nameNode, _descNode]];
//
//  // Set some constrained size to the stack
//  mainStack.style.minWidth = ASDimensionMakeWithPoints(60.0);
//  mainStack.style.maxHeight = ASDimensionMakeWithPoints(40.0);
//
//  return mainStack;
//}
//- (ASLayoutSpec *)layoutSpecThatFits:(ASSizeRange)constrainedSize
//{
//    UIEdgeInsets insets = UIEdgeInsetsMake(0, 12, 4, 4);
//    ASInsetLayoutSpec *inset = [ASInsetLayoutSpec insetLayoutSpecWithInsets:insets
//                                                                      child:_nameNode];
//
//    return [ASCenterLayoutSpec centerLayoutSpecWithCenteringOptions:ASCenterLayoutSpecCenteringY
//                                                      sizingOptions:ASCenterLayoutSpecSizingOptionMinimumX
//                                                              child:inset];
//}

//- (ASLayoutSpec *)layoutSpecThatFits:(ASSizeRange)constrainedSize
//{
//  ASStackLayoutSpec *mainStack = [ASStackLayoutSpec stackLayoutSpecWithDirection:ASStackLayoutDirectionHorizontal
//                       spacing:6.0
//                justifyContent:ASStackLayoutJustifyContentStart
//                    alignItems:ASStackLayoutAlignItemsCenter
//                      children:@[_nameNode, _descNode]];
//
//  // Set some constrained size to the stack
//  mainStack.style.minWidth = ASDimensionMakeWithPoints(60.0);
//  mainStack.style.maxHeight = ASDimensionMakeWithPoints(40.0);
//
//  return mainStack;
//}

- (ASLayoutSpec *)layoutSpecThatFits:(ASSizeRange)constrainedSize{
    NSLog(@"---%@--",@"layoutSpecThatFits");
    return [ASStackLayoutSpec stackLayoutSpecWithDirection:ASStackLayoutDirectionVertical spacing:20 justifyContent:ASStackLayoutJustifyContentCenter alignItems:ASStackLayoutAlignItemsCenter children:@[
        [ASStackLayoutSpec
                      stackLayoutSpecWithDirection:ASStackLayoutDirectionVertical
                      spacing:0.0
                      justifyContent:ASStackLayoutJustifyContentStart
                      alignItems:ASStackLayoutAlignItemsCenter children:@[
                          [_nameNode styledWithBlock:^(ASLayoutElementStyle *style) {
                                            style.flexShrink = 1.0;
                                          }]
                      ]]
    ]];
}

@end
