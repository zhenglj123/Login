//
//  UserData+CoreDataProperties.m
//  
//
//  Created by Zhenglj on 2018/10/21.
//
//

#import "UserData+CoreDataProperties.h"

@implementation UserData (CoreDataProperties)

+ (NSFetchRequest<UserData *> *)fetchRequest {
	return [NSFetchRequest fetchRequestWithEntityName:@"UserData"];
}

@dynamic borth;
@dynamic pwdValue;
@dynamic phoneValue;
@dynamic province;
@dynamic sex;
@dynamic nickName;
@dynamic userPhoto;

@end
