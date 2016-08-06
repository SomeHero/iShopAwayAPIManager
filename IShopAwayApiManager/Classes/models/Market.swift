//
//  Market.swift
//  PersonalShopper
//
//  Created by James Rhodes on 5/17/16.
//  Copyright © 2016 James Rhodes. All rights reserved.
//

import Foundation
import ObjectMapper

public class Market: Mappable {
    public var id: String?
    public var name: String
    public var mainImageUrl: String?
    public var about: String
    public var personalShopper: PersonalShopper?
    public var products: [Product]

    public init(name: String, about: String) {
        self.name = name
        self.about = about
        self.products = []
    }
    public required init?(_ map: Map){
        self.name = ""
        self.about = ""
        self.products = []
    }
    
    public func mapping(map: Map) {
        id <- map["_id"]
        name <- map["name"]
        about <- map["description"]
        mainImageUrl <- map["main_image_url"]
        products <- map["products"]
    }
}
public class Product: Mappable {
    public var name: String!
    public var images: Dictionary<String, String>? = [:]
    
    public init(name: String, images: Dictionary<String, String>) {
        self.name = name
        self.images = images
    }
    public required init?(_ map: Map){
        self.name = ""
    }
    
    public func mapping(map: Map) {
        name <- map["product_name"]
        images <- map["images"]
    }
}
