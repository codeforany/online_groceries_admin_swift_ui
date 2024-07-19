//
//  BrandViewModel.swift
//  OnlineGroceriesAdminSwiftUI
//
//  Created by CodeForAny on 12/05/24.
//

import SwiftUI

class BrandViewModel: ObservableObject {
    static let shared: BrandViewModel = BrandViewModel()
    
    @Published var listArr: [BrandModel] = [];
    @Published var brandObj: BrandModel?
    
    @Published var txtBrandName = ""
    
    @Published var showError = false
    @Published var errorMessage = ""
    
    @Published var isEdit = false
    @Published var showAddEdit = false
    
    init() {
        
    }
    
    //MARK: Action
    func actionOpenAdd(){
        brandObj = nil
        isEdit = false
        txtBrandName = ""
        showAddEdit = true
    }
    
    func actionAdd(didDone: ( ()->() )? ){
        if(txtBrandName.isEmpty) {
            self.errorMessage = "Please enter brand name"
            self.showError = true
            return
        }
        
        apiAdd() {
            didDone?()
        }
    }
    
    func actionEdit(obj: BrandModel) {
        brandObj = obj
        txtBrandName = obj.brandName
        isEdit = true
        showAddEdit = true
    }
    
    func actionUpdate(didDone: ( ()->() )?){
        
        if (brandObj == nil) {
            return
        }
        
        if(txtBrandName.isEmpty) {
            self.errorMessage = "Please enter brand name"
            self.showError = true
            return
        }
        
        apiUpdate(brandId: brandObj?.brandId ?? 0 ) {
            didDone?()
        }
    }
    
    func actionDelete(obj: BrandModel) {
        
        apiDelete(brandId: obj.brandId)
    }
    
    //MAKE: ApiCalling
    func apiList(){
        ServiceCall.post(parameter: [:], path: Globs.SV_BRAND_LIST, isToken: true) { responseObj in
            
            if let responseObj = responseObj as? NSDictionary {
                if (responseObj.value(forKey: KKey.status) as? String ?? "" == "1"){
                        
                    self.listArr = (responseObj.value(forKey: KKey.payload) as? [NSDictionary] ?? []).map({ obj in
                        return BrandModel(dict: obj)
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
        ServiceCall.post(parameter: ["brand_name": txtBrandName ], path: Globs.SV_BRAND_ADD, isToken: true) { responseObj in
            
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
    
    func apiUpdate(brandId: Int,didDone: ( ()->() )?){
        
        ServiceCall.post(parameter: ["brand_id": brandId, "brand_name": txtBrandName ], path: Globs.SV_BRAND_UPDATE, isToken: true) { responseObj in
            
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
    
    func apiDelete(brandId: Int){
        
        ServiceCall.post(parameter: ["brand_id": brandId ], path: Globs.SV_BRAND_DELETE, isToken: true) { responseObj in
            
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
