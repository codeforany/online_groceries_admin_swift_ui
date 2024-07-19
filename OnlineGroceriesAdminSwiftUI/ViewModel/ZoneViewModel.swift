//
//  ZoneViewModel.swift
//  OnlineGroceriesAdminSwiftUI
//
//  Created by CodeForAny on 15/05/24.
//

import SwiftUI

class ZoneViewModel: ObservableObject {
    static let shared: ZoneViewModel = ZoneViewModel()
    
    @Published var listArr: [ZoneModel] = [];
    @Published var zoneObj: ZoneModel?
    
    @Published var txtName = ""
    
    @Published var showError = false
    @Published var errorMessage = ""
    
    @Published var isEdit = false
    @Published var showAddEdit = false
    
    @Published var showArea = false
    
    init() {
        
    }
    
    //MARK: Action
    func actionOpenAdd(){
        zoneObj = nil
        isEdit = false
        txtName = ""
        showAddEdit = true
    }
    
    func actionAdd(didDone: ( ()->() )? ){
        if(txtName.isEmpty) {
            self.errorMessage = "Please enter zone name"
            self.showError = true
            return
        }
        
        apiAdd() {
            didDone?()
        }
    }
    
    func actionEdit(obj: ZoneModel) {
        zoneObj = obj
        txtName = obj.zoneName
        isEdit = true
        showAddEdit = true
    }
    
    func actionUpdate(didDone: ( ()->() )?){
        
        if (zoneObj == nil) {
            return
        }
        
        if(txtName.isEmpty) {
            self.errorMessage = "Please enter zone name"
            self.showError = true
            return
        }
        
        apiUpdate(zoneId: zoneObj?.zoneId ?? 0 ) {
            didDone?()
        }
    }
    
    func actionDelete(obj: ZoneModel) {
        
        apiDelete(zoneId: obj.zoneId)
    }
    
    //MAKE: ApiCalling
    func apiList(){
        ServiceCall.post(parameter: [:], path: Globs.SV_ZONE_LIST, isToken: true) { responseObj in
            
            if let responseObj = responseObj as? NSDictionary {
                if (responseObj.value(forKey: KKey.status) as? String ?? "" == "1"){
                        
                    self.listArr = (responseObj.value(forKey: KKey.payload) as? [NSDictionary] ?? []).map({ obj in
                        return ZoneModel(dict: obj)
                    })
                    
                }else{
                    self.listArr = []
                    self.errorMessage = responseObj.value(forKey: KKey.message) as? String ?? "fail"
                    self.showError = true
                }
            }
        } failure: { error in
            self.errorMessage = error?.localizedDescription ?? "fail"
            self.showError = true
        }

    }
    
    
    func apiAdd(didDone: ( ()->() )?){
        ServiceCall.post(parameter: ["zone_name": txtName ], path: Globs.SV_ZONE_ADD, isToken: true) { responseObj in
            
            if let responseObj = responseObj as? NSDictionary {
                if (responseObj.value(forKey: KKey.status) as? String ?? "" == "1"){
                        
                    self.errorMessage = responseObj.value(forKey: KKey.message) as? String ?? "success"
                    self.showError = true
                    didDone?()
        
                }else{
                    self.errorMessage = responseObj.value(forKey: KKey.message) as? String ?? "fail"
                    self.showError = true
                }
            }
        } failure: { error in
            self.errorMessage = error?.localizedDescription ?? "fail"
            self.showError = true
        }

    }
    
    func apiUpdate(zoneId: Int,didDone: ( ()->() )?){
        
        ServiceCall.post(parameter: ["zone_id": zoneId, "zone_name": txtName ], path: Globs.SV_ZONE_UPDATE, isToken: true) { responseObj in
            
            if let responseObj = responseObj as? NSDictionary {
                if (responseObj.value(forKey: KKey.status) as? String ?? "" == "1"){
                        
                    self.errorMessage = responseObj.value(forKey: KKey.message) as? String ?? "success"
                    self.showError = true
                    didDone?()
        
                }else{
                    self.errorMessage = responseObj.value(forKey: KKey.message) as? String ?? "fail"
                    self.showError = true
                }
            }
        } failure: { error in
            self.errorMessage = error?.localizedDescription ?? "fail"
            self.showError = true
        }

    }
    
    func apiDelete(zoneId: Int){
        
        ServiceCall.post(parameter: ["zone_id": zoneId ], path: Globs.SV_ZONE_DELETE, isToken: true) { responseObj in
            
            if let responseObj = responseObj as? NSDictionary {
                if (responseObj.value(forKey: KKey.status) as? String ?? "" == "1"){
                        
                    self.errorMessage = responseObj.value(forKey: KKey.message) as? String ?? "success"
                    self.showError = true
                    
                    self.apiList()
        
                }else{
                    self.errorMessage = responseObj.value(forKey: KKey.message) as? String ?? "fail"
                    self.showError = true
                }
            }
        } failure: { error in
            self.errorMessage = error?.localizedDescription ?? "fail"
            self.showError = true
        }

    }
    
}

