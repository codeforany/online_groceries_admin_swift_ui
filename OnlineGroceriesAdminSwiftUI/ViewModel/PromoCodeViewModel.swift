//
//  PromoCodeViewModel.swift
//  OnlineGroceriesAdminSwiftUI
//
//  Created by CodeForAny on 26/05/24.
//

import SwiftUI

class PromoCodeViewModel: ObservableObject {
    static let shared: PromoCodeViewModel = PromoCodeViewModel()
    
    @Published var listArr: [PromoCodeModel] = [];
    @Published var promoObj: PromoCodeModel?
    
    @Published var txtCode = ""
    @Published var txtTitle = ""
    @Published var txtDescription = ""
    @Published var txtOfferPrice = ""
    @Published var txtMinOrderAmount = ""
    @Published var txtMaxDiscount = ""
    @Published var selectType = 1
    @Published var selectStateDate = Date()
    @Published var selectEndDate = Date()
    
    
    @Published var showError = false
    @Published var errorMessage = ""
    
    @Published var isEdit = false
    @Published var showAddEdit = false
    
    @Published var showArea = false
    
    init() {
        
    }
    
    //MARK: Action
    func actionOpenAdd(){
        promoObj = nil
        isEdit = false
        
        txtCode = ""
        txtTitle = ""
        txtDescription = ""
        txtOfferPrice = ""
        txtMaxDiscount = ""
        txtMinOrderAmount = ""
        selectType = 1
        selectStateDate = Date()
        selectEndDate = Date()
        
        showAddEdit = true
    }
    
    func actionAdd(didDone: ( ()->() )? ){
        if(txtCode.isEmpty) {
            self.errorMessage = "Please enter promo code"
            self.showError = true
            return
        }
        
        if(txtTitle.isEmpty) {
            self.errorMessage = "Please enter promo code title"
            self.showError = true
            return
        }
        
        
        if(txtDescription.isEmpty) {
            self.errorMessage = "Please enter promo code description"
            self.showError = true
            return
        }
        
        
        if(txtOfferPrice.isEmpty) {
            self.errorMessage = "Please enter offer price"
            self.showError = true
            return
        }
        
        
        if(txtMinOrderAmount.isEmpty) {
            self.errorMessage = "Please enter min order amount"
            self.showError = true
            return
        }
        
        if(txtMaxDiscount.isEmpty) {
            self.errorMessage = "Please enter max discount amount"
            self.showError = true
            return
        }
        
        
        
        apiAdd() {
            didDone?()
        }
    }
    
    func actionEdit(obj: PromoCodeModel) {
        promoObj = obj
        txtCode = obj.code
        
        txtTitle = obj.title
        txtDescription = obj.description
        txtOfferPrice = "\(obj.offerPrice)"
        txtMaxDiscount = "\(obj.maxDiscountAmount)"
        txtMinOrderAmount = "\(obj.maxDiscountAmount)"
        selectType = obj.type
        selectStateDate = obj.startDate
        selectEndDate = obj.endDate
        
        isEdit = true
        showAddEdit = true
    }
    
    func actionUpdate(didDone: ( ()->() )?){
        
        if (promoObj == nil) {
            return
        }
        
        if(txtTitle.isEmpty) {
            self.errorMessage = "Please enter promo code title"
            self.showError = true
            return
        }
        
        
        if(txtDescription.isEmpty) {
            self.errorMessage = "Please enter promo code description"
            self.showError = true
            return
        }
        
        
        if(txtOfferPrice.isEmpty) {
            self.errorMessage = "Please enter offer price"
            self.showError = true
            return
        }
        
        
        if(txtMinOrderAmount.isEmpty) {
            self.errorMessage = "Please enter min order amount"
            self.showError = true
            return
        }
        
        if(txtMaxDiscount.isEmpty) {
            self.errorMessage = "Please enter max discount amount"
            self.showError = true
            return
        }
        
        apiUpdate(promoCodeId: promoObj?.id ?? 0 ) {
            didDone?()
        }
    }
    
    func actionDelete(obj: PromoCodeModel) {
        
        apiDelete(promoCodeId: obj.id)
    }
    
    //MAKE: ApiCalling
    func apiList(){
        ServiceCall.post(parameter: [:], path: Globs.SV_PROMO_CODE_LIST, isToken: true) { responseObj in
            
            if let responseObj = responseObj as? NSDictionary {
                if (responseObj.value(forKey: KKey.status) as? String ?? "" == "1"){
                        
                    self.listArr = (responseObj.value(forKey: KKey.payload) as? [NSDictionary] ?? []).map({ obj in
                        return PromoCodeModel(dict: obj)
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
        ServiceCall.post(parameter: [
            
            "code": txtCode ,
            "title": txtTitle ,
            "description": txtDescription,
            "start_date": selectStateDate.displayDate(format: "yyyy-MM-dd"),
            "end_date":selectEndDate.displayDate(format: "yyyy-MM-dd"),
            "type": selectType,
            "min_order_amount": txtMinOrderAmount,
            "max_discount_amount": txtMaxDiscount,
            "offer_price": txtOfferPrice,
            
        
        ], path: Globs.SV_PROMO_CODE_ADD, isToken: true) { responseObj in
            
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
    
    func apiUpdate(promoCodeId: Int,didDone: ( ()->() )?){
        
        ServiceCall.post(parameter: ["promo_code_id": promoCodeId, 
                                     "title": txtTitle ,
                                     "description": txtDescription,
                                     "start_date": selectStateDate.displayDate(format: "yyyy-MM-dd"),
                                     "end_date":selectEndDate.displayDate(format: "yyyy-MM-dd"),
                                     "type": selectType,
                                     "min_order_amount": txtMinOrderAmount,
                                     "max_discount_amount": txtMaxDiscount,
                                     "offer_price": txtOfferPrice ], path: Globs.SV_PROMO_CODE_UPDATE, isToken: true) { responseObj in
            
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
    
    func apiDelete(promoCodeId: Int){
        
        ServiceCall.post(parameter: ["promo_code_id": promoCodeId ], path: Globs.SV_PROMO_CODE_DELETE, isToken: true) { responseObj in
            
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
