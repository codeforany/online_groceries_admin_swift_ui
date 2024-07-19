//
//  AreaModel.swift
//  OnlineGroceriesAdminSwiftUI
//
//  Created by CodeForAny on 17/05/24.
//

import SwiftUI

struct AreaModel: Identifiable, Equatable {
    
    
    let id = UUID()
    var areaId: Int = 0
    var areaName: String = ""
    var zoneId: Int = 0
    var zoneName: String = ""
   
    
    
    init(dict: NSDictionary) {
        
        self.areaId = dict.value(forKey: "area_id") as? Int ?? 0
        self.areaName = dict.value(forKey: "name") as? String ?? ""
        self.zoneId = dict.value(forKey: "zone_id") as? Int ?? 0
        self.zoneName = dict.value(forKey: "zone_name") as? String ?? ""
    }
    
    static func == (lhs: AreaModel, rhs: AreaModel) -> Bool {
        return lhs.id == rhs.id && lhs.zoneId == rhs.zoneId
    }
}
