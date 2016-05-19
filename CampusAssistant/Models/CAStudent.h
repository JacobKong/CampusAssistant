//
//  CAStudent.h
//  CampusAssistant
//
//  Created by JacobKong on 16/2/20.
//  Copyright © 2016年 com.jacob. All rights reserved.
//

#import <Foundation/Foundation.h>
/**
 *  "examId": "13140106151516",
 "StudentId": "20132037",
 "StudentName": "孔伟杰",
 "englishName": "KONG WEI JIE ",
 "sex": "男",
 "birth": "19950201",
 "idCard": "140108199502010814",
 "political": "",
 "nation": "汉族",
 "professionId": "X080902",
 "professionName": "软件工程",
 "collegeName": "软件学院",
 "professionType": "软件工程",
 "className": "软件1302",
 "level": "本科  ",
 "StudyForm": "普通全日制",
 "standard": "4",
 "startDate": "20130901",
 "endDate": "2017-06"
 */
@interface CAStudent : NSObject
@property (copy, nonatomic) NSString *StudentId;
@property (copy, nonatomic) NSString *StudentName;
@property (copy, nonatomic) NSString *englishName;
@property (copy, nonatomic) NSString *sex;
//@property (copy, nonatomic) NSString *birth;
//@property (copy, nonatomic) NSString *idCard;
//@property (copy, nonatomic) NSString *political;
//@property (copy, nonatomic) NSString *nation;
//@property (copy, nonatomic) NSString *professionId;
@property (copy, nonatomic) NSString *professionName;
@property (copy, nonatomic) NSString *collegeName;
//@property (copy, nonatomic) NSString *professionType;
@property (copy, nonatomic) NSString *className;
//@property (copy, nonatomic) NSString *level;
@property (copy, nonatomic) NSString *StudyForm;
//@property (copy, nonatomic) NSString *standard;
@property (copy, nonatomic) NSString *startDate;
//@property (copy, nonatomic) NSString *endDate;
@end
