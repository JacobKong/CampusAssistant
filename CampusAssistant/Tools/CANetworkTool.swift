//
//  CANetworkTool.swift
//  CampusAssistant
//
//  Created by Encode.X on 16/5/17.
//  Copyright © 2016年 com.jacob. All rights reserved.
//

import UIKit
import Alamofire

class CANetworkTool: NSObject {
    class func getAAOCookies()->NSHTTPCookie?{
        let cookies:[NSHTTPCookie] = NSHTTPCookieStorage.sharedHTTPCookieStorage().cookiesForURL(NSURL(string:"http://202.118.31.197")!)!
        
        for cookie in cookies{
            if(cookie.name=="JSESSIONID"){
                return cookie
            }
        }
        
        return nil
    }
    
    class func setAAOCookies(value:String){
        var cookieProperties = [String: AnyObject]()
        cookieProperties[NSHTTPCookieName] = "JSESSIONID"
        cookieProperties[NSHTTPCookieValue] = value
        cookieProperties[NSHTTPCookieDomain] = "202.118.31.197"
        cookieProperties[NSHTTPCookiePath] = "/"
        
        var cookies:[NSHTTPCookie] = Array()
        let cookie = NSHTTPCookie.init(properties: cookieProperties)
        cookies.append(cookie!)
        
        Alamofire.Manager.sharedInstance.session.configuration.HTTPCookieStorage?.setCookies(cookies, forURL: NSURL.init(string:"http://202.118.31.197"), mainDocumentURL: nil)
    }
}
