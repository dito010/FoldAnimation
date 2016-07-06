//
//  HeaderView.m
//  FoldAnimation
//
//  Created by Chris on 16/7/6.
//  Copyright © 2016年 Chris. All rights reserved.
//

#import "HeaderView.h"

@implementation HeaderView

+(instancetype)viewFromXib{
    return [[[NSBundle mainBundle]loadNibNamed:NSStringFromClass([self class]) owner:nil options:nil]lastObject];
}

@end
