//
//  PersonalShopper.swift
//  PersonalShopper
//
//  Created by James Rhodes on 5/16/16.
//  Copyright © 2016 James Rhodes. All rights reserved.
//
import Foundation
import ObjectMapper

public class PersonalShopper: Mappable {
    public static var sharedPersonalShopper: PersonalShopper?
    
    public var id: String?
    public var firstName: String
    public var lastName: String
    public var emailAddress: String
    public var apnDeviceToken: String?
    
    public init(firstName: String, lastName: String, emailAddress: String) {
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
    public static func persistUser() {
        guard let personalShopper = PersonalShopper.sharedPersonalShopper else {
            return
        }
        
        let userDefaults = NSUserDefaults.standardUserDefaults()
        
        userDefaults.setValuesForKeysWithDictionary([
            "id": personalShopper.id!,
            "first_name": personalShopper.firstName,
            "last_name": personalShopper.lastName,
            "email_address": personalShopper.emailAddress
        ])
        
        userDefaults.synchronize()
    }
    public  static func getPersistedUser() -> PersonalShopper? {
        let userDefaults = NSUserDefaults.standardUserDefaults()
        
        guard let id = userDefaults.stringForKey("id") else {
            return nil
        }
        let firstName = userDefaults.stringForKey("first_name")!
        let lastName = userDefaults.stringForKey("last_name")!
        let emailAddress = userDefaults.stringForKey("email_address")!

        let personalShopper = PersonalShopper(firstName: firstName, lastName: lastName, emailAddress: emailAddress)
        personalShopper.id = id
        if let apnDeviceToken = userDefaults.stringForKey("apn_device_token") {
            personalShopper.apnDeviceToken = apnDeviceToken
        }
        
        return personalShopper
    }
}