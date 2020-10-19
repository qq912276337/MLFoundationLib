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

@property (nonatomic, strong) ASTextNode *rightTextNode;

@property (nonatomic, strong) ASImageNode *photoNode;

@property (nonatomic, strong) ASImageNode *iconNode;


@end

@implementation DLTempCellNode

- (instancetype)init
{
    self = [super init];
    if (self) {
        NSLog(@"---%@--",@"DLTempCellNode init");

        _nameNode = [[ASTextNode alloc] init];
        _nameNode.attributedText = [[NSMutableAttributedString alloc] initWithString:@"nameNode"];
        
        _descNode = [[ASTextNode alloc] init];
        _descNode.attributedText = [[NSMutableAttributedString alloc] initWithString:@"descNode"];
        
        
        _rightTextNode = [[ASTextNode alloc] init];
        _rightTextNode.attributedText = [[NSMutableAttributedString alloc] initWithString:@"_rightTextNode"];
        
        [self addSubnode:_nameNode];
        [self addSubnode:_descNode];
        [self addSubnode:_rightTextNode];
        
        _photoNode = [[ASImageNode alloc] init];
        _photoNode.image = [UIImage imageNamed:@"1xiangqing_1yuan"];
        [self addSubnode:_photoNode];
        
        _iconNode = [[ASImageNode alloc] init];
        _iconNode.contentMode = UIViewContentModeCenter;
        _iconNode.image = [UIImage imageNamed:@"alipay"];
        [self addSubnode:_iconNode];
        
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
    /*
      _photoNode.style.preferredSize = CGSizeMake(20*2, 20*2);
    
    

    // INIFINITY is used to make the inset unbounded
    UIEdgeInsets insets = UIEdgeInsetsMake(INFINITY, 12, 12, 12);
    ASInsetLayoutSpec *textInsetSpec = [ASInsetLayoutSpec insetLayoutSpecWithInsets:insets child:_nameNode];
    
    return [ASOverlayLayoutSpec overlayLayoutSpecWithChild:_photoNode overlay:textInsetSpec];
     */
    
    /*
    _iconNode.style.preferredSize = CGSizeMake(40, 40);
    _photoNode.style.preferredSize = CGSizeMake(150, 200);

    return [ASCornerLayoutSpec cornerLayoutSpecWithChild:_photoNode corner:_iconNode location:ASCornerLayoutLocationTopRight];
     */
    UIEdgeInsets insets = UIEdgeInsetsMake(0, 12, 4, 4);
       ASInsetLayoutSpec *inset = [ASInsetLayoutSpec insetLayoutSpecWithInsets:insets
                                                                         child:_nameNode];

       return [ASCenterLayoutSpec centerLayoutSpecWithCenteringOptions:ASCenterLayoutSpecCenteringXY
                                                         sizingOptions:ASCenterLayoutSpecSizingOptionMinimumX
                                                                 child:inset];
    
    
    /*
    ASStackLayoutSpec *nameLocationStackSpec = [ASStackLayoutSpec verticalStackLayoutSpec];
//    nameLocationStackSpec.style.flexGrow = 1.0;
//    nameLocationStackSpec.style.flexShrink = 1.0;
    nameLocationStackSpec.children = @[_nameNode,_descNode];
    
    ASStackLayoutSpec *headerStackSpec = [ASStackLayoutSpec stackLayoutSpecWithDirection:ASStackLayoutDirectionHorizontal spacing:100 justifyContent:ASStackLayoutJustifyContentStart alignItems:ASStackLayoutAlignItemsCenter children:@[nameLocationStackSpec,_rightTextNode]];
    
    return [ASInsetLayoutSpec insetLayoutSpecWithInsets:UIEdgeInsetsMake(0, 10, 0, 10) child:headerStackSpec];
     */
    
//    NSLog(@"---%@--",@"layoutSpecThatFits");
//    return [ASStackLayoutSpec stackLayoutSpecWithDirection:ASStackLayoutDirectionVertical spacing:20 justifyContent:ASStackLayoutJustifyContentCenter alignItems:ASStackLayoutAlignItemsCenter children:@[
//        [ASStackLayoutSpec
//                      stackLayoutSpecWithDirection:ASStackLayoutDirectionVertical
//                      spacing:0.0
//                      justifyContent:ASStackLayoutJustifyContentStart
//                      alignItems:ASStackLayoutAlignItemsCenter children:@[
//                          [_nameNode styledWithBlock:^(ASLayoutElementStyle *style) {
//                                            style.flexShrink = 1.0;
//                                          }]
//                      ]]
//    ]];
}

@end
