//
//  PaymentMethod.swift
//  Pods
//
//  Created by James Rhodes on 6/21/16.
//
//

import Foundation
import ObjectMapper

public class PaymentMethod: Mappable {
    public var id: String!
    public var type: String!
    public var cardType: String!
    public var cardLastFour: String!
    public var expirationMonth: Int!
    public var expirationYear: Int!
    public var isDefault: Bool = false
    
    public init(type: String, cardType: String, cardLastFour: String, expirationMonth: Int, expirationYear: Int, isDefault: Bool) {
        self.type = type
        self.cardType = cardType
        self.cardLastFour = cardLastFour
        self.expirationMonth = expirationMonth
        self.expirationYear = expirationYear
    }
    public required init?(_ map: Map){
        mapping(map)
    }
    
    public func mapping(map: Map) {
        id <- map["_id"]
        type <- map["type"]
        cardType <- map["card_info.card_type"]
        cardLastFour <- map["card_info.card_last_four"]
        expirationMonth <- map["card_info.expiration_month"]
        expirationYear <- map["card_info.expiration_year"]
        isDefault <- map["is_default"]
    }
}
