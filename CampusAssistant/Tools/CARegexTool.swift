//
//  CARegexTool.swift
//  CampusAssistant
//
//  Created by Encode.X on 16/5/11.
//  Copyright © 2016年 com.jacob. All rights reserved.
//

import UIKit
import Regex

class CARegexTool: NSObject {
    class func parseCourseTable(response:String) -> [[String]]{
        var r_value:String! = response
        
        r_value.replaceAllMatching("<br style=\"mso-data-placement:same-cell\">", with: "<br>")
//        r_value.replaceAllMatching("(<br>)+", with: "<br>")
        
        var rg:Regex = Regex("<tr style=\"height:100px\">([\\s\\S]*?)</tr>")
        
        var r_second:[MatchResult] = rg.allMatches(r_value)
        var r_set:[String] = Array()
        var r_third:[String] = Array()
        var r_result:[[String]] = Array()
        
        rg = Regex("<td valign=\"top\"(.+?)</td>")
        
        for i in 0..<r_second.count {
            r_set.append(r_second[i].matchedString)
            r_set[i].replaceAllMatching("\\\\", with: "")
            
            let r_m = rg.allMatches(r_set[i])
            for j in 0..<r_m.count {
                r_third.append(r_m[j].matchedString)
            }
        }
        
        for i in 0...41 {
            r_third[i].replaceAllMatching("<td valign=\"top\".+?>|</td>", with: "")
        }
        
        rg = Regex("^.+?节(?=<br>)|(?<=<br>).+?节(?=<br>)|(?<=<br>).+?节$|^.+?节$")
        
        for i in 0...41 {
            r_result.append(Array())
            if(r_third[i] == "&nbsp;"){
                continue
            }
            
            r_second = rg.allMatches(r_third[i])
            for j in 0 ..< r_second.count {
                r_result[i].append(r_second[j].matchedString)
            }
        }
        
        rg = Regex("^.+?(?=<br>)|(?<=<br>).*?(?=<br>)|(?<=<br>).+?$")
        
        for i in 0...41 {
            if(r_result[i].count==0){
                continue
            }
            
            let c = r_result[i].count
            for _ in 0..<c{
                r_second = rg.allMatches(r_result[i][0])
                for j in 0..<r_second.count {
                    r_result[i].append(r_second[j].matchedString)
                }
                r_result[i].removeFirst()
            }
        }
        
        return r_result
    }
    class func parseCourseWeekDescription(description:String) ->[[String]]{
        // 分析周数字符串
        // 首先按.分割
        // 分析各块 若是 <数字-数字>格式 则创建带循环的事件
        // 若是<数字>格式 则创建单一事件
        var r_result:[[String]] = Array()
        let r_value = description
        var r_pattern:Regex = Regex("^.+?(?=\\.)|(?<=\\.).+?(?=\\.)|(?<=\\.).+?(?=周)|^.+?(?=周)")
        var r_matches:[MatchResult] = r_pattern.allMatches(r_value)
        
        for i in 0..<r_matches.count {
            r_result.append(Array())
            r_result[i].append(r_matches[i].matchedString)
        }
        
        r_pattern = Regex("\\d+-\\d+")
        
        for i in 0..<r_result.count {
            if(r_pattern.matches(r_result[i][0])){
                r_matches = Regex("\\d+").allMatches(r_result[i][0])
                for match in r_matches {
                    r_result[i].append(match.matchedString)
                }
                r_result[i].removeFirst()
            }
        }
        
        return r_result
    }

    class func parseGradeTermList(response:String)->[[String]]{
        var r_result:[[String]] = Array()
        let r_value:String = response
        var r_pattern:Regex = Regex("(?<=(<option value=\")).+?((?=\" selected>)|(?=\">))")
        var r_matches:[MatchResult] = r_pattern.allMatches(r_value)

        for i in 0..<r_matches.count {
            r_result.append(Array())
            r_result[i].append(r_matches[i].matchedString)
        }
        
        r_pattern = Regex("((?<=(\">))|(?<=(selected>))).+?(?=</option>)")
        r_matches = r_pattern.allMatches(r_value)
        
        for i in 0..<r_matches.count {
            r_result[i].append(r_matches[i].matchedString)
        }

        return r_result
    }

    class func parseGradeTable(response:String)->[[String]]{
        var r_result:[[String]] = Array()
        let r_value:String = response
        var r_pattern:Regex = Regex("(?<=平均学分绩点：).+")
        var r_matches:[MatchResult] = r_pattern.allMatches(r_value)
        
        r_result.append(Array())
        r_result[0].append(r_matches[0].matchedString)
        
        /*\
            ↑GPA↑
            ↓表单↓
        \*/
        
        r_pattern = Regex("((?<=color-row\">)|(?<=color-rowNext\">))[\\s\\S]+?(?=</tr>)")
        r_matches = r_pattern.allMatches(r_value)
        
        r_pattern = Regex("((?<=p;)|(?<=r\" nowrap>)).*?(?=</td>)")
        
        for i in 0..<r_matches.count {
            let t_string = r_matches[i].matchedString
            var t_matches:[MatchResult] = r_pattern.allMatches(t_string)
            
            if(t_matches[0].matchedString=="&nbsp;" || t_matches[0].matchedString==""){
                continue
            }
            
            r_result.append(Array())
            
            for j in 0..<t_matches.count {
                r_result[i+1].append(t_matches[j].matchedString)
            }
        }

        return r_result
    }
    
    class func parseExamTable(response:String)->[[String]]{
        var r_result:[[String]] = Array()
        let r_value:String = response
        var r_pattern:Regex = Regex("((?<=color-row\">)|(?<=color-rowNext\">))[\\s\\S]+?(?=</tr>)")
        var r_matches:[MatchResult] = r_pattern.allMatches(r_value)
        
        r_pattern = Regex("(?<=>).*?(?=</td>)")
        
        for i in 0..<r_matches.count {
            var t_string = r_matches[i].matchedString
            var t_matches:[MatchResult] = r_pattern.allMatches(t_string)
            
            if(t_matches[0].matchedString=="&nbsp;"){
                continue
            }
            
            r_result.append(Array())
            
            for j in 0..<t_matches.count {
                t_string = t_matches[j].matchedString
                t_string.replaceAllMatching("&nbsp;", with: "")
                
                r_result[i].append(t_string)
            }
        }
        
        return r_result
    }
    
    class func parseCreditTable(response:String)->[[String]]{
        var r_result:[[String]] = Array()
        let r_value:String = response
        var r_pattern:Regex = Regex("((?<=color-row\">)|(?<=color-rowNext\">))[\\s\\S]+?(?=</tr>)")
        var r_matches:[MatchResult] = r_pattern.allMatches(r_value)
        
        r_pattern = Regex("((?<=>)).+?(?=</td>)|(?<=\">\\r\\n).+?(?=\\r\\n.+</a>)")
        
        for i in 0..<r_matches.count {
            var t_string = r_matches[i].matchedString
            var t_matches:[MatchResult] = r_pattern.allMatches(t_string)
            
            r_result.append(Array())
            
            for j in 0..<t_matches.count {
                t_string = t_matches[j].matchedString
                t_string.replaceAllMatching("[\\n\\r\\s]", with: "")
                
                r_result[i].append(t_string)
            }
        }
        
        return r_result
    }
    
    class func parseEmptyClassroomTable(response:String)->[[String]]{
        var r_result:[[String]] = Array()
        let r_value:String = response
        var r_pattern:Regex = Regex("((?<=color-row\">)|(?<=color-rowNext\">))[\\s\\S]+?(?=</tr>)")
        var r_matches:[MatchResult] = r_pattern.allMatches(r_value)
        
        r_pattern = Regex("(?<=>).*?(?=</td>)")
        
        for i in 0..<r_matches.count {
            var t_string = r_matches[i].matchedString
            var t_matches:[MatchResult] = r_pattern.allMatches(t_string)
            
            if(t_matches[0].matchedString=="&nbsp;"){
                continue
            }
            
            r_result.append(Array())
            
            for j in 0..<t_matches.count {
                t_string = t_matches[j].matchedString
                t_string.replaceAllMatching("&nbsp;", with: "")
                
                r_result[i].append(t_string)
            }
        }
        
        return r_result
    }
    
    class func parseEptClsrmTermList(response:String)->[[String]]{
        var r_result:[[String]] = Array()
        var r_value:String = response
        var r_pattern:Regex = Regex("<td.+学年学期</td>[\\s\\S]+?</td>")
        var r_matches:[MatchResult] = r_pattern.allMatches(r_value)
        
        r_value = r_matches[0].matchedString
        r_pattern = Regex("(?<=<option value=\").+?((?=\">)|(?=\" selected>))")
        r_matches = r_pattern.allMatches(r_value)
        
        for i in 0..<r_matches.count {
            r_result.append(Array())
            r_result[i].append(r_matches[i].matchedString)
        }
        
        r_pattern = Regex("((?<=\\d\" selected>)|(?<=\\d\">)).+?(?=</option>)")
        r_matches = r_pattern.allMatches(r_value)
        
        for i in 0..<r_matches.count {
            r_result[i].append(r_matches[i].matchedString)
        }
        
        return r_result
    }
    
    class func parseEptClsrmStoryList(response:String)->[[String]]{
        var r_result:[[String]] = Array()
        var r_value:String = response
        var r_pattern:Regex = Regex("<td.+教.+学.+楼</td>[\\s\\S]+?</td>")
        var r_matches:[MatchResult] = r_pattern.allMatches(r_value)
        
        r_value = r_matches[0].matchedString
        r_pattern = Regex("(?<=<option value=\").+?((?=\">)|(?=\" selected>))")
        r_matches = r_pattern.allMatches(r_value)
        
        for i in 0..<r_matches.count {
            r_result.append(Array())
            r_result[i].append(r_matches[i].matchedString)
        }
        
        r_pattern = Regex("((?<=\\d\" selected>)|(?<=\\d\">)).+?(?=</option>)")
        r_matches = r_pattern.allMatches(r_value)
        
        for i in 0..<r_matches.count {
            r_result[i].append(r_matches[i].matchedString)
        }
        
        return r_result
    }
    
    class func parseEptClsrmClsrmList(response:String)->[[String]]{
        var r_result:[[String]] = Array()
        var r_value:String = response
        var r_pattern:Regex = Regex("<td.+教.+室</td>[\\s\\S]+?</td>")
        var r_matches:[MatchResult] = r_pattern.allMatches(r_value)
        
        r_value = r_matches[0].matchedString
        r_pattern = Regex("(?<=<option value=\").+?((?=\">)|(?=\" selected>))")
        r_matches = r_pattern.allMatches(r_value)
        
        for i in 0..<r_matches.count {
            r_result.append(Array())
            r_result[i].append(r_matches[i].matchedString)
        }
        
        r_pattern = Regex("((?<=\\d\" selected>)|(?<=\\d\">)).+?(?=</option>)")
        r_matches = r_pattern.allMatches(r_value)
        
        for i in 0..<r_matches.count {
            r_result[i].append(r_matches[i].matchedString)
        }
        
        return r_result
    }
    
    class func parsePersonalInfoTable(response:String)->[String]{
        var r_result:[String] = Array()
        let r_value:String = response
        var r_pattern:Regex = Regex("<span class=\"style3\">学号</span></td>[\\s\\S]+?</td>")
        var r_matches:[MatchResult] = r_pattern.allMatches(r_value)
        var r_match:String = r_matches[0].matchedString
        
        r_pattern = Regex("(?<=&nbsp;)\\d+")
        r_matches = r_pattern.allMatches(r_match)
        r_result.append(r_matches[0].matchedString)
        
        r_pattern = Regex("<span class=\"style3\">姓名</span></td>[\\s\\S]+?</td>")
        r_matches = r_pattern.allMatches(r_value)
        r_match = r_matches[0].matchedString
        r_pattern = Regex("(?<=&nbsp;).+(?=</td>)")
        r_matches = r_pattern.allMatches(r_match)
        r_result.append(r_matches[0].matchedString)
        
        r_pattern = Regex("<span class=\"style3\">性别</span></td>[\\s\\S]+?</td>")
        r_matches = r_pattern.allMatches(r_value)
        r_match = r_matches[0].matchedString
        r_pattern = Regex("(?<=&nbsp;).+(?=</td>)")
        r_matches = r_pattern.allMatches(r_match)
        r_result.append(r_matches[0].matchedString)
        
        r_pattern = Regex("<span class=\"style3\">院系</span></td>[\\s\\S]+?</td>")
        r_matches = r_pattern.allMatches(r_value)
        r_match = r_matches[0].matchedString
        r_pattern = Regex("(?<=&nbsp;).+(?=</td>)")
        r_matches = r_pattern.allMatches(r_match)
        r_result.append(r_matches[0].matchedString)
        
        r_pattern = Regex("<span class=\"style3\">入学年</span></td>[\\s\\S]+?</td>")
        r_matches = r_pattern.allMatches(r_value)
        r_match = r_matches[0].matchedString
        r_pattern = Regex("(?<=&nbsp;).+(?=</td>)")
        r_matches = r_pattern.allMatches(r_match)
        r_result.append(r_matches[0].matchedString)
        
        r_pattern = Regex("<span class=\"style3\">专业</span></td>[\\s\\S]+?</td>")
        r_matches = r_pattern.allMatches(r_value)
        r_match = r_matches[0].matchedString
        r_pattern = Regex("(?<=&nbsp;).+(?=</td>)")
        r_matches = r_pattern.allMatches(r_match)
        r_result.append(r_matches[0].matchedString)
        
        r_pattern = Regex("<span class=\"style3\">年级</span></td>[\\s\\S]+?</td>")
        r_matches = r_pattern.allMatches(r_value)
        r_match = r_matches[0].matchedString
        r_pattern = Regex("(?<=&nbsp;).+(?=</td>)")
        r_matches = r_pattern.allMatches(r_match)
        r_result.append(r_matches[0].matchedString)
        
        r_pattern = Regex("<span class=\"style3\">班级</span></td>[\\s\\S]+?</td>")
        r_matches = r_pattern.allMatches(r_value)
        r_match = r_matches[0].matchedString
        r_pattern = Regex("(?<=&nbsp;).+(?=</td>)")
        r_matches = r_pattern.allMatches(r_match)
        r_result.append(r_matches[0].matchedString)
        
        r_pattern = Regex("<span class=\"style3\">培养层次</span></td>[\\s\\S]+?</td>")
        r_matches = r_pattern.allMatches(r_value)
        r_match = r_matches[0].matchedString
        r_pattern = Regex("(?<=&nbsp;).+(?=</td>)")
        r_matches = r_pattern.allMatches(r_match)
        r_result.append(r_matches[0].matchedString)
        
        return r_result
    }
}
