//
//  ShoppingSession.swift
//  PersonalShopper
//
//  Created by James Rhodes on 5/16/16.
//  Copyright © 2016 James Rhodes. All rights reserved.
//

import Foundation
import ObjectMapper

class ShoppingSession: Mappable  {
    static var sharedShoppingSession: ShoppingSession?
    
    var id: String?
    var shopper: Shopper?
    var openTokSessionId: String?
    var openTokToken: String?
    var cart: [CartItem]!
    
    init(shopper: Shopper, openTokSessionId: String, openTokToken: String) {
        self.shopper = shopper
        self.openTokSessionId = openTokSessionId
        self.openTokToken = openTokToken
    }
    required init?(_ map: Map){
        mapping(map)
    }
    
    func mapping(map: Map) {
        id <- map["_id"]
        shopper <- map["shopper"]
        openTokSessionId <- map["opentok_session_id"]
        openTokToken <- map["opentok_token"]
        cart <- map["cart"]
    }
}
class CartItem: Mappable {
    var itemName: String!
    var itemLocalCost: NSDecimalNumber!
    var itemShopperPrice: NSDecimalNumber!
    
    init(itemName: String, itemLocalCost: NSDecimalNumber, itemShopperPrice: NSDecimalNumber) {
        self.itemName = itemName
        self.itemLocalCost = itemLocalCost
        self.itemShopperPrice = itemShopperPrice
    }
    required init?(_ map: Map){
        mapping(map)
    }
    
    func mapping(map: Map) {
        self.itemName <- map["item_name"]
        self.itemLocalCost <- (map["item_local_cost"], NSDecimalNumberTransform())
        self.itemShopperPrice <- (map["item_shopper_price"], NSDecimalNumberTransform())
    }
}