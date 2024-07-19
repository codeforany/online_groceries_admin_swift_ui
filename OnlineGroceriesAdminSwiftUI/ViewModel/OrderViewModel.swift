//
//  OrderViewModel.swift
//  OnlineGroceriesAdminSwiftUI
//
//  Created by CodeForAny on 17/06/24.
//

import SwiftUI

class OrderViewModel: ObservableObject {
    
    static let shared: OrderViewModel = OrderViewModel()
    
    @Published var newOrderArr: [MyOrderModel] = [];
    @Published var completedOrderArr: [MyOrderModel] = [];
    @Published var cancelOrderArr: [MyOrderModel] = [];
    
    @Published var cartArr: [OrderItemModel] = []
    
    @Published var orderDic: MyOrderModel?
    @Published var showDetail = false
    
    @Published var showError = false
    @Published var errorMessage = ""
    
    @Published var selectTab = 0
    
    
    //MARK: Action
    
    func actionOpenOrderDetil(obj: MyOrderModel) {
        self.orderDic = obj
        self.showDetail = true
        self.apiOrderDetail(orderId: obj.id, userId: obj.userId)
    }
    
    //MARK: ApiCalling
    
    func apiNewOrderList(){
        ServiceCall.post(parameter: [:], path: Globs.SV_NEW_ORDER_LIST, isToken: true) { responseObj in
            if let responseObj = responseObj as? NSDictionary {
                
                if (responseObj.value(forKey: KKey.status) as? String ?? "" == "1") {
                    self.newOrderArr = (responseObj.value(forKey: KKey.payload) as? [NSDictionary] ?? []).map({
                        obj in
                        return MyOrderModel(dict: obj)
                    })
                }else{
                    self.newOrderArr = []
                    self.errorMessage = responseObj.value(forKey: KKey.message) as? String ?? "fail"
                    self.showError = true
                }
                
            }else{
                self.newOrderArr = []
                
            }
        } failure: { error in
            self.errorMessage = error?.localizedDescription ?? "fail"
            self.showError = true
        }

    }
    
    func apiCompletedOrderList(){
        ServiceCall.post(parameter: [:], path: Globs.SV_COMPLETED_ORDER_LIST, isToken: true) { responseObj in
            if let responseObj = responseObj as? NSDictionary {
                
                if (responseObj.value(forKey: KKey.status) as? String ?? "" == "1") {
                    self.completedOrderArr = (responseObj.value(forKey: KKey.payload) as? [NSDictionary] ?? []).map({
                        obj in
                        return MyOrderModel(dict: obj)
                    })
                }else{
                    self.completedOrderArr = []
                    self.errorMessage = responseObj.value(forKey: KKey.message) as? String ?? "fail"
                    self.showError = true
                }
                
            }else{
                self.completedOrderArr = []
                
            }
        } failure: { error in
            self.errorMessage = error?.localizedDescription ?? "fail"
            self.showError = true
        }

    }
    
    func apiCancelOrderList(){
        ServiceCall.post(parameter: [:], path: Globs.SV_CANCEL_ORDER_LIST, isToken: true) { responseObj in
            if let responseObj = responseObj as? NSDictionary {
                
                if (responseObj.value(forKey: KKey.status) as? String ?? "" == "1") {
                    self.cancelOrderArr = (responseObj.value(forKey: KKey.payload) as? [NSDictionary] ?? []).map({
                        obj in
                        return MyOrderModel(dict: obj)
                    })
                }else{
                    self.cancelOrderArr = []
                    self.errorMessage = responseObj.value(forKey: KKey.message) as? String ?? "fail"
                    self.showError = true
                }
                
            }else{
                self.cancelOrderArr = []
                
            }
        } failure: { error in
            self.errorMessage = error?.localizedDescription ?? "fail"
            self.showError = true
        }

    }
    
    func apiOrderDetail(orderId: Int, userId: Int) {
        ServiceCall.post(parameter: ["order_id": orderId, "user_id": userId], path: Globs.SV_ORDER_DETAIL, isToken: true) { responseObj in
            
            if let responseObj = responseObj as? NSDictionary {
                if responseObj.value(forKey: KKey.status) as? String ?? "" == "1" {
                    let payload = responseObj.value(forKey: KKey.payload) as? NSDictionary ?? [:]
                    
                    
                    self.cartArr = (payload.value(forKey: "cart_list") as? [NSDictionary] ?? [] ).map({ obj in
                
                        return OrderItemModel(dict: obj)
                    })
                }else{
                    self.cartArr = []
                    self.errorMessage  = responseObj.value(forKey: KKey.message) as? String ?? "fail"
                    self.showError = true
                }
            }
        } failure: { error in
            self.errorMessage = error?.localizedDescription ?? "fail"
            self.showError = true
        }

    }
    
    func apiOrderStatusChange(orderId: Int, userId: Int, orderStatus: Int, didDone: ( () -> () )? ) {
        
        ServiceCall.post(parameter: ["order_id": orderId, "user_id": userId, "order_status": orderStatus], path: Globs.SV_ORDER_STATUS_CHANGE, isToken: true) { responseObj in
            if let responseObj = responseObj as? NSDictionary {
                if responseObj.value(forKey: KKey.status) as? String ?? "" == "1" {
                    let payload = responseObj.value(forKey: KKey.payload) as? NSDictionary ?? [:]
                    
                    
                    didDone?()
                    self.errorMessage  = responseObj.value(forKey: KKey.message) as? String ?? "success"
                    self.showError = true
                    
                    
                    
                }else{
                    
                    self.errorMessage  = responseObj.value(forKey: KKey.message) as? String ?? "fail"
                    self.showError = true
                }
            }
        } failure: { error in
            self.errorMessage = error?.localizedDescription ?? "fail"
            self.showError = true
        }

        
    }
    
}
