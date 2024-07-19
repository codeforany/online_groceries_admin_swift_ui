//
//  CategoryViewModel.swift
//  OnlineGroceriesAdminSwiftUI
//
//  Created by CodeForAny on 19/05/24.
//

import SwiftUI

class CategoryViewModel: ObservableObject {
    static let shared: CategoryViewModel = CategoryViewModel()
    
    @Published var listArr: [CategoryModel] = [];
    @Published var catObj: CategoryModel?
    
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
            self.errorMessage = "Please enter category name"
            self.showError = true
            return
        }
        
        if(txtColor.isEmpty) {
            self.errorMessage = "Please enter category color"
            self.showError = true
            return
        }
        
        if(image == nil) {
            self.errorMessage = "Please select category image"
            self.showError = true
            return
        }
        
        apiAdd() {
            didDone?()
        }
    }
    
    func actionEdit(obj: CategoryModel) {
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
            self.errorMessage = "Please enter category name"
            self.showError = true
            return
        }
        
        if(txtColor.isEmpty) {
            self.errorMessage = "Please enter category color"
            self.showError = true
            return
        }
        
        apiUpdate(catId: catObj?.id ?? 0 ) {
            didDone?()
        }
    }
    
    func actionDelete(obj: CategoryModel) {
        
        apiDelete(catId: obj.id)
    }
    
    //MAKE: ApiCalling
    func apiList(){
        ServiceCall.post(parameter: [:], path: Globs.SV_CATEGORY_LIST, isToken: true) { responseObj in
            
            if let responseObj = responseObj as? NSDictionary {
                if (responseObj.value(forKey: KKey.status) as? String ?? "" == "1"){
                        
                    self.listArr = (responseObj.value(forKey: KKey.payload) as? [NSDictionary] ?? []).map({ obj in
                        return CategoryModel(dict: obj)
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
        ServiceCall.multipart(parameter: ["cat_name": txtName, "color": txtColor  ], path: Globs.SV_CATEGORY_ADD, imageDic: ["image": image! ] , isToken: true) { responseObj in
            
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
    
    func apiUpdate(catId: Int,didDone: ( ()->() )?){
        
        ServiceCall.multipart(parameter: ["cat_id": catId, "cat_name": txtName, "color": txtColor  ], path: Globs.SV_CATEGORY_UPDATE, imageDic: image == nil ? [:] : ["image": image! ] , isToken: true) {
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
    
    func apiDelete(catId: Int){
        
        ServiceCall.post(parameter: ["cat_id": catId ], path: Globs.SV_CATEGORY_DELETE, isToken: true) { responseObj in
            
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
