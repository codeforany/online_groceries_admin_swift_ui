//
//  OfferViewModel.swift
//  OnlineGroceriesAdminSwiftUI
//
//  Created by CodeForAny on 13/06/24.
//

import SwiftUI

class OfferViewModel: ObservableObject {
    static let shared: OfferViewModel = OfferViewModel()
    
    @Published var listArr: [OfferProductModel] = [];

    
    @Published var txtOfferPrice = ""
    @Published var selectStateDate = Date()
    @Published var selectEndDate = Date()
    
    
    @Published var showError = false
    @Published var errorMessage = ""
    
    init() {
        
    }
    
    //MARK: Action
    func actionOpenAdd(){
        txtOfferPrice = ""
        selectStateDate = Date()
        selectEndDate = Date()
    }
    
    func actionAdd(obj: ProductModel, didDone: ( ()->() )? ){
      
        
        if(txtOfferPrice.isEmpty) {
            self.errorMessage = "Please enter offer price"
            self.showError = true
            return
        }
        
        apiAdd(obj: obj) {
            didDone?()
        }
    }
    
  
    
    func actionDelete(obj: OfferProductModel) {
        
        apiDelete(offerId: obj.id)
    }
    
    //MAKE: ApiCalling
    func apiList(){
        ServiceCall.post(parameter: [:], path: Globs.SV_OFFER_PRODUCT_LIST, isToken: true) { responseObj in
            
            if let responseObj = responseObj as? NSDictionary {
                if (responseObj.value(forKey: KKey.status) as? String ?? "" == "1"){
                        
                    self.listArr = (responseObj.value(forKey: KKey.payload) as? [NSDictionary] ?? []).map({ obj in
                        return OfferProductModel(dict: obj)
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
    
    
    func apiAdd(obj: ProductModel, didDone: ( ()->() )?){
        ServiceCall.post(parameter: [
            "prod_id": obj.prodId,
            "start_date": selectStateDate.displayDate(format: "yyyy-MM-dd"),
            "end_date":selectEndDate.displayDate(format: "yyyy-MM-dd"),
            "price": txtOfferPrice,
        ], path: Globs.SV_OFFER_ADD, isToken: true) { responseObj in
            
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
    
    
    func apiDelete(offerId: Int){
        
        ServiceCall.post(parameter: ["offer_id": offerId ], path: Globs.SV_OFFER_DELETE, isToken: true) { responseObj in
            
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

