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
        r_value.replaceAllMatching("(<br>)+", with: "<br>")
        
        var rg:Regex = Regex("<tr style=\"height:100px\">([\\s\\S]*?)</tr>")
        
        var r_second:[MatchResult] = rg.allMatches(r_value)
        var r_set:[String] = Array()
        var r_third:[String] = Array()
        var r_result:[[String]] = Array()
        
        rg = Regex("<td valign=\"top\"(.+?)</td>")
        
        for(var i=0;i<r_second.count;i+=1){
            r_set.append(r_second[i].matchedString)
            r_set[i].replaceAllMatching("\\\\", with: "")
            
            let r_m = rg.allMatches(r_set[i])
            for(var j=0;j<r_m.count;j += 1){
                r_third.append(r_m[j].matchedString)
            }
        }
        
        for(var i=0;i<42;i += 1){
            r_third[i].replaceAllMatching("<td valign=\"top\".+?>|</td>", with: "")
        }
        
        rg = Regex("^.+?节(?=<br>)|(?<=<br>).+?节(?=<br>)|(?<=<br>).+?节$|^.+?节$")
        
        for(var i=0;i<42;i += 1){
            r_result.append(Array())
            if(r_third[i] == "&nbsp;"){
                continue
            }
            
            r_second = rg.allMatches(r_third[i])
            for(var j=0;j<r_second.count;j += 1){
                r_result[i].append(r_second[j].matchedString)
            }
        }
        
        rg = Regex("^.+?(?=<br>)|(?<=<br>).+?(?=<br>)|(?<=<br>).+?$")
        
        for(var i=0;i<42;i++){
            if(r_result[i].count==0){
                continue
            }
            
            let c = r_result[i].count
            for(var j=0;j<c;j++){
                r_second = rg.allMatches(r_result[i][0])
                for(var k=0;k<r_second.count;k++){
                    r_result[i].append(r_second[k].matchedString)
                }
                r_result[i].removeFirst()
            }
        }
        
        return r_result
    }
}
