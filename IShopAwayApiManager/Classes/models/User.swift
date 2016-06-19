//
//  User.swift
//  User
//
//  Created by James Rhodes on 5/16/16.
//  Copyright © 2016 James Rhodes. All rights reserved.
//

import Foundation
import ObjectMapper

public class User: Mappable {
    public static var sharedUser: User?
    
    public var id: String?
    public var firstName: String
    public var lastName: String
    public var emailAddress: String

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
    }
    public func persistUser() {
        guard let user = User.sharedUser else {
            return
        }
        
        let userDefaults = NSUserDefaults.standardUserDefaults()
        
        userDefaults.setValuesForKeysWithDictionary([
            "id": user.id!,
            "first_name": user.firstName,
            "last_name": user.lastName,
            "email_address": user.emailAddress
        ])
        
        userDefaults.synchronize()
    }
    public static func getPersistedUser() -> User? {
        let userDefaults = NSUserDefaults.standardUserDefaults()
        
        guard let id = userDefaults.stringForKey("id") else {
            return nil
        }
        let firstName = userDefaults.stringForKey("first_name")!
        let lastName = userDefaults.stringForKey("last_name")!
        let emailAddress = userDefaults.stringForKey("email_address")!
        
        let user = User(firstName: firstName, lastName: lastName, emailAddress: emailAddress)
        user.id = id
        
        return user
    }
}