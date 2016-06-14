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
    public var id: String!
    public var shoppingSession: ShoppingSession!
    public var amount: NSDecimalNumber!
    public var status: String!
    
    public init(shoppingSession: ShoppingSession, amount: NSDecimalNumber) {
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
        amount <- (map["shopper_amount"], NSDecimalNumberTransform())
        status <- map["status"]
    }
}