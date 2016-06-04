//
//  Shopper.swift
//  PersonalShopper
//
//  Created by James Rhodes on 5/16/16.
//  Copyright © 2016 James Rhodes. All rights reserved.
//

import Foundation
import ObjectMapper

public class Shopper: Mappable {
    static var sharedShopper: Shopper?
    
    var id: String?
    var firstName: String
    var lastName: String
    var emailAddress: String
    var apnDeviceToken: String?
    
    init(firstName: String, lastName: String, emailAddress: String) {
        self.firstName = firstName
        self.lastName = lastName
        self.emailAddress = emailAddress
    }
    public required init?(_ map: Map){
        self.firstName = ""
        self.lastName = ""
        self.emailAddress = ""
    }
    
    public func mapping(map: Map) {
        id <- map["_id"]
        firstName <- map["first_name"]
        lastName <- map["last_name"]
        emailAddress <- map["email_address"]
        apnDeviceToken <- map["apn_device_token"]
    }
}