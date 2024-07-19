//
//  TypeModel.swift
//  OnlineGroceriesSwiftUI
//
//  Created by CodeForAny on 04/08/23.
//

import SwiftUI

struct TypeModel: Identifiable, Equatable {
    
    var id: Int = 0
    var name: String = ""
    var image: String = ""
    var color: Color = Color.primaryApp
    var colorStr: String = "BBBBBB"
    
    
    init(dict: NSDictionary) {
        self.id = dict.value(forKey: "type_id") as? Int ?? 0
        self.name = dict.value(forKey: "type_name") as? String ?? ""
        self.image = dict.value(forKey: "image") as? String ?? ""
        self.colorStr = dict.value(forKey: "color") as? String ?? "BBBBBB"
        self.color = Color(hex: dict.value(forKey: "color") as? String ?? "BBBBBB")
       
    }
    
    static func == (lhs: TypeModel, rhs: TypeModel) -> Bool {
        return lhs.id == rhs.id
    }
}
