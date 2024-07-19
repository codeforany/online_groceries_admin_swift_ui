//
//  ProductViewModel.swift
//  OnlineGroceriesAdminSwiftUI
//
//  Created by CodeForAny on 06/06/24.
//

import SwiftUI

class ProductViewModel: ObservableObject {
    static let shared: ProductViewModel = ProductViewModel()
    
    @Published var listArr: [ProductModel] = [];
    @Published var prodObj: ProductModel?
    
    @Published var txtName = ""
    @Published var txtDetail = ""
    @Published var txtUnitName = ""
    @Published var txtUnitValue = ""
    @Published var txtNutritionWeight = ""
    @Published var txtPrice = ""
    
    @Published var selectCategory: NSDictionary?
    @Published var selectBrand: NSDictionary?
    @Published var selectType: NSDictionary?
    
    @Published var nutritionArr: [NutritionModel] = []
    @Published var imageArr: [UIImage] = []
    
    
    @Published var productDetailObj: ProductModel?
    @Published var productNutritionArr: [NutritionModel] = []
    @Published var productImageArr : [ImageModel] = []
    
    @Published var categoryArr: [NSDictionary] = []
    @Published var brandArr: [NSDictionary] = []
    @Published var typeArr: [NSDictionary] = []
    
    @Published var image: UIImage?
    
    @Published var selectNutritionObj: NutritionModel?
    @Published var txtNutritionName = ""
    @Published var txtNutritionValue = ""
    
    @Published var showError = false
    @Published var errorMessage = ""
    
    @Published var isEdit = false
    @Published var showAdd = false
    
    
    @Published var showOfferAdd = false
    @Published var selectOfferProduct: ProductModel?
    
    @Published var showArea = false
    
    init() {
            
        apiCategoryTypeBrandList()
    }
    
    //MARK: Action
    func actionOpenAdd(){
        prodObj = nil
        isEdit = false
        txtName = ""
        txtDetail = ""
        txtUnitName = ""
        txtUnitValue = ""
        txtNutritionWeight = ""
        txtNutritionName = ""
        txtNutritionValue = ""
        txtPrice = ""
        selectNutritionObj = nil
        
        selectCategory = nil
        selectBrand = nil
        selectType = nil
        
        nutritionArr = []
        imageArr = []
        image = nil
        showAdd = true
    }
    
    func actionAdd(didDone: ( ()->() )? ){
        if(txtName.isEmpty) {
            self.errorMessage = "Please enter product name"
            self.showError = true
            return
        }
        
        if(txtDetail.isEmpty) {
            self.errorMessage = "Please enter product detail"
            self.showError = true
            return
        }
        
        
        
        if selectCategory == nil {
            self.errorMessage = "Please select product category"
            self.showError = true
            return
        }
        
        if selectBrand == nil {
            self.errorMessage = "Please select product brand"
            self.showError = true
            return
        }
        
        if selectType == nil {
            self.errorMessage = "Please select product type"
            self.showError = true
            return
        }
        
        if(txtUnitName.isEmpty) {
            self.errorMessage = "Please enter product unit name"
            self.showError = true
            return
        }
        
        if(txtUnitValue.isEmpty) {
            self.errorMessage = "Please enter product unit value"
            self.showError = true
            return
        }
        
        if(txtNutritionWeight.isEmpty) {
            self.errorMessage = "Please enter nutrition weight"
            self.showError = true
            return
        }
        
        if(txtPrice.isEmpty) {
            self.errorMessage = "Please enter price"
            self.showError = true
            return
        }
        
       
        if(imageArr.isEmpty) {
            self.errorMessage = "Please select product image"
            self.showError = true
            return
        }
        
        apiAdd() {
            didDone?()
        }
    }
    
    func actionEdit(obj: ProductModel) {
        prodObj = obj
        txtName = obj.name
        txtDetail = obj.detail
        txtUnitName = obj.unitName
        txtUnitValue = obj.unitValue
        txtNutritionWeight = obj.nutritionWeight
        txtNutritionName = ""
        txtNutritionValue = ""
        txtPrice = "\(obj.price)"
        selectCategory = categoryArr.first(where: { nObj in
            return nObj.value(forKey:"cat_id") as? Int ?? -1  == obj.catId
        })
        
        
        selectBrand = brandArr.first(where: { nObj in
            return nObj.value(forKey:"brand_id") as? Int ?? -1  == obj.brandId
        })
        selectType = typeArr.first(where: { nObj in
            return nObj.value(forKey:"type_id") as? Int ?? -1  == obj.typeId
        })
        
        image = nil
        showAdd = false
        isEdit = true
        
        actionApiCallingDetail()
    }
    
    func actionUpdate(didDone: ( ()->() )?){
        
        if (prodObj == nil) {
            return
        }
        
        if(txtName.isEmpty) {
            self.errorMessage = "Please enter product name"
            self.showError = true
            return
        }
        
        if(txtDetail.isEmpty) {
            self.errorMessage = "Please enter product detail"
            self.showError = true
            return
        }
        
        
        
        if selectCategory == nil {
            self.errorMessage = "Please select product category"
            self.showError = true
            return
        }
        
        if selectBrand == nil {
            self.errorMessage = "Please select product brand"
            self.showError = true
            return
        }
        
        if selectType == nil {
            self.errorMessage = "Please select product type"
            self.showError = true
            return
        }
        
        if(txtUnitName.isEmpty) {
            self.errorMessage = "Please enter product unit name"
            self.showError = true
            return
        }
        
        if(txtUnitValue.isEmpty) {
            self.errorMessage = "Please enter product unit value"
            self.showError = true
            return
        }
        
        if(txtNutritionWeight.isEmpty) {
            self.errorMessage = "Please enter nutrition weight"
            self.showError = true
            return
        }
        
        if(txtPrice.isEmpty) {
            self.errorMessage = "Please enter price"
            self.showError = true
            return
        }
        
        apiUpdate(prodId: prodObj?.id ?? 0 ) {
            didDone?()
        }
    }
    
    func actionDelete(obj: ProductModel) {
        
        apiDelete(prodId: obj.id)
    }
        
    
    func actionOpenDetail(obj: ProductModel) {
        self.productDetailObj = nil
        self.productNutritionArr = []
        self.productImageArr = []
        prodObj = obj
        
        actionApiCallingDetail()
    }

    func actionApiCallingDetail(){
        apiProductDetail(prodId:  prodObj?.id ?? 0 )
    }
    
        
    func actionNewNutritionAdd(){
        if (txtNutritionName.isEmpty) {
            self.errorMessage = "Please enter product nutrition name"
            self.showError = true
            return
        }
        
        if (txtNutritionValue.isEmpty) {
            self.errorMessage = "Please enter product nutrition value"
            self.showError = true
            return
        }
        

        nutritionArr.append(NutritionModel(dict: ["nutrition_name" : txtNutritionName, "nutrition_value": txtNutritionValue] ))
        
        txtNutritionName = ""
        txtNutritionValue = ""
    }
    
    
    func actionNewNutritionDelete(obj: NutritionModel){
        
        if let index = nutritionArr.firstIndex(of: obj) {
            nutritionArr.remove(at: index)
        }
    }
    
    
    func actionNutritionAdd(){
        if (txtNutritionName.isEmpty) {
            self.errorMessage = "Please enter product nutrition name"
            self.showError = true
            return
        }
        
        if (txtNutritionValue.isEmpty) {
            self.errorMessage = "Please enter product nutrition value"
            self.showError = true
            return
        }
        

       apiNutritionAdd(parameter: [
        "prod_id" :  productDetailObj?.id ?? "",
        "nutrition_name": txtNutritionName
        ,
        "nutrition_value": txtNutritionValue
       ])
    }
    
    
    func actionNutritionDelete(obj: NutritionModel){
        apiNutritionDelete(parameter: ["prod_id" :  productDetailObj?.id ?? "", "nutrition_id" :  obj.id  ])
    }
    
    func actionImageAdd(){
        if image == nil {
            self.errorMessage = "Please select product image"
            self.showError = true
        }
        
        apiImageAdd()
    }
    
    func actionImageDelete(obj: ImageModel) {
        apiImageDelete(parameter: [
            "prod_id" :  productDetailObj?.id ?? "",
            "img_id": obj.id
        ])
    }
    
    
    //MAKE: ApiCalling
    func apiList(){
        ServiceCall.post(parameter: [:], path: Globs.SV_PRODUCT_LIST, isToken: true) { responseObj in
            
            if let responseObj = responseObj as? NSDictionary {
                if (responseObj.value(forKey: KKey.status) as? String ?? "" == "1"){
                        
                    self.listArr = (responseObj.value(forKey: KKey.payload) as? [NSDictionary] ?? []).map({ obj in
                        return ProductModel(dict: obj)
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
        
        
        var imgObj: [UIImage: String] = [:]
        
        imageArr.forEach({ img in
            imgObj[img] = "image"
       })
        
        
        ServiceCall.multipart(parameter: [
            "name": txtName,
            "detail": txtDetail,
            "cat_id": selectCategory?.value(forKey: "cat_id") ?? "",
            "brand_id": selectBrand?.value(forKey: "brand_id") ?? "",
            "type_id": selectType?.value(forKey: "type_id") ?? "",
            "unit_name": txtUnitName,
            "unit_value": txtUnitValue,
            
            "nutrition_weight": txtNutritionWeight,
            "price": txtPrice,
            "nutrition_data": Utils.jsonString(obj: nutritionArr.map({ nObj in
                return ["nutrition_name": nObj.nutritionName, "nutrition_value": nObj.nutritionValue]
            }), prettyPrint: false)
        ], path: Globs.SV_PRODUCT_ADD, imageDic: imgObj as NSDictionary, isToken: true, isUIImageKey : true) { responseObj in
            
            if let responseObj = responseObj as? NSDictionary {
                if (responseObj.value(forKey: KKey.status) as? String ?? "" == "1"){
                        
                    self.errorMessage = responseObj.value(forKey: KKey.message) as? String ?? "success"
                    self.showError = true
                    didDone?()
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
    
    func apiUpdate(prodId: Int,didDone: ( ()->() )?){
        
        ServiceCall.post(parameter: ["prod_id": prodId, "name": txtName,
                                     "detail": txtDetail,
                                     "cat_id": selectCategory?.value(forKey: "cat_id") ?? "",
                                     "brand_id": selectBrand?.value(forKey: "brand_id") ?? "",
                                     "type_id": selectType?.value(forKey: "type_id") ?? "",
                                     "unit_name": txtUnitName,
                                     "unit_value": txtUnitValue,
                                     
                                     "nutrition_weight": txtNutritionWeight,
                                     "price": txtPrice  ], path: Globs.SV_PRODUCT_UPDATE, isToken: true) {
            responseObj in
            
            if let responseObj = responseObj as? NSDictionary {
                if (responseObj.value(forKey: KKey.status) as? String ?? "" == "1"){
                        
                    self.errorMessage = responseObj.value(forKey: KKey.message) as? String ?? "success"
                    self.showError = true
                    didDone?()
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
    
    func apiDelete(prodId: Int){
        
        ServiceCall.post(parameter: ["prod_id": prodId ], path: Globs.SV_PRODUCT_DELETE, isToken: true) { responseObj in
            
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
    
    
    func apiCategoryTypeBrandList(){
        
        ServiceCall.post(parameter: [:], path: Globs.SV_PRODUCT_CATEGORY_TYPE_BRAND, isToken: true) { responseObj in
            
            if let responseObj = responseObj as? NSDictionary {
                if (responseObj.value(forKey: KKey.status) as? String ?? "" == "1"){
                            
                    var payload = responseObj.value(forKey: KKey.payload) as? NSDictionary ?? [:]
                    self.categoryArr = payload.value(forKey: "category_list") as? [NSDictionary] ?? []
                    self.brandArr = payload.value(forKey: "brand_list") as? [NSDictionary] ?? []
                    self.typeArr = payload.value(forKey: "type_list") as? [NSDictionary] ?? []
                    
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
    
    func apiProductDetail(prodId: Int){
        
        ServiceCall.post(parameter: ["prod_id": prodId], path: Globs.SV_PRODUCT_DETAIL, isToken: true) { responseObj in
            
            if let responseObj = responseObj as? NSDictionary {
                if (responseObj.value(forKey: KKey.status) as? String ?? "" == "1"){
                            
                    var payload = responseObj.value(forKey: KKey.payload) as? NSDictionary ?? [:]
                    self.productDetailObj = ProductModel(dict: payload)
                    self.productNutritionArr = (payload.value(forKey: "nutrition_list") as? [NSDictionary] ?? [] ).map({ obj in
                        return NutritionModel(dict: obj)
                    })
                    
                    self.productImageArr = (payload.value(forKey: "images") as? [NSDictionary] ?? [] ).map({ obj in
                        return ImageModel(dict: obj)
                    })
                    
                    
                    
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
    
    func apiImageAdd(){
        
        
        ServiceCall.multipart(parameter: [
            "prod_id": prodObj?.id ?? "",
        ], path: Globs.SV_PRODUCT_IMAGE_ADD, imageDic: ["image": image! ] , isToken: true) { responseObj in
            
            if let responseObj = responseObj as? NSDictionary {
                if (responseObj.value(forKey: KKey.status) as? String ?? "" == "1"){
                        
                    self.errorMessage = responseObj.value(forKey: KKey.message) as? String ?? "success"
                    self.showError = true
                   
                    self.actionApiCallingDetail()
        
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
    
    func apiImageDelete(parameter: NSDictionary){
        
        ServiceCall.post(parameter: parameter, path: Globs.SV_PRODUCT_IMAGE_DELETE, isToken: true) { responseObj in
            
            if let responseObj = responseObj as? NSDictionary {
                if (responseObj.value(forKey: KKey.status) as? String ?? "" == "1"){
                            
                    self.errorMessage = responseObj.value(forKey: KKey.message) as? String ?? "success"
                    self.showError = true
                   
                    self.actionApiCallingDetail()
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
    
    
    func apiNutritionAdd(parameter: NSDictionary){
        
        ServiceCall.post(parameter: parameter, path: Globs.SV_PRODUCT_NUTRITION_ADD, isToken: true) { responseObj in
            
            if let responseObj = responseObj as? NSDictionary {
                if (responseObj.value(forKey: KKey.status) as? String ?? "" == "1"){
                            
                    self.txtNutritionName = ""
                    self.txtNutritionValue = ""
                    self.errorMessage = responseObj.value(forKey: KKey.message) as? String ?? "success"
                    self.showError = true
                   
                    self.actionApiCallingDetail()
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
    
    func apiNutritionDelete(parameter: NSDictionary){
        
        ServiceCall.post(parameter: parameter, path: Globs.SV_PRODUCT_NUTRITION_DELETE, isToken: true) { responseObj in
            
            if let responseObj = responseObj as? NSDictionary {
                if (responseObj.value(forKey: KKey.status) as? String ?? "" == "1"){
                            
                    self.errorMessage = responseObj.value(forKey: KKey.message) as? String ?? "success"
                    self.showError = true
                   
                    self.actionApiCallingDetail()
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

