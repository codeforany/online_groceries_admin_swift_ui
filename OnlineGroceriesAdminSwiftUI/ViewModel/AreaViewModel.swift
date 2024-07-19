//
//  AreaViewModel.swift
//  OnlineGroceriesAdminSwiftUI
//
//  Created by CodeForAny on 17/05/24.
//

import SwiftUI

class AreaViewModel: ObservableObject {
    static let shared: AreaViewModel = AreaViewModel()
    
    @Published var listArr: [AreaModel] = [];
    @Published var zoneObj: ZoneModel?
    @Published var areaObj: AreaModel?
    
    @Published var txtName = ""
    
    @Published var showError = false
    @Published var errorMessage = ""
    
    @Published var isEdit = false
    @Published var showAddEdit = false
        
    
    func setZoneObj( zObj: ZoneModel ) {
        self.zoneObj = zObj
    }
 
    
    //MARK: Action
    func actionOpenAdd(){
        areaObj = nil
        isEdit = false
        txtName = ""
        showAddEdit = true
    }
    
    func actionAdd(didDone: ( ()->() )? ){
        if(txtName.isEmpty) {
            self.errorMessage = "Please enter zone area name"
            self.showError = true
            return
        }
        
        apiAdd() {
            didDone?()
        }
    }
    
    func actionEdit(obj: AreaModel) {
        areaObj = obj
        txtName = obj.areaName
        isEdit = true
        showAddEdit = true
    }
    
    func actionUpdate(didDone: ( ()->() )?){
        
        if (areaObj == nil) {
            return
        }
        
        if(txtName.isEmpty) {
            self.errorMessage = "Please enter zone area name"
            self.showError = true
            return
        }
        
        apiUpdate(areaId: areaObj?.areaId ?? 0 ) {
            didDone?()
        }
    }
    
    func actionDelete(obj: AreaModel) {
        
        apiDelete(areaId: obj.areaId)
    }
    
    //MAKE: ApiCalling
    func apiList(){
        ServiceCall.post(parameter: ["zone_id": self.zoneObj?.zoneId ?? "" ], path: Globs.SV_AREA_LIST, isToken: true) { responseObj in
            
            if let responseObj = responseObj as? NSDictionary {
                if (responseObj.value(forKey: KKey.status) as? String ?? "" == "1"){
                        
                    self.listArr = (responseObj.value(forKey: KKey.payload) as? [NSDictionary] ?? []).map({ obj in
                        return AreaModel(dict: obj)
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
        ServiceCall.post(parameter: ["zone_id": self.zoneObj?.zoneId ?? "","area_name": txtName ], path: Globs.SV_AREA_ADD, isToken: true) { responseObj in
            
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
    
    func apiUpdate(areaId: Int,didDone: ( ()->() )?){
        
        ServiceCall.post(parameter: ["area_id": areaId, "zone_id": self.zoneObj?.zoneId ?? "", "area_name": txtName ], path: Globs.SV_AREA_UPDATE, isToken: true) { responseObj in
            
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
    
    func apiDelete(areaId: Int){
        
        ServiceCall.post(parameter: ["area_id": areaId ], path: Globs.SV_AREA_DELETE, isToken: true) { responseObj in
            
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
