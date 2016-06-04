//
//  CheckoutRequest.swift
//  PersonalShopper
//
//  Created by James Rhodes on 5/21/16.
//  Copyright © 2016 James Rhodes. All rights reserved.
//

import Foundation
import ObjectMapper

public class CheckoutRequest: Mappable {
    public var id: String!
    public var shoppingSession: ShoppingSession!
    public var amount: Double!
    public var status: String!
    
    public init(shoppingSession: ShoppingSession, amount: Double) {
        self.shoppingSession = shoppingSession
        self.amount = amount
        self.status = "New"
    }
    public required init?(_ map: Map){
        mapping(map)
    }
    
    public func mapping(map: Map) {
        id <- map["_id"]
        shoppingSession <- map["shopping_session"]
        amount <- map["amount"]
        status <- map["status"]
    }
}