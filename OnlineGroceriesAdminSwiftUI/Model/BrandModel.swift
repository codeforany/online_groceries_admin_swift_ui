//
//  BrandModel.swift
//  OnlineGroceriesAdminSwiftUI
//
//  Created by CodeForAny on 12/05/24.
//

import SwiftUI


struct BrandModel: Identifiable, Equatable {
    
    
    let id = UUID()
    var brandId: Int = 0
    var brandName: String = ""
   
    
    
    init(dict: NSDictionary) {
        self.brandId = dict.value(forKey: "brand_id") as? Int ?? 0
        self.brandName = dict.value(forKey: "brand_name") as? String ?? ""
    }
    
    static func == (lhs: BrandModel, rhs: BrandModel) -> Bool {
        return lhs.id == rhs.id && lhs.brandId == rhs.brandId
    }
}
