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

public enum ProductSize: Int {
    case Small
    case Medium
    case Large
    case XLarge
}
public struct AuthenticateUser {
    let emailAddress: String
    let password: String
    
    public init(emailAddress: String, password: String) {
        self.emailAddress = emailAddress
        self.password = password
    }
    func parameterize() -> [String : AnyObject] {
        let parameters = [
            "email_address": emailAddress,
            "password": password
        ]
        
        return parameters
    }
}
public struct CreateShoppingSession {
    let shopper_id: String
    let market_id: String
    
    public init(shopper_id: String, market_id: String) {
        self.shopper_id = shopper_id
        self.market_id = market_id
    }
    func parameterize() -> [String : AnyObject] {
        let parameters = [
            "shopper_id": shopper_id,
            "market_id": market_id
        ]
        
        return parameters
    }
}
public struct ShoppingSessionCheckout {
    let shoppingSession: ShoppingSession
    let stripeToken: String
    
    public init(shoppingSession: ShoppingSession, stripeToken: String) {
        self.shoppingSession = shoppingSession
        self.stripeToken = stripeToken
    }
    func parameterize() -> [String : AnyObject] {
        let parameters = [
            "stripe_token": stripeToken
        ]
        
        return parameters
    }
}
public struct CreateShopper {
    public let firstName: String
    public let lastName: String
    public let emailAddress: String
    public var avatarUrl: String?
    public var facebookProfile: AnyObject?
    
    public init(firstName: String, lastName: String, emailAddress: String) {
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
public struct UpdateShopper {
    let shopperId: String
    let firstName: String
    let lastName: String
    let emailAddress: String
    let stripeToken: String
    
    public init(shopperId: String, firstName: String, lastName: String, emailAddress: String, stripeToken: String) {
        self.shopperId = shopperId
        self.firstName = firstName
        self.lastName = lastName
        self.emailAddress = emailAddress
        self.stripeToken = stripeToken
    }
    func parameterize() -> [String : AnyObject] {
        let parameters = [
            "shopper_id": shopperId,
            "first_name": firstName,
            "last_name": lastName,
            "email_address": emailAddress,
            "stripe_token": stripeToken
        ]
        
        return parameters
    }
}
public struct RegisterShopperForPushNotifications {
    let shopper: Shopper
    let apn_device_token: String
    
    public init(shopper: Shopper, apn_device_token: String) {
        self.shopper = shopper
        self.apn_device_token = apn_device_token
    }
    func parameterize() -> [String : AnyObject] {
        let parameters = [
            "device_type": "iPhone",
            "token": apn_device_token
        ]
        
        return parameters
    }
}
public struct UpdateMarket {
    public let marketId: String
    public let name: String
    public let about: String
    public let personalShopperId: String
    
    public init(marketId: String, name: String, about: String, personalShopperId: String) {
        self.marketId = marketId
        self.name = name
        self.about = about
        self.personalShopperId = personalShopperId
    }
    func parameterize() -> [String : AnyObject] {
        let parameters = [
            "name": name,
            "about": about,
            "personal_shopper_id": personalShopperId
        ]
        
        return parameters
    }
}
public struct PersonalShopperCheckin {
    public let marketId: String
    public let personalShopperId: String
    
    public init(marketId: String, personalShopperId: String) {
        self.marketId = marketId
        self.personalShopperId = personalShopperId
    }
    func parameterize() -> [String : AnyObject] {
        let parameters = [
            "personal_shopper_id": personalShopperId
        ]
        return parameters
    }
}
public struct CreatePersonalShopper {
    public let firstName: String
    public let lastName: String
    public let emailAddress: String
    public var avatarUrl: String?
    public var facebookProfile: AnyObject?
    
    public init(firstName: String, lastName: String, emailAddress: String) {
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
public struct RegisterPersonalShopperForPushNotifications {
    public let personalShopper: PersonalShopper
    public let apn_device_token: String
    
    public init(personalShopper: PersonalShopper, apn_device_token: String) {
        self.personalShopper = personalShopper
        self.apn_device_token = apn_device_token
    }
    func parameterize() -> [String : AnyObject] {
        let parameters = [
            "device_type": "iPhone",
            "token": apn_device_token
        ]
        
        return parameters
    }
}
public struct CreatePurchaseRequest {
    public let amount: NSDecimalNumber
    public let shoppingSession: ShoppingSession
    public let productSize: ProductSize
    
    public init(amount: NSDecimalNumber, shoppingSession: ShoppingSession, productSize: ProductSize) {
        self.amount = amount
        self.shoppingSession = shoppingSession
        self.productSize = productSize
    }
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
public struct CreateCheckoutRequest {
    public let amount: NSDecimalNumber
    public let shoppingSessionId: String
    
    public init(amount: NSDecimalNumber, shoppingSessionId: String) {
        self.amount = amount
        self.shoppingSessionId = shoppingSessionId
    }
    func parameterize() -> [String : AnyObject] {
        let parameters = [
            "shopping_session_id": shoppingSessionId,
            "local_checkout_amount": amount
        ]
        
        return parameters
    }
}
public struct UpdatePurchaseRequest {
    let purchaseRequest: PurchaseRequest
    
    
    public init(purchaseRequest: PurchaseRequest) {
        self.purchaseRequest = purchaseRequest
    }
    func parameterize() -> [String : AnyObject] {
        let parameters = [
            "amount": purchaseRequest.amount,
            "status": purchaseRequest.status
        ]
        
        return parameters
    }
}
public struct UpdateCheckoutRequest {
    let checkoutRequest: CheckoutRequest
    
    public init(checkoutRequest: CheckoutRequest) {
        self.checkoutRequest = checkoutRequest
    }
    func parameterize() -> [String : AnyObject] {
        let parameters = [
            "amount": checkoutRequest.amount,
            "status": checkoutRequest.status
        ]
        
        return parameters as! [String : AnyObject]
    }
}
public struct CreateShippingInformation {
    let shoppingSession: ShoppingSession
    let name: String
    let address1: String
    let address2: String
    let city: String
    let state: String
    let zipCode: String
    
    public init(shoppingSession: ShoppingSession, name: String, address1: String, address2: String, city: String, state: String, zipCode: String) {
        self.shoppingSession = shoppingSession
        self.name = name
        self.address1 = address1
        self.address2 = address2
        self.city = city
        self.state = state
        self.zipCode = zipCode
    }
    func parameterize() -> [String : AnyObject] {
        let parameters = [
            "name": name,
            "address_1": address1,
            "address_2": address2,
            "city": city,
            "state": state,
            "zip_code": zipCode
        ]
        
        return parameters
    }
}
public class IShopAwayApiManager {
    private var kApiBaseUrl:String?
    public var apiBaseUrl: String {
        set {
            kApiBaseUrl = newValue
        }
        get {
            if let kApiBaseUrl = kApiBaseUrl {
                return kApiBaseUrl
            } else {
                fatalError("API Base URL must be set")
            }
        }
    }
    public static let sharedInstance = IShopAwayApiManager()
    
    private init() {}
    
    public func authenticateShopper(authenticateShopper: AuthenticateUser, success: (shopperId: String, token: String) -> Void, failure: (error: ErrorType?) -> Void) {
        let params = authenticateShopper.parameterize()
        
        Alamofire.request(.POST,  apiBaseUrl + "shoppers/authenticate", parameters: params, encoding: .JSON)
            .validate()
            .responseJSON { response in
                if let error = response.result.error {
                    failure(error: error)
                }
                if let result = response.result.value {
                    if let shopperId = result["shopper_id"] as? String, token = result["token"] as? String {
                        success(shopperId: shopperId, token: token)
                    } else {
                        failure(error: nil)
                    }
                }
                
        }
    }
    public func getShoppingSession(shoppingSessionId: String, success: (response: ShoppingSession) -> Void, failure: (error: ErrorType?) -> Void) {
        Alamofire.request(.GET,  apiBaseUrl + "shopping_sessions/\(shoppingSessionId)")
            .responseObject { (response: Response<ShoppingSession, NSError>) in
                if let error = response.result.error {
                    failure(error: error)
                }
                if let shoppingSession = response.result.value {
                    success(response: shoppingSession)
                }
                
        }
    }
    public func createShoppingSession(createShoppingSession: CreateShoppingSession, success: (response: ShoppingSession) -> Void, failure: (error: ErrorType?, errorDictionary: [String: AnyObject]?) -> Void) {
        let params = createShoppingSession.parameterize()
        
        Alamofire.request(.POST, apiBaseUrl + "shopping_sessions", parameters: params, encoding: .JSON)
            .validate()
            .responseObject { (response: Response<ShoppingSession, NSError>) in
                if let error = response.result.error {
                    var errorResponse: [String: AnyObject]? = [:]
                    
                    if let data = response.data {
                        do {
                            errorResponse = try NSJSONSerialization.JSONObjectWithData(data, options: []) as? [String:AnyObject]
                        } catch let error as NSError {
                            failure(error: error, errorDictionary: nil)
                        }
                        catch let error {
                            failure(error: error, errorDictionary: nil)
                        }
                        failure(error: error, errorDictionary: errorResponse)
                    } else {
                        failure(error: error, errorDictionary: nil)
                    }
                }
                if let shoppingSession = response.result.value {
                    success(response: shoppingSession)
                }
        }
    }
    public func checkout(shoppingSessionCheckout: ShoppingSessionCheckout, success: (response: ShoppingSession) -> Void, failure: (ErrorType?) -> Void) {
        let params = shoppingSessionCheckout.parameterize()
        
        if let shoppingSessionId = shoppingSessionCheckout.shoppingSession.id {
            Alamofire.request(.POST, apiBaseUrl + "shopping_sessions/\(shoppingSessionId)/checkout", parameters: params, encoding: .JSON)
                .responseObject { (response: Response<ShoppingSession, NSError>) in
                    if let error = response.result.error {
                        failure(error)
                    }
                    if let shoppingSession = response.result.value {
                        success(response: shoppingSession)
                    }
            }
        }
    }
    public func addShipping(createShippingInformation: CreateShippingInformation, success: (response: ShoppingSession) -> Void, failure: (ErrorType?) -> Void) {
        let params = createShippingInformation.parameterize()
        
        if let shoppingSessionId = createShippingInformation.shoppingSession.id {
            Alamofire.request(.POST, apiBaseUrl + "shopping_sessions/\(shoppingSessionId)/shipping", parameters: params, encoding: .JSON)
                .responseObject { (response: Response<ShoppingSession, NSError>) in
                    if let error = response.result.error {
                        failure(error)
                    }
                    if let shoppingSession = response.result.value {
                        success(response: shoppingSession)
                    }
            }
        }
    }
    public func createShopper(createShopper: CreateShopper, success: (response: Shopper?) -> Void, failure: (error: ErrorType?, json: JSON?) -> Void) {
        let params = createShopper.parameterize()
        
        
        Alamofire.request(.POST, apiBaseUrl + "shoppers", parameters: params, encoding: .JSON)
            .validate()
            .responseObject { (response: Response<Shopper, NSError>) in
                if let error = response.result.error {
                    if let responseData = response.data {
                        let jsonResults:JSON = JSON(data: responseData)
                        
                        failure(error: error, json: jsonResults)
                    } else {
                        failure(error: error, json: nil)
                    }
                }
                if let shopper = response.result.value {
                    success(response: shopper)
                }
        }
    }
    public func getShopper(shopperId: String, success: (response: Shopper) -> Void, failure: (error: ErrorType?) -> Void) {
        Alamofire.request(.GET,  apiBaseUrl + "shoppers/\(shopperId)")
            .responseObject { (response: Response<Shopper, NSError>) in
                if let error = response.result.error {
                    failure(error: error)
                }
                if let shopper = response.result.value {
                    success(response: shopper)
                }
                
        }
    }
    public func updateShopper(updateShopper: UpdateShopper, success: (response: Shopper?) -> Void, failure: (ErrorType?) -> Void) {
        let params = updateShopper.parameterize()
        
        Alamofire.request(.PUT, apiBaseUrl + "shoppers/\(updateShopper.shopperId)", parameters: params, encoding: .JSON)
            .responseObject { (response: Response<Shopper, NSError>) in
                if let error = response.result.error {
                    failure(error)
                }
                if let shopper = response.result.value {
                    success(response: shopper)
                }
                
        }
    }
    public func registerShopperForPushNotifications(registerShopperForPushNotifications: RegisterShopperForPushNotifications, success: (response: Shopper) -> Void, failure: (ErrorType?) -> Void) {
        let params = registerShopperForPushNotifications.parameterize()
        
        guard let shopperId = registerShopperForPushNotifications.shopper.id else {
            return
        }
        Alamofire.request(.POST, apiBaseUrl + "shoppers/\(shopperId)/register_device", parameters: params, encoding: .JSON)
            .responseObject { (response: Response<Shopper, NSError>) in
                if let error = response.result.error {
                    failure(error)
                }
                if let shopper = response.result.value {
                    success(response: shopper)
                }
        }
    }
    public func getMarkets(success: (response: [Market]?) -> Void, failure: (ErrorType?) -> Void) {
        Alamofire.request(.GET,  apiBaseUrl + "markets")
            .responseArray { (response: Response<[Market], NSError>) in
                if let error = response.result.error {
                    failure(error)
                }
                if let markets = response.result.value {
                    success(response: markets)
                }
            }
    
    }
    public func updateMarket(updateMarket: UpdateMarket, success: (response: Market?) -> Void, failure: (ErrorType?) -> Void) {
        let params = updateMarket.parameterize()
        
        Alamofire.request(.PUT, apiBaseUrl + "markets/\(updateMarket.marketId)", parameters: params, encoding: .JSON)
            .responseObject { (response: Response<Market, NSError>) in
                if let error = response.result.error {
                    failure(error)
                }
                if let market = response.result.value {
                    success(response: market)
                }
                
        }
    }
    public func personalShopperCheckin(personalShopperCheckin: PersonalShopperCheckin, success: (response: Market?) -> Void, failure: (ErrorType?) -> Void) {
        let params = personalShopperCheckin.parameterize()
        
        Alamofire.request(.POST, apiBaseUrl + "markets/\(personalShopperCheckin.marketId)/checkin", parameters: params, encoding: .JSON)
            .responseObject { (response: Response<Market, NSError>) in
                if let error = response.result.error {
                    failure(error)
                }
                if let market = response.result.value {
                    success(response: market)
                }
                
        }
    }
    public func createPersonalShopper(createPersonalShopper: CreatePersonalShopper, success: (response: PersonalShopper?) -> Void, failure: (error: ErrorType?, json: JSON?) -> Void) {
        let params = createPersonalShopper.parameterize()
        
        Alamofire.request(.POST, apiBaseUrl + "personal_shoppers", parameters: params, encoding: .JSON)
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
    public func getPersonalShopper(personalShopperId: String, success: (response: PersonalShopper) -> Void, failure: (error: ErrorType?) -> Void) {
        Alamofire.request(.GET,  apiBaseUrl + "personal_shoppers/\(personalShopperId)")
            .responseObject { (response: Response<PersonalShopper, NSError>) in
                if let error = response.result.error {
                    failure(error: error)
                }
                if let personalShopper = response.result.value {
                    success(response: personalShopper)
                }
                
        }
    }
    public func registerPersonalShopperForPushNotifications(registerPersonalShopperForPushNotifications: RegisterPersonalShopperForPushNotifications, success: (response: PersonalShopper) -> Void, failure: (ErrorType?) -> Void) {
        let params = registerPersonalShopperForPushNotifications.parameterize()
        
        guard let personalShopperId = registerPersonalShopperForPushNotifications.personalShopper.id else {
            return
        }
        Alamofire.request(.POST, apiBaseUrl + "personal_shoppers/\(personalShopperId)/register_device", parameters: params, encoding: .JSON)
            .responseObject { (response: Response<PersonalShopper, NSError>) in
                if let error = response.result.error {
                    failure(error)
                }
                if let personalShopper = response.result.value {
                    success(response: personalShopper)
                }
                
        }
    }
    public func authenticatePersonalShopper(authenticateShopper: AuthenticateUser, success: (shopperId: String, token: String) -> Void, failure: (error: ErrorType?) -> Void) {
        let params = authenticateShopper.parameterize()
        
        Alamofire.request(.POST,  apiBaseUrl + "personal_shoppers/authenticate", parameters: params, encoding: .JSON)
            .validate()
            .responseJSON { response in
                if let error = response.result.error {
                    failure(error: error)
                }
                if let result = response.result.value {
                    if let personalShopperId = result["personal_shopper_id"] as? String, token = result["token"] as? String {
                        success(shopperId: personalShopperId, token: token)
                    }
                }
                
        }
    }

    public func publishFeed(shoppingSessionId: String, success: (response: ShoppingSession) -> Void, failure: (ErrorType?) -> Void) {
        Alamofire.request(.POST, apiBaseUrl + "shopping_sessions/" + shoppingSessionId + "/publish")
            .responseObject { (response: Response<ShoppingSession, NSError>) in
                if let error = response.result.error {
                    failure(error)
                }
                if let shoppingSession = response.result.value {
                    success(response: shoppingSession)
                }
                
        }
    }
    public func createPurchaseRequest(createPurchaseRequest: CreatePurchaseRequest, success: (response: PurchaseRequest?) -> Void, failure: (ErrorType?) -> Void) {
        let params = createPurchaseRequest.parameterize()
        
        Alamofire.request(.POST, apiBaseUrl + "purchase_requests", parameters: params, encoding: .JSON)
            .responseObject { (response: Response<PurchaseRequest, NSError>) in
                if let error = response.result.error {
                    failure(error)
                }
                if let purchaseRequest = response.result.value {
                    success(response: purchaseRequest)
                }
                
        }
    }
    public func updatePurchaseRequest(updatePurchaseRequest: UpdatePurchaseRequest, success: (response: PurchaseRequest) -> Void, failure: (ErrorType?) -> Void) {
        let params = updatePurchaseRequest.parameterize()
        
        
        Alamofire.request(.PUT , apiBaseUrl + "purchase_requests/\(updatePurchaseRequest.purchaseRequest.id)", parameters: params, encoding: .JSON)
            .responseObject { (response: Response<PurchaseRequest, NSError>) in
                if let error = response.result.error {
                    failure(error)
                }
                if let purchaseRequest = response.result.value {
                    success(response: purchaseRequest)
                }
        }
    }
    public func getPurchaseRequest(purchaseRequestId: String, success: (response: PurchaseRequest) -> Void, failure: (ErrorType?) -> Void) {
        Alamofire.request(.GET, apiBaseUrl + "purchase_requests/\(purchaseRequestId)")
            .responseObject { (response: Response<PurchaseRequest, NSError>) in
                if let error = response.result.error {
                    failure(error)
                }
                if let purchaseRequest = response.result.value {
                    success(response: purchaseRequest)
                }
        }
    }
    public func createCheckoutRequest(createCheckoutRequest: CreateCheckoutRequest, success: (response: CheckoutRequest?) -> Void, failure: (error: ErrorType?) -> Void) {
        let params = createCheckoutRequest.parameterize()
        
        Alamofire.request(.POST, apiBaseUrl + "checkout_requests", parameters: params, encoding: .JSON)
            .responseObject { (response: Response<CheckoutRequest, NSError>) in
                if let error = response.result.error {
                    failure(error: error)
                }
                if let checkoutRequest = response.result.value {
                    success(response: checkoutRequest)
                }
                
        }
    }
    public func updateCheckoutRequest(updateCheckoutRequest: UpdateCheckoutRequest, success: (response: CheckoutRequest) -> Void, failure: (ErrorType?) -> Void) {
        let params = updateCheckoutRequest.parameterize()
        
        
        Alamofire.request(.PUT , apiBaseUrl + "checkout_requests/\(updateCheckoutRequest.checkoutRequest.id)", parameters: params, encoding: .JSON)
            .responseObject { (response: Response<CheckoutRequest, NSError>) in
                if let error = response.result.error {
                    failure(error)
                }
                if let checkoutRequest = response.result.value {
                    success(response: checkoutRequest)
                }
        }
    }
    public func getCheckoutRequest(checkoutRequestId: String, success: (response: CheckoutRequest) -> Void, failure: (ErrorType?) -> Void) {
        Alamofire.request(.GET,  apiBaseUrl + "checkout_requests/\(checkoutRequestId)")
            .responseObject { (response: Response<CheckoutRequest, NSError>) in
                if let error = response.result.error {
                    failure(error)
                }
                if let checkoutRequest = response.result.value {
                    success(response: checkoutRequest)
                }
        }
    }
}