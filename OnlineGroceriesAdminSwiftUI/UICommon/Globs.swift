//
//  Globs.swift
//  OnlineGroceriesSwiftUI
//
//  Created by CodeForAny on 01/08/23.
//

import SwiftUI

struct Globs {
    static let AppName = "Online Groceries"
    
    static let BASE_URL = "http://localhost:3001/api/admin/"
    
    static let userPayload = "user_payload"
    static let userLogin = "user_login"
    
    static let SV_LOGIN = BASE_URL + "login"
    
    static let SV_BRAND_ADD = BASE_URL + "brand_add"
    static let SV_BRAND_UPDATE = BASE_URL + "brand_update"
    static let SV_BRAND_DELETE = BASE_URL + "brand_delete"
    static let SV_BRAND_LIST = BASE_URL + "brand_list"
    
    static let SV_ZONE_ADD = BASE_URL + "zone_add"
    static let SV_ZONE_UPDATE = BASE_URL + "zone_update"
    static let SV_ZONE_DELETE = BASE_URL + "zone_delete"
    static let SV_ZONE_LIST = BASE_URL + "zone_list"
    
    static let SV_AREA_ADD = BASE_URL + "area_add"
    static let SV_AREA_UPDATE = BASE_URL + "area_update"
    static let SV_AREA_DELETE = BASE_URL + "area_delete"
    static let SV_AREA_LIST = BASE_URL + "area_list"
    
    static let SV_CATEGORY_ADD = BASE_URL + "product_category_add"
    static let SV_CATEGORY_UPDATE = BASE_URL + "product_category_update"
    static let SV_CATEGORY_DELETE = BASE_URL + "product_category_delete"
    static let SV_CATEGORY_LIST = BASE_URL + "product_category_list"
    
    static let SV_TYPE_ADD = BASE_URL + "product_type_add"
    static let SV_TYPE_UPDATE = BASE_URL + "product_type_update"
    static let SV_TYPE_DELETE = BASE_URL + "product_type_delete"
    static let SV_TYPE_LIST = BASE_URL + "product_type_list"
    
    static let SV_PROMO_CODE_ADD = BASE_URL + "promo_code_add"
    static let SV_PROMO_CODE_UPDATE = BASE_URL + "promo_code_update"
    static let SV_PROMO_CODE_DELETE = BASE_URL + "promo_code_delete"
    static let SV_PROMO_CODE_LIST = BASE_URL + "promo_code_list"
    
    
    static let SV_PRODUCT_ADD = BASE_URL + "product_add"
    static let SV_PRODUCT_UPDATE = BASE_URL + "product_update"
    static let SV_PRODUCT_DELETE = BASE_URL + "product_delete"
    static let SV_PRODUCT_LIST = BASE_URL + "product_list"
    static let SV_PRODUCT_DETAIL = BASE_URL + "product_detail"

    static let SV_PRODUCT_NUTRITION_ADD = BASE_URL + "product_nutrition_add"
    static let SV_PRODUCT_NUTRITION_DELETE = BASE_URL + "product_nutrition_delete"
    static let SV_PRODUCT_IMAGE_ADD = BASE_URL + "product_image_add"
    static let SV_PRODUCT_IMAGE_DELETE = BASE_URL + "product_image_delete"
    static let SV_PRODUCT_CATEGORY_TYPE_BRAND = BASE_URL + "product_category_type_brand_list"
    
    static let SV_OFFER_ADD = BASE_URL + "offer_add"
    static let SV_OFFER_DELETE = BASE_URL + "offer_delete"
    static let SV_OFFER_PRODUCT_LIST = BASE_URL + "offer_product_list"
    
    static let SV_NEW_ORDER_LIST = BASE_URL + "new_orders_list"
    static let SV_COMPLETED_ORDER_LIST = BASE_URL + "completed_orders_list"
    static let SV_CANCEL_ORDER_LIST = BASE_URL + "cancel_decline_orders_list"
    
    static let SV_ORDER_DETAIL = BASE_URL + "order_detail"
    static let SV_ORDER_STATUS_CHANGE = BASE_URL + "order_status_change"
    
}

struct KKey {
    static let status = "status"
    static let message = "message"
    static let payload = "payload"
}

class Utils {
    class func UDSET(data: Any, key: String) {
        UserDefaults.standard.set(data, forKey: key)
        UserDefaults.standard.synchronize()
    }
    
    class func UDValue( key: String) -> Any {
       return UserDefaults.standard.value(forKey: key) as Any
    }
    
    class func UDValueBool( key: String) -> Bool {
       return UserDefaults.standard.value(forKey: key) as? Bool ?? false
    }
    
    class func UDValueTrueBool( key: String) -> Bool {
       return UserDefaults.standard.value(forKey: key) as? Bool ?? true
    }
    
    class func UDRemove( key: String) {
        UserDefaults.standard.removeObject(forKey: key)
        UserDefaults.standard.synchronize()
    }
    
    class func getJson(objects: [Any]?) -> Any? {
                
            if(objects == nil) {
                return nil
            }
            
            for objectsString in objects! {
                do {
                    if let objectData = (objectsString as? String)?.data(using: .utf8) {
                        return try JSONSerialization.jsonObject(with: objectData, options: .mutableContainers )
                    }
                }
                catch {
                    print(error.localizedDescription)
                }
            }
            
            return nil
            
        }
        
        class func jsonString(obj: Any, prettyPrint: Bool) -> String {
            guard let data  = try? JSONSerialization.data(withJSONObject: obj, options: []) else{
                return "{}"
            }
            return String(data: data, encoding: .utf8) ?? "{}"
        }
}

