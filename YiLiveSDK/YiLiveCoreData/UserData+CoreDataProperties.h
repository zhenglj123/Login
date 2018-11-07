//
//  UserData+CoreDataProperties.h
//  
//
//  Created by Zhenglj on 2018/10/21.
//
//

#import "UserData+CoreDataClass.h"


NS_ASSUME_NONNULL_BEGIN

@interface UserData (CoreDataProperties)

+ (NSFetchRequest<UserData *> *)fetchRequest;

@property (nonatomic) int16_t borth;
@property (nullable, nonatomic, copy) NSString *pwdValue;
@property (nonatomic) int16_t phoneValue;
@property (nullable, nonatomic, copy) NSString *province;
@property (nullable, nonatomic, copy) NSString *sex;
@property (nullable, nonatomic, copy) NSString *nickName;
@property (nullable, nonatomic, copy) NSString *userPhoto;

@end

NS_ASSUME_NONNULL_END
