//
//  Market.swift
//  PersonalShopper
//
//  Created by James Rhodes on 5/17/16.
//  Copyright © 2016 James Rhodes. All rights reserved.
//

import Foundation
import ObjectMapper

public class Market: Mappable {
    var id: String?
    var name: String
    var about: String
    var personalShopper: PersonalShopper?

    init(name: String, about: String) {
        self.name = name
        self.about = about
    }
    public required init?(_ map: Map){
        self.name = ""
        self.about = ""
    }
    
    public func mapping(map: Map) {
        id <- map["_id"]
        name <- map["name"]
        about <- map["about"]
        personalShopper <- map["personal_shopper"]
    }
}
