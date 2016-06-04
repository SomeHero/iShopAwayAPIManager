//
//  PurchaseRequest.swift
//  PersonalShopper
//
//  Created by James Rhodes on 5/19/16.
//  Copyright © 2016 James Rhodes. All rights reserved.
//

import Foundation
import ObjectMapper

public class PurchaseRequest: Mappable {
    var id: String!
    var shoppingSession: ShoppingSession!
    var amount: NSDecimalNumber!
    var status: String!
    
    init(shoppingSession: ShoppingSession, amount: NSDecimalNumber) {
        self.shoppingSession = shoppingSession
        self.amount = amount
        self.status = "Pending"
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