//
//  Logger.swift
//  InfoSpaceX
//
//  Created by Sagar Thapa on 11/8/19.
//  Copyright © 2019 Tenhaff. All rights reserved.
//

import Foundation

enum LogEvent: String {
    case e = "[❗️]" //error
    case i = "[ℹ️]" //info
    case d = "[💬]" //debug
    case v = "[🔬]" //verbose
    case w = "[⚠️]" //warning
    case s = "[🔥]" //severe
    
}

class Logger{
    private class func sourceFileName(filePath: String) -> String {
        let components = filePath.components(separatedBy: "/")
        return components.isEmpty ? "" : components.last!
    }
    
    class func log(message: String, event: LogEvent, fileName: String = #file, line: Int = #line, funcname: String = #function) {
        #if DEBUG
        print("\(event.rawValue) [\(sourceFileName(filePath: fileName))]: \(line) \(funcname) -> \(message)")
        #endif
    }
}
