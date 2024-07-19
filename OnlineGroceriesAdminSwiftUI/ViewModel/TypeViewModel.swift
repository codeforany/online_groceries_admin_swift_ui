//
//  TypeViewModel.swift
//  OnlineGroceriesAdminSwiftUI
//
//  Created by CodeForAny on 23/05/24.
//

import SwiftUI

class TypeViewModel: ObservableObject {
    static let shared: TypeViewModel = TypeViewModel()
    
    @Published var listArr: [TypeModel] = [];
    @Published var catObj: TypeModel?
    
    @Published var txtName = ""
    @Published var txtColor = ""
    @Published var image: UIImage?
    
    @Published var showError = false
    @Published var errorMessage = ""
    
    @Published var isEdit = false
    @Published var showAddEdit = false
    
    @Published var showArea = false
    
    init() {
        
    }
    
    //MARK: Action
    func actionOpenAdd(){
        catObj = nil
        isEdit = false
        txtName = ""
        txtColor = "BBBBBB"
        image = nil
        showAddEdit = true
    }
    
    func actionAdd(didDone: ( ()->() )? ){
        if(txtName.isEmpty) {
            self.errorMessage = "Please enter product type name"
            self.showError = true
            return
        }
        
        if(txtColor.isEmpty) {
            self.errorMessage = "Please enter type color"
            self.showError = true
            return
        }
        
        if(image == nil) {
            self.errorMessage = "Please select type image"
            self.showError = true
            return
        }
        
        apiAdd() {
            didDone?()
        }
    }
    
    func actionEdit(obj: TypeModel) {
        catObj = obj
        txtName = obj.name
        txtColor = obj.colorStr
        image = nil
        isEdit = true
        showAddEdit = true
    }
    
    func actionUpdate(didDone: ( ()->() )?){
        
        if (catObj == nil) {
            return
        }
        
        if(txtName.isEmpty) {
            self.errorMessage = "Please enter product type name"
            self.showError = true
            return
        }
        
        if(txtColor.isEmpty) {
            self.errorMessage = "Please enter type color"
            self.showError = true
            return
        }
        
        apiUpdate(typeId: catObj?.id ?? 0 ) {
            didDone?()
        }
    }
    
    func actionDelete(obj: TypeModel) {
        
        apiDelete(typeId: obj.id)
    }
    
    //MAKE: ApiCalling
    func apiList(){
        ServiceCall.post(parameter: [:], path: Globs.SV_TYPE_LIST, isToken: true) { responseObj in
            
            if let responseObj = responseObj as? NSDictionary {
                if (responseObj.value(forKey: KKey.status) as? String ?? "" == "1"){
                        
                    self.listArr = (responseObj.value(forKey: KKey.payload) as? [NSDictionary] ?? []).map({ obj in
                        return TypeModel(dict: obj)
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
        ServiceCall.multipart(parameter: ["type_name": txtName, "color": txtColor  ], path: Globs.SV_TYPE_ADD, imageDic: ["image": image! ] , isToken: true) { responseObj in
            
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
    
    func apiUpdate(typeId: Int,didDone: ( ()->() )?){
        
        ServiceCall.multipart(parameter: ["type_id": typeId, "type_name": txtName, "color": txtColor  ], path: Globs.SV_TYPE_UPDATE, imageDic: image == nil ? [:] : ["image": image! ] , isToken: true) {
            responseObj in
            
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
    
    func apiDelete(typeId: Int){
        
        ServiceCall.post(parameter: ["type_id": typeId ], path: Globs.SV_TYPE_DELETE, isToken: true) { responseObj in
            
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

