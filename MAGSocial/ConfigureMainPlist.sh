#!/usr/bin/env xcrun --sdk macosx swift

import Foundation


let projectDir = CommandLine.arguments[1]
let projectName = CommandLine.arguments[2]
let socialPlist = CommandLine.arguments[3]
let mainPlist = CommandLine.arguments[4]


enum ErrorType: Int {
    case fileNotFound
}


func exit(with errorType: ErrorType, message: String?) {
    print("\(errorType) \(message ?? "")")
    abort()
}






let pathFrom = "\(projectDir)/\(projectName)/\(socialPlist)"
let pathTo = "\(projectDir)/\(mainPlist)"


guard let dictFrom = NSDictionary(contentsOfFile: pathFrom) as? [String: [String: Any]] else {
    exit(with: .fileNotFound, message: pathFrom)
    abort()
}

guard var dictTo = NSDictionary(contentsOfFile: pathTo) as? [String: Any] else {
    exit(with: .fileNotFound, message: pathTo)
    abort()
}


let URLTypesKey = "CFBundleURLTypes"
let QueriesSchemesKey = "LSApplicationQueriesSchemes"


var URLTypesResult: [[String: Any]] = {
    if let result = dictTo[URLTypesKey] as? [[String: Any]] {
        return result
    }
    else {
        return []
    }
}()

var QueriesSchemesResult: [String] = {
    if let result = dictTo[QueriesSchemesKey] as? [String] {
        return result
    }
    else {
        return []
    }
}()




for (_, socialSettings) in dictFrom {
    if let urlScheme = socialSettings["CFBundleURLScheme"] as? String {
        
        let exist = !URLTypesResult.filter {
            if let schemes = $0["CFBundleURLSchemes"] as? [String], schemes.contains(urlScheme) {
                return true
            }
            else {
                return false
            }
        }.isEmpty
        
        if !exist {
            let newScheme: [String : Any] = ["CFBundleTypeRole": "Editor",
                                             "CFBundleURLSchemes": [urlScheme]]
            URLTypesResult.append(newScheme)
        }
        
    }
    
    if let queriesSchemes = socialSettings[QueriesSchemesKey] as? [String] {
        for queryScheme in queriesSchemes {
            if !QueriesSchemesResult.contains(queryScheme) {
                QueriesSchemesResult.append(queryScheme)
            }
        }
    }
}


dictTo[URLTypesKey] = URLTypesResult
dictTo[QueriesSchemesKey] = QueriesSchemesResult

(dictTo as NSDictionary).write(toFile: pathTo, atomically: true)
