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
    public var name: String!
    public var amount: NSDecimalNumber!
    public var productUrl: String!
    public var status: String!
    
    public init(shoppingSession: ShoppingSession, name: String, amount: NSDecimalNumber, productUrl: String) {
        self.shoppingSession = shoppingSession
        self.name = name
        self.amount = amount
        self.productUrl = productUrl
        self.status = "Pending"
    }
    public required init?(_ map: Map){
        mapping(map)
    }
    public func mapping(map: Map) {
        id <- map["_id"]
        shoppingSession <- map["shopping_session"]
        name <- map["item_name"]
        amount <- (map["shopper_amount"], NSDecimalNumberTransform())
        productUrl <- map["image_url"]
        status <- map["status"]
    }
}