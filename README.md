# CampusAssistant
## 概念描述

一个针对东大学生的校园助手应用。

名字还没想好。

晚上上课的时候和孔伟杰想到了下面的这些功能。

做的时候不全部实现，优先做教务系统那部分（有现成的资源）。

## 功能

* 教务系统
* 课程表
* 培养计划
* 学分
* 成绩单
* 空教室
* 考试
* 图书馆
* 找书
* 预约
* 借阅状态（个人信息）
* 饭卡
* 余额
* 交易记录
* 挂失
* 社交
* 学生会、社团联合会与一般社团等学生组织
* 校园内广告、公告、宣传
* 班级
* 校园服务
* 快递
* 国家级考试（如四六级）等成绩查询
* 寻物
* 水站
* 校历
* 校园地图

## 应用结构设计

主界面是分块的信息流，比如第一项是天气，第二项是课程/考试(就是教务)，以此类推。

像天气这样的分块就在信息流上显示天气，没有附加的交互。

课程这种的除了根据时间变化内容比如下一节课的信息，还有作为几个快捷入口的按钮比如看空教室、看考试信息、查学分。各个分块之间如果能实现的话可以调整先后位置。

然后除了信息流之外另外开一个tab是功能集合可以叫百宝箱之类的，里面有提供的功能的索引。我们把常用的都提取出来放在信息流(虽然这样也不能算一般意义上的信息流)里，不常用的让使用者自己去找

## 教务处API接口

http://202.118.31.241:8080/api/v1

**注意:**

1. 以下接口默认皆为get，有标注时以标注为准
2. JSON返回值默认为JSONObject，注明为JSONArray的元素下的数据结构为此JSONArray下单个JSONObject的数据结构
3. ' &lt; &gt ' 围住的内容为变量，请在实际编写中替换为希望的值 

### 登录

http://202.118.31.241:8080/api/v1/login

#### 参数

* userName: 用户名
* passwd: 密码

> 注意：密码需要经过MD5加密，使用 *MD5Utils.generateMD5()* 生成MD5

#### 返回

JSON

* success : 请求是否成功，0为是，-1为否
* errCode : 若请求失败的错误代码
* errMsg : 若请求失败的错误信息
* data : 若请求成功时的用户数据
* token : 校验token
* userName : 用户名
* realName : 真实姓名
* isTeacher : 是否为教师用户，0为否，无关变量

### 学期课程表

http://202.118.31.241:8080/api/v1/courseSchedule

#### 说明

返回当前学期的课程表

暂时不做？

#### 参数

* token: 校验token

> 已知参数只有这些，这个接口是偶然间试出来的

#### 返回

* success : 请求是否成功，0为是，-1为否
* errCode : 若请求失败的错误代码
* errMsg : 若请求失败的错误信息
* data : 若请求成功时的课程表数据 (JSONArray)
* courseName : 课程名称
* weeks : 周数，格式为 "&lt;起始周&gt;-&lt;终止周&gt;"或"&lt;上课周&gt;(.&lt;上课周&gt;)*n"
* dayOfWeek : 上课日，为中文星期一~星期日
* time : 上课时间，格式为 "&lt;起始节&gt;-&lt;终止节&gt;"
* classroom : 教室

### 当前周课程表

http://202.118.31.241:8080/api/v1/courseSchedule2

#### 说明

返回当前周的课程表，按照时间排序

#### 参数

* token : 校验token

#### 返回

* success : 请求是否成功，0为是，-1为否
* errCode : 若请求失败的错误代码
* errMsg : 若请求失败的错误信息
* data : 若请求成功时的课程表数据 (JSONArray)
* name : 课程名称
* room : 格式为 "&lt;课程名称&gt; &lt;周数&gt; &lt;节数(若必要)&gt; &lt;教室&gt; &lt;教师&gt;" 例如 `Linux操作系统 13-18周 节 生命B101 石凯`
* week : 空

### 成绩查询

获取学期列表

http://202.118.31.241:8080/api/v1/termList

获取学期成绩

http://202.118.31.241:8080/api/v1/score/&lt;termId&gt;

#### 参数

* token : 校验token

> 两个接口都仅需要此参数

#### 返回

学期列表

* success : 请求是否成功，0为是，-1为否
* errCode : 若请求失败的错误代码
* errMsg : 若请求失败的错误信息
* data : 若请求成功时的学期列表 (JSONArray)
* termId : 学期id
* termName : 学期名

学期成绩

* success : 请求是否成功，0为是，-1为否
* errCode : 若请求失败的错误代码
* errMsg : 若请求失败的错误信息
* data : 若请求成功时的成绩列表 (JSONArray)
* termName : 学期名
* courseName : 课程名
* credit : 学分
* examType : 考试类型
* score : 总成绩
* score1 : 平时成绩
* score2 : 期中成绩
* score3 : 期末成绩
* courseType : 课程类型 (学位课/鼓励选修/etc.)
* courseGroup : 所属课程群名称
* point : 目前的综合绩点/GPA (并不是单指此科目)

### 考试日程

http://202.118.31.241:8080/api/v1/examSchedule

#### 参数

* token : 校验token

#### 返回

* success : 请求是否成功，0为是，-1为否
* errCode : 若请求失败的错误代码
* errMsg : 若请求失败的错误信息
* data : 若请求成功时的考试日程列表 (JSONArray)
* courseName : 课程名称
* weeks : 未知 无数据 根据名称看是上课周
* dayOfWeek : 未知 无数据 根据名称看是上课日
* time : 考试时间
* classroom : 考试教室

### 学业预警

http://202.118.31.241:8080/api/v1/academicWarning

#### 参数

* token : 校验token

#### 返回

* success : 请求是否成功，0为是，-1为否
* errCode : 若请求失败的错误代码
* errMsg : 若请求失败的错误信息
* data : 若请求成功时的课程群列表 (JSONArray)
* courseGroup : 课程群名称
* graduationStandard : 计划学分
* haveCredit : 已修学分
* creditDiff : 学分差
* failCredit : 不及格学分和
* failCourse : 不及格学位门数

### 培养计划

获取学年/批次列表

http://202.118.31.241:8080/api/v1/professionDevelopPlan

获取专业列表 (指定批次&lt;planBatchId&gt;)

http://202.118.31.241:8080/api/v1/professionDevelopPlan/&lt;planBatchId&gt;

获取专业培养计划课程列表 (指定批次与专业)

http://202.118.31.241:8080/api/v1/professionDevelopPlan/&lt;planBatchId&gt;/&lt;professionId&gt;

查看培养计划某一课程信息

http://202.118.31.241:8080/api/v1/professionDevelopPlan/&lt;planBatchId&gt;/&lt;professionId&gt;/&lt;courseId&gt

> 原程序中还有另外两个界面，但是里面是空内容而且没有任何请求

#### 参数

* token : 校验token

> 所有请求方式都一致

#### 返回

学年/批次列表

* success : 请求是否成功，0为是，-1为否
* errCode : 若请求失败的错误代码
* errMsg : 若请求失败的错误信息
* data : 若请求成功时的学年/批次列表 (JSONArray)
* planBatchId : 批次id
* planBatchName : 批次名称
* level : 级别/层次 (本科/硕士/etc.)

专业列表

* success : 请求是否成功，0为是，-1为否
* errCode : 若请求失败的错误代码
* errMsg : 若请求失败的错误信息
* data : 若请求成功时的专业列表 (JSONArray)
* professionId : 专业id
* professionName : 专业名称
* professionIntroduce : 专业介绍 (目前内容仅有空http头)

培养计划课程列表

* success : 请求是否成功，0为是，-1为否
* errCode : 若请求失败的错误代码
* errMsg : 若请求失败的错误信息
* data : 若请求成功时的培养计划课程列表 (JSONArray)
* termName : 学期
* courseId : 课程id
* courseName : 课程名称
* courseProperty : 课程类别 (学位课 / 一般选修 / 鼓励选修)
* courseIntroduce : 课程介绍 (目前内容全部为空)

课程信息

* success : 请求是否成功，0为是，-1为否
* errCode : 若请求失败的错误代码
* errMsg : 若请求失败的错误信息
* data : 若请求成功时的课程列表 (JSONArray)
* courseId : 课程id
* courseName : 课程名称
* grade : 授课年级
* term : 授课学期
* examMode : 考试类型 (考试 / 考查)
* courseGroup : 所属课程群名称
* hours : 学时
* credit : 学分
* isDegree : 是否为学位课
* courseType : 课程类别 (学位课 / 一般选修 / 鼓励选修)
* courseMode ： 课程模式

### 教室空闲情况查询

获取教学楼列表

http://202.118.31.241:8080/api/v1/buildings

获取教学楼教室列表

http://202.118.31.241:8080/api/v1/freeClassrooms/&lt;buildingId&gt;

获取教室空闲情况

http://202.118.31.241:8080/api/v1/freeTimes/&lt;classroomId&gt;

#### 参数

* token : 校验token

#### 返回

教学楼列表

* success : 请求是否成功，0为是，-1为否
* errCode : 若请求失败的错误代码
* errMsg : 若请求失败的错误信息
* data : 若请求成功时的教学楼列表 (JSONArray)
* buildingId : 教学楼id
* buildingName : 教学楼名称

教学楼教室列表

* success : 请求是否成功，0为是，-1为否
* errCode : 若请求失败的错误代码
* errMsg : 若请求失败的错误信息
* data : 若请求成功时的教室列表 (JSONArray)
* buildingId : 教学楼id
* classroomsId : 教室id
* classroomsName : 教室名称

教室空闲情况

* success : 请求是否成功，0为是，-1为否
* errCode : 若请求失败的错误代码
* errMsg : 若请求失败的错误信息
* data : 若请求成功时的空闲情况列表 (JSONArray)
* classroomsId : 教室id
* classroomsName : 教室名称
* freeTimes : 课节 (如 "1-2节" "3-4节" 此项可不理会，全部数据都是按照1~12节的顺序分为6段记录的)
* status : 对应课节的教室状态

### 学籍信息

http://202.118.31.241:8080/api/v1/schoolRoll

#### 参数

* token : 校验token

#### 返回

* success : 请求是否成功，0为是，-1为否
* errCode : 若请求失败的错误代码
* errMsg : 若请求失败的错误信息
* data : 若请求成功时的学籍信息 (JSONArray)
* examId : 考生号
* StudentId : 学号
* StudentName : 姓名
* englishName : 英文姓名
* sex : 性别
* birth : 出生日期
* idCard : 身份证号
* political : 政治面貌
* nation : 民族
* professionId : 专业编号
* professionName : 专业名称
* collegeName : 院系名称
* professionType : 专业类别
* className : 所在班级
* level : 级别/层次 (本科/硕士/etc.)
* StudyForm : 学习形式 (如 普通全日制)
* standard : 学制 (年)
* startDate : 入学日期
* endDate : 预计毕业年月

## 交互（暂定）

1. LoginActivity 教务处账号登录
2. 登录成功记录账户信息 进入MainActivity
3. 进入MainActivity时进行一系列可行的更新操作
* 天气
* 课程
* etc.

更新时有视觉刷新提示