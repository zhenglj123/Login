//
//  YYModel.h


#import <Foundation/Foundation.h>

#if __has_include(<YYModel/YYModel.h>)
FOUNDATION_EXPORT double YYModelVersionNumber;
FOUNDATION_EXPORT const unsigned char YYModelVersionString[];
#import <Model/NSObject+Model.h>
#import <Model/ClassInfo.h>
#else
#import "NSObject+Model.h"
#import "ClassInfo.h"
#endif
