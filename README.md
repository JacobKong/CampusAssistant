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

## 教务系统（网页版）接口

### 登录

需要首先从

http://202.118.31.197/ACTIONVALIDATERANDOMPICTURE.APPPROCESS

获取验证码

#### 接口

http://202.118.31.197/ACTIONLOGON.APPPROCESS?mode=4

POST

#### 参数

WebUserNO 学号

Password 密码

Agnomen 验证码

### 课程表

http://202.118.31.197/ACTIONQUERYSTUDENTSCHEDULEBYSELF.APPPROCESS?m=1

GET

仅需要Cookie

#### 解析方式

```
首先替换<br style="mso-data-placement:same-cell">为<br>

替换 (<br>)+ 为 <br>

使用 <tr style="height:100px">([\s\S]*?)</tr> 选出每一小节 （一周课表）

使用 <td valign="top".+?</td> 选出每一小节 （每节课程 共42条）

替换 <td valign="top".+?> 为空（删除）

替换 </td> 为空（删除）

使用 ^.+?节(?=<br>)|(?<=<br>).+?节(?=<br>)|(?<=<br>).+?节$|^.+?节$ 取出每节课（一节可能存在复数门课）

使用^.+?(?=<br>)|(?<=<br>).+?(?=<br>)|(?<=<br>).+?$存储各节课信息
```

### 成绩

http://202.118.31.197/ACTIONQUERYSTUDENTSCORE.APPPROCESS

GET 仅需要Cookie

POST 需要参数 YearTermNO 以指定学期索引

#### HTML解析

##### 学期列表

```
(?<=(<option value=")).+?((?=" selected>)|(?=">)) 以选出学期索引
((?<=(">))|(?<=(selected>))).+?(?=</option>) 以选出学期名称
```

##### 成绩

**数据构成：**

课程性质|课程号|课程名称|考试类型|学时|学分|成绩类型|平时成绩|期中成绩|期末成绩|总成绩
---|---|---|---|---|---|---|---|---|---|---

```
GPA：
(?<=平均学分绩点：).+
成绩：
((?<=color-row">)|(?<=color-rowNext">))[\s\S]+?(?=</tr>) 取出单条课程成绩
((?<=p;)|(?<=r" nowrap>)).*?(?=</td>) 	取出成绩信息（注意：结果中包含空字符串）
```

### 考试日程

http://202.118.31.197/ACTIONQUERYEXAMTIMETABLEBYSTUDENT.APPPROCESS?mode=2

GET

#### HTML解析

**数据构成**

课程号|课程名|开课模式|考试时间|教学楼|教室|座号|考场
---|---|---|---|---|---|---|---

```
((?<=color-row">)|(?<=color-rowNext">))[\s\S]+?(?=</tr>) 取出单条考试
(?<=>).*?(?=</td>) 取出考试信息
若单条考试信息首条数据为 &nbsp; 跳过
替换所有&nbsp;为空
```

### 教室占用查询

获取各种需要参数

http://202.118.31.197/ACTIONQUERYCLASSROOMNOUSE.APPPROCESS

GET

POST 需要参数 \*为必选 下表相同

YearTermNO\*|WeekdayID|StartSection\*|EndSection\*|STORYNO|ClassroomNO
---|---|---|---|---|---
学期|星期|开始节|结束节|教学楼|教室

获取占用信息

http://202.118.31.197/ACTIONQUERYCLASSROOMUSEBYWEEKDAYSECTION.APPPROCESS?mode=2

POST 需要参数

YearTermNO\*|WeekdayID|StartSection\*|EndSection\*|STORYNO|ClassroomNO\*
---|---|---|---|---|---
学期|星期|开始节|结束节|教学楼|教室

#### HTML解析

##### 学期列表

```
<td.+学年学期</td>[\s\S]+?</td> 取出数据块
((?<=\d" selected>)|(?<=\d">)).+?(?=</option>) 取出学期名称
(?<=<option value=").+?((?=">)|(?=" selected>)) 取出学期索引
```

##### 星期

星期一 ~ 星期日 分别为 1~7

##### 节次

节次包含 1~12

##### 教学楼

```
<td.+教.+学.+楼</td>[\s\S]+?</td> 取出数据块
((?<=\d" selected>)|(?<=\d">)).+?(?=</option>) 取出教学楼名称
(?<=<option value=").+?((?=">)|(?=" selected>)) 取出教学楼索引
```

##### 教室

```
<td.+教.+室</td>[\s\S]+?</td> 取出数据块
((?<=\d" selected>)|(?<=\d">)).+?(?=</option>) 取出教室名称
(?<=<option value=").+?((?=">)|(?=" selected>)) 取出教室索引
```

##### 上课信息

数据构成

星期|节次|教学楼|教室类型|教室|课程名|教师|上课对象|开课周
---|---|---|---|---|---|---|---|---

```
((?<=color-row">)|(?<=color-rowNext">))[\s\S]+?(?=</tr>) 获取单条上课信息
(?<=>).+?(?=</td>) 取出单条内数据
若单条考试信息首条数据为 &nbsp; 跳过
若否 将所有&nbsp;删除
```

### 学业预警

http://202.118.31.197/ACTIONQUERYBASESTUDENTINFO.APPPROCESS?mode=3

GET

#### HTML解析

数据构成

编号|课群名称|计划学分|已修学分|学分差|不及格学分和
---|---|---|---|---|---

```
((?<=color-row">)|(?<=color-rowNext">))[\s\S]+?(?=</tr>) 取出单条
((?<=>)).+?(?=</td>)|(?<=\">\\r\\n).+?(?=\\r\\n.+</a>) 取出单条内数据
后续处理需要去除空白
```

### 个人信息

http://202.118.31.197/ACTIONFINDSTUDENTINFO.APPPROCESS?mode=1&showMsg=

GET

#### HTML解析

```
学号：
<span class="style3">学号</span></td>[\s\S]+?</td> 
(?<=&nbsp;)\d+

姓名：
<span class="style3">姓名</span></td>[\s\S]+?</td> 
(?<=&nbsp;).+(?=</td>)

性别：
<span class="style3">性别</span></td>[\s\S]+?</td> 
(?<=&nbsp;).+(?=</td>)

院系：
<span class="style3">院系</span></td>[\s\S]+?</td> 
(?<=&nbsp;).+(?=</td>)

入学年：
<span class="style3">入学年</span></td>[\s\S]+?</td> 
(?<=&nbsp;).+(?=</td>)

专业：
<span class="style3">专业</span></td>[\s\S]+?</td> 
(?<=&nbsp;).+(?=</td>)

年级：
<span class="style3">年级</span></td>[\s\S]+?</td> 
(?<=&nbsp;).+(?=</td>)

班级：
<span class="style3">班级</span></td>[\s\S]+?</td> 
(?<=&nbsp;).+(?=</td>)

培养层次：
<span class="style3">培养层次</span></td>[\s\S]+?</td> 
(?<=&nbsp;).+(?=</td>)
```