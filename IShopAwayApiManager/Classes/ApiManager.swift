//
//  ApiManager.swift
//  PersonalShopper
//
//  Created by James Rhodes on 5/15/16.
//  Copyright © 2016 James Rhodes. All rights reserved.
//

import UIKit
import Alamofire
import SwiftyJSON
import ObjectMapper
import AlamofireObjectMapper

struct UpdateMarket {
    let marketId: String
    let name: String
    let about: String
    let personalShopperId: String
    
    func parameterize() -> [String : AnyObject] {
        let parameters = [
            "name": name,
            "about": about,
            "personal_shopper_id": personalShopperId
        ]
        
        return parameters
    }
}
struct CreatePersonalShopper {
    let firstName: String
    let lastName: String
    let emailAddress: String
    var avatarUrl: String?
    var facebookProfile: AnyObject?
    
    init(firstName: String, lastName: String, emailAddress: String) {
        self.firstName = firstName
        self.lastName = lastName
        self.emailAddress = emailAddress
    }
    func parameterize() -> [String : AnyObject] {
        var parameters: [String: AnyObject] = [
            "first_name": firstName,
            "last_name": lastName,
            "email_address": emailAddress,
            ]
        
        if let avatarUrl = avatarUrl {
            parameters["avatar_url"] = avatarUrl
        }
        if let facebookProfile = facebookProfile {
            parameters["facebook_profile"] = facebookProfile
        }
        
        return parameters
    }
}
struct RegisterForPushNotifications {
    let personalShopper: PersonalShopper
    let apn_device_token: String
    
    func parameterize() -> [String : AnyObject] {
        let parameters = [
            "apn_device_token": apn_device_token
        ]
        
        return parameters
    }
}
struct CreatePurchaseRequest {
    let amount: NSDecimalNumber
    let shoppingSession: ShoppingSession
    let productSize: ProductSize
    
    func parameterize() -> [String : AnyObject] {
        guard let shoppingSessionId = shoppingSession.id else {
            fatalError("Attempted to create a purchase request with no Shopping Session")
        }
        
        let parameters = [
            "shopping_session_id": shoppingSessionId,
            "amount": amount,
            "product_size": productSize.rawValue
        ]
        
        return parameters
    }
}
struct CreateCheckoutRequest {
    let amount: NSDecimalNumber
    let shoppingSessionId: String
    
    func parameterize() -> [String : AnyObject] {
        let parameters = [
            "shopping_session_id": shoppingSessionId,
            "local_checkout_amount": amount
        ]
        
        return parameters
    }
}
class PersonalShopperApiManager {
    static let kApiBaseUrl = "http://localhost:8080/api/"
    //static let kApiBaseUrl = "http://192.168.1.124:8080/api/"
    
    static func getShoppingSession(shoppingSessionId: String, success: (response: ShoppingSession) -> Void, failure: (error: ErrorType?) -> Void) {
        Alamofire.request(.GET,  kApiBaseUrl + "shopping_sessions/\(shoppingSessionId)")
            .responseObject { (response: Response<ShoppingSession, NSError>) in
                if let error = response.result.error {
                    failure(error: error)
                }
                if let shoppingSession = response.result.value {
                    success(response: shoppingSession)
                }
                
        }
    }
    static func getMarkets(success: (response: [Market]?) -> Void, failure: (ErrorType?) -> Void) {
        Alamofire.request(.GET,  kApiBaseUrl + "markets")
            .responseArray { (response: Response<[Market], NSError>) in
                if let error = response.result.error {
                    failure(error)
                }
                if let markets = response.result.value {
                    success(response: markets)
                }
            }
    
    }
    static func getPurchaseRequest(purchaseRequest: PurchaseRequest, success: (response: PurchaseRequest?) -> Void, failure: (ErrorType?) -> Void) {
        Alamofire.request(.GET,  kApiBaseUrl + "purchase_requests/\(purchaseRequest.id)")
            .responseObject { (response: Response<PurchaseRequest, NSError>) in
                if let error = response.result.error {
                    failure(error)
                }
                if let purchaseRequest = response.result.value {
                    success(response: purchaseRequest)
                }
        }
    }
    static func getCheckoutRequest(checkoutRequest: CheckoutRequest, success: (response: CheckoutRequest?) -> Void, failure: (ErrorType?) -> Void) {
        Alamofire.request(.GET,  kApiBaseUrl + "checkout_requests/\(checkoutRequest.id)")
            .responseObject { (response: Response<CheckoutRequest, NSError>) in
                if let error = response.result.error {
                    failure(error)
                }
                if let checkoutRequest = response.result.value {
                    success(response: checkoutRequest)
                }
        }
    }
    static func updateMarket(updateMarket: UpdateMarket, success: (response: Market?) -> Void, failure: (ErrorType?) -> Void) {
        let params = updateMarket.parameterize()
        
        Alamofire.request(.PUT, PersonalShopperApiManager.kApiBaseUrl + "markets/\(updateMarket.marketId)", parameters: params, encoding: .JSON)
            .responseObject { (response: Response<Market, NSError>) in
                if let error = response.result.error {
                    failure(error)
                }
                if let market = response.result.value {
                    success(response: market)
                }
                
        }
    }
    static func createPersonalShopper(createPersonalShopper: CreatePersonalShopper, success: (response: PersonalShopper?) -> Void, failure: (error: ErrorType?, json: JSON?) -> Void) {
        let params = createPersonalShopper.parameterize()
        
        Alamofire.request(.POST, PersonalShopperApiManager.kApiBaseUrl + "personal_shoppers", parameters: params, encoding: .JSON)
            .validate()
            .responseObject { (response: Response<PersonalShopper, NSError>) in
                if let error = response.result.error {
                    if let responseData = response.data {
                        let jsonResults:JSON = JSON(data: responseData)
                
                        failure(error: error, json: jsonResults)
                    } else {
                        failure(error: error, json: nil)
                    }
                }
                if let personalShopper = response.result.value {
                    success(response: personalShopper)
                }
    
        }
    }
    static func registerForPushNotifications(registerForPushNotifications: RegisterForPushNotifications, success: (response: PersonalShopper) -> Void, failure: (ErrorType?) -> Void) {
        let params = registerForPushNotifications.parameterize()
        
        guard let personalShopperId = registerForPushNotifications.personalShopper.id else {
            return
        }
        Alamofire.request(.POST, PersonalShopperApiManager.kApiBaseUrl + "personal_shoppers/\(personalShopperId)/register_device", parameters: params, encoding: .JSON)
            .responseObject { (response: Response<PersonalShopper, NSError>) in
                if let error = response.result.error {
                    failure(error)
                }
                if let personalShopper = response.result.value {
                    success(response: personalShopper)
                }
                
        }
    }
    static func publishFeed(shoppingSessionId: String, success: (response: ShoppingSession) -> Void, failure: (ErrorType?) -> Void) {
        Alamofire.request(.POST, PersonalShopperApiManager.kApiBaseUrl + "shopping_sessions/" + shoppingSessionId + "/publish")
            .responseObject { (response: Response<ShoppingSession, NSError>) in
                if let error = response.result.error {
                    failure(error)
                }
                if let shoppingSession = response.result.value {
                    success(response: shoppingSession)
                }
                
        }
    }
    static func createPurchaseRequest(createPurchaseRequest: CreatePurchaseRequest, success: (response: PurchaseRequest?) -> Void, failure: (ErrorType?) -> Void) {
        let params = createPurchaseRequest.parameterize()
        
        Alamofire.request(.POST, PersonalShopperApiManager.kApiBaseUrl + "purchase_requests", parameters: params, encoding: .JSON)
            .responseObject { (response: Response<PurchaseRequest, NSError>) in
                if let error = response.result.error {
                    failure(error)
                }
                if let purchaseRequest = response.result.value {
                    success(response: purchaseRequest)
                }
                
        }
    }
    static func createCheckoutRequest(createCheckoutRequest: CreateCheckoutRequest, success: (response: CheckoutRequest?) -> Void, failure: (error: ErrorType?) -> Void) {
        let params = createCheckoutRequest.parameterize()
        
        Alamofire.request(.POST, PersonalShopperApiManager.kApiBaseUrl + "checkout_requests", parameters: params, encoding: .JSON)
            .responseObject { (response: Response<CheckoutRequest, NSError>) in
                if let error = response.result.error {
                    failure(error: error)
                }
                if let checkoutRequest = response.result.value {
                    success(response: checkoutRequest)
                }
                
        }
    }
}