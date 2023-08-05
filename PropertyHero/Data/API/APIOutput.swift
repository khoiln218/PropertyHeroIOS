//
//  APIOutput.swift
//  PropertyHero
//
//  Created by KHOI LE on 8/5/23.
//

import ObjectMapper
import MGAPIService

class APIOutput: APIOutputBase {  // swiftlint:disable:this final_class
    var message: String?
    
    override func mapping(map: Map) {
        message <- map["message"]
    }
}
