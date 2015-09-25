//
//  ObjectUtil.h
//  D3Json
//
//  Created by mozhenhau on 15/9/24.
//  Copyright © 2015年 d3. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ObjectUtil : NSObject

+(id)ObjFromString:(NSString*)className;
+(id)ObjFromClass:(Class)className;
@end
