//
//  ZoneModel.swift
//  OnlineGroceriesAdminSwiftUI
//
//  Created by CodeForAny on 15/05/24.
//

import SwiftUI

struct ZoneModel: Identifiable, Equatable {
    
    
    let id = UUID()
    var zoneId: Int = 0
    var zoneName: String = ""
   
    
    
    init(dict: NSDictionary) {
        self.zoneId = dict.value(forKey: "zone_id") as? Int ?? 0
        self.zoneName = dict.value(forKey: "name") as? String ?? ""
    }
    
    static func == (lhs: ZoneModel, rhs: ZoneModel) -> Bool {
        return lhs.id == rhs.id && lhs.zoneId == rhs.zoneId
    }
}
