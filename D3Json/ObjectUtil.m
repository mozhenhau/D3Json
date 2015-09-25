//
//  ObjectUtil.m
//  D3Json
//
//  Created by mozhenhau on 15/9/24.
//  Copyright © 2015年 d3. All rights reserved.
//

#import "ObjectUtil.h"

@implementation ObjectUtil

+(id)ObjFromString:(NSString*)className{
    return [NSClassFromString(className) new];
}


+(id)ObjFromClass:(Class)class{
    return [class new];
}
@end

