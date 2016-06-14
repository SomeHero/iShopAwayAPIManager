//
//  ShoppingSession.swift
//  PersonalShopper
//
//  Created by James Rhodes on 5/16/16.
//  Copyright © 2016 James Rhodes. All rights reserved.
//

import Foundation
import ObjectMapper

public class ShoppingSession: Mappable  {
    public static var sharedShoppingSession: ShoppingSession?
    
    public var id: String?
    public var shopper: Shopper?
    public var openTokSessionId: String?
    public var openTokToken: String?
    public var personalShopper: PersonalShopper?
    public var cart: [CartItem]!
    
    public init(shopper: Shopper, openTokSessionId: String, openTokToken: String) {
        self.shopper = shopper
        self.openTokSessionId = openTokSessionId
        self.openTokToken = openTokToken
    }
    public required init?(_ map: Map){
        mapping(map)
    }
    
    public func mapping(map: Map) {
        id <- map["_id"]
        shopper <- map["shopper"]
        openTokSessionId <- map["opentok_session_id"]
        openTokToken <- map["opentok_token"]
        personalShopper <- map["personal_shopper"]
        cart <- map["cart"]
    }
}
public class CartItem: Mappable {
    public var itemName: String!
    public var itemLocalCost: NSDecimalNumber!
    public var itemShopperPrice: NSDecimalNumber!
    
    public init(itemName: String, itemLocalCost: NSDecimalNumber, itemShopperPrice: NSDecimalNumber) {
        self.itemName = itemName
        self.itemLocalCost = itemLocalCost
        self.itemShopperPrice = itemShopperPrice
    }
    public required init?(_ map: Map){
        mapping(map)
    }
    
    public func mapping(map: Map) {
        self.itemName <- map["item_name"]
        self.itemLocalCost <- (map["item_local_cost"], NSDecimalNumberTransform())
        self.itemShopperPrice <- (map["item_shopper_price"], NSDecimalNumberTransform())
    }
}