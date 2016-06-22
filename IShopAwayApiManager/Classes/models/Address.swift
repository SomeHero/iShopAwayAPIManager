//
//  ShippingAddress.swift
//  Pods
//
//  Created by James Rhodes on 6/22/16.
//
//

import Foundation
import ObjectMapper

public class Address: Mappable {
    public var id: String!
    public var name: String!
    public var address1: String!
    public var address2: String!
    public var city: String!
    public var stateProvince: String!
    public var country: String!
    public var postalCode: String!

    public init(name: String, address1: String, address2: String, city: String, stateProvince: String, country: String, postalCode: String) {
        self.name = name
        self.address1 = address1
        self.address2 = address2
        self.city = city
        self.stateProvince = stateProvince
        self.country = country
        self.postalCode = postalCode
    }
    public required init?(_ map: Map){
        mapping(map)
    }
    
    public func mapping(map: Map) {
        id <- map["_id"]
        name <- map["name"]
        address1 <- map["address_1"]
        address2 <- map["address_2"]
        city <- map["city"]
        stateProvince <- map["state_province"]
        country <- map["country"]
        postalCode <- map["postal_code"]
    }
}