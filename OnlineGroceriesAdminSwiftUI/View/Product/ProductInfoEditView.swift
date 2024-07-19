//
//  ProductInfoEditView.swift
//  OnlineGroceriesAdminSwiftUI
//
//  Created by CodeForAny on 09/06/24.
//

import SwiftUI
import SDWebImageSwiftUI

struct ProductInfoEditView: View {
    
    @Environment(\.presentationMode) var mode: Binding<PresentationMode>
    @StateObject var pVM = ProductViewModel.shared
    
    @State var showImagePicker = false
    @State var showPhotoLibrary = false
    @State var showCamera = false
    
    var colums = [
        GridItem( .flexible(), spacing: 15 ),
        GridItem( .flexible(), spacing: 15 )
    ]
    
    var body: some View {
        ZStack{
            VStack(spacing: 0){
                
                HStack{
                    Button {
                        mode.wrappedValue.dismiss()
                    } label: {
                        Image("back")
                            .resizable()
                            .scaledToFit()
                            .frame(width: 20, height: 20)
                    }
                    .frame(width: 40, height: 40)
                    
                    
                    Text("Edit Product Info")
                        .font(.customfont(.bold, fontSize: 20))
                        .frame(maxWidth: .infinity, alignment: .center)
                    
                    EmptyView()
                        .frame(width: 40, height: 40)

                }
                .padding(.top, .topInsets)
                .padding(.horizontal, 8)
                .background( Color.white )
                .shadow(radius: 2)
                
                ScrollView{
                    
                    VStack(spacing: 15){
                        
                        LineTextField(title: "Product Name" , placholder: "Enter Product Name" , txt: $pVM.txtName)
                        LineTextField(title: "Detail" , placholder: "Enter Product Detail" , txt: $pVM.txtDetail)
                        
                        VStack{
                            
                            Text("Category")
                                .font(.customfont(.semibold, fontSize: 16))
                                .foregroundColor(.textTitle)
                                .frame(minWidth: 0, maxWidth: .infinity, alignment: .leading)
                            
                            Menu {
                                
                                ForEach(0..<pVM.categoryArr.count, id: \.self) {
                                    index in
                                    
                                    let obj = pVM.categoryArr[index]
                                    Button {
                                        pVM.selectCategory = obj
                                    } label: {
                                        Text(obj.value(forKey: "cat_name") as? String ?? "" )
                                    }

                                }
                                
                            } label: {
                                
                                let name = pVM.selectCategory?.value(forKey: "cat_name") as? String ?? ""
                                
                                HStack{
                                    Text( name == "" ? "Select Category" : name )
                                        .font(.customfont(.semibold, fontSize: 16))
                                        .foregroundColor( name == "" ? .placeholder : .primaryText)
                                        .frame(minWidth: 0, maxWidth: .infinity, alignment: .leading)
                                    
                                    Image(systemName: "arrowtriangle.down.fill")
                                        .font(.system(size: 12))
                                    
                                }
                            }
                            .foregroundColor(.primaryText)
                            .frame(height: 40)

                            
                            
                            Divider()
                            
                        }
                        .padding(.bottom, 8)
                        
                        
                        VStack{
                            
                            Text("Brand")
                                .font(.customfont(.semibold, fontSize: 16))
                                .foregroundColor(.textTitle)
                                .frame(minWidth: 0, maxWidth: .infinity, alignment: .leading)
                            
                            Menu {
                                
                                ForEach(0..<pVM.brandArr.count, id: \.self) {
                                    index in
                                    
                                    let obj = pVM.brandArr[index]
                                    Button {
                                        pVM.selectBrand = obj
                                    } label: {
                                        Text(obj.value(forKey: "brand_name") as? String ?? "" )
                                    }

                                }
                                
                            } label: {
                                
                                let name = pVM.selectBrand?.value(forKey: "brand_name") as? String ?? ""
                                
                                HStack{
                                    Text( name == "" ? "Select Brand" : name )
                                        .font(.customfont(.semibold, fontSize: 16))
                                        .foregroundColor( name == "" ? .placeholder : .primaryText)
                                        .frame(minWidth: 0, maxWidth: .infinity, alignment: .leading)
                                    
                                    Image(systemName: "arrowtriangle.down.fill")
                                        .font(.system(size: 12))
                                    
                                }
                            }
                            .foregroundColor(.primaryText)
                            .frame(height: 40)

                            
                            
                            Divider()
                            
                        }
                        .padding(.bottom, 8)
                        
                        VStack{
                            
                            Text("Type")
                                .font(.customfont(.semibold, fontSize: 16))
                                .foregroundColor(.textTitle)
                                .frame(minWidth: 0, maxWidth: .infinity, alignment: .leading)
                            
                            Menu {
                                
                                ForEach(0..<pVM.typeArr.count, id: \.self) {
                                    index in
                                    
                                    let obj = pVM.typeArr[index]
                                    Button {
                                        pVM.selectType = obj
                                    } label: {
                                        Text(obj.value(forKey: "type_name") as? String ?? "" )
                                    }

                                }
                                
                            } label: {
                                
                                let name = pVM.selectType?.value(forKey: "type_name") as? String ?? ""
                                
                                HStack{
                                    Text( name == "" ? "Select Type" : name )
                                        .font(.customfont(.semibold, fontSize: 16))
                                        .foregroundColor( name == "" ? .placeholder : .primaryText)
                                        .frame(minWidth: 0, maxWidth: .infinity, alignment: .leading)
                                    
                                    Image(systemName: "arrowtriangle.down.fill")
                                        .font(.system(size: 12))
                                    
                                }
                            }
                            .foregroundColor(.primaryText)
                            .frame(height: 40)

                            Divider()
                            
                        }
                        .padding(.bottom, 8)
                        
                        LineTextField(title: "Unit Name", placholder: "Enter Unit Name" , txt: $pVM.txtUnitName)
                        
                        LineTextField(title: "Unit Value", placholder: "Enter Unit Value" , txt: $pVM.txtUnitValue)
                        
                        LineTextField(title: "Nutrition Weight", placholder: "Enter Nutrition Weight" , txt: $pVM.txtNutritionWeight)
                        
                        LineTextField(title: "Price", placholder: "Enter Price" , txt: $pVM.txtPrice)
                        
                        
                        RoundButton(title: "Update") {
                            pVM.actionUpdate {
                                mode.wrappedValue.dismiss()
                            }
                        }.padding(.vertical, 20)
                        
                        
                        Text("Nutrition List")
                            .font(.customfont(.bold, fontSize: 20))
                            .foregroundColor(.primaryText)
                            .frame( maxWidth: .infinity, alignment: .leading)
                        
                        
                        HStack{
                            
                            LineTextField( title: "Name", placholder: "Enter Name", txt: $pVM.txtNutritionName )
                            
                            LineTextField( title: "Value", placholder: "Enter Value", txt: $pVM.txtNutritionValue )
                            
                            Button {
                                pVM.actionNutritionAdd()
                            } label: {
                                Image("add_green")
                                    .resizable()
                                    .scaledToFit()
                                    .frame(width: 20, height: 20)
                            }
                            .frame(width: 40, height: 40)

                            
                        }
                        
                        
                        LazyVStack(spacing: 15) {
                            ForEach(0..<pVM.productNutritionArr.count, id: \.self) {
                                index in
                                
                                var obj = pVM.productNutritionArr[index]
                                
                                VStack(spacing:0) {
                                    
                                    HStack{
                                        Text(obj.nutritionName)
                                            .font(.customfont(.semibold, fontSize: 16))
                                            .frame(maxWidth: .infinity, alignment: .leading)
                                            
                                        Text(obj.nutritionValue)
                                            .font(.customfont(.semibold, fontSize: 16))
                                            .foregroundColor(.textTitle)
                                        
                                        
                                        Button {
                                            pVM.actionNutritionDelete(obj: obj)
                                        } label: {
                                            Image(systemName: "trash.fill")
                                                .resizable()
                                                .scaledToFit()
                                                .frame(width: 20, height: 20)
                                        }
                                        .foregroundColor(.white)
                                        
                                        .frame(width: 30, height: 30)
                                        .background( Color.red )
                                        .cornerRadius(10)

                                        
                                    }.foregroundColor(.primaryText)
                                    .frame(height: 40)
                                    
                                    Divider()
                                }
                            }
                        }
                        
                        
                        HStack{
                            Text("Product Images")
                                .font(.customfont(.bold, fontSize: 20))
                                .foregroundColor(.primaryText)
                                .frame( maxWidth: .infinity, alignment: .leading)
                            
                            Button {
                               showImagePicker = true
                            } label: {
                                Image("add_green")
                                    .resizable()
                                    .scaledToFit()
                                    .frame(width: 20, height: 20)
                            }
                            .frame(width: 40, height: 40)
                        }
                        
                        
                        LazyVGrid(columns: colums, spacing: 15) {
                            ForEach(0..<pVM.productImageArr.count, id: \.self) {
                                index in
                                
                                var obj = pVM.productImageArr[index]
                                ZStack(alignment: .topTrailing) {
                                    
                                    WebImage(url: URL(string: obj.image ))
                                        .resizable()
                                        .indicator(.activity)
                                        .aspectRatio(1, contentMode: .fill)
                                        .background( Color.white )
                                        .cornerRadius(15)
                                        .shadow(radius: 2)
                                    
                                    Button {
                                        pVM.actionImageDelete(obj: obj)
                                    } label: {
                                        Image(systemName: "trash.fill")
                                            .resizable()
                                            .scaledToFit()
                                            .frame(width: 20, height: 20)
                                    }
                                    .foregroundColor(.white)
                                    
                                    .frame(width: 30, height: 30)
                                    .background( Color.red )
                                    .cornerRadius(10)
                                    .padding(8)
                                }
                                
                            }
                        }
                        
                        
                    }
                    .padding(.top, 8)
                    .padding(.horizontal, 20)
                    .padding(.bottom, .bottomInsets + 8)
                    
                }
                
            }
        }
        .actionSheet(isPresented: $showImagePicker, content: {
            ActionSheet(title: Text("Select"), buttons: [
                
                .default(Text("Photo Library")) {
                    showPhotoLibrary = true
                },
                
                    .default(Text("Camera")) {
                        showCamera = true
                    },
                .destructive(Text("Cancel"))
            
            ])
        })
        .sheet(isPresented: $showPhotoLibrary, content: {
            ImagePicker(sourceType: .photoLibrary) {
                image in
                
                pVM.image = image
                pVM.actionImageAdd()
            }
        })
        .sheet(isPresented: $showCamera, content: {
            ImagePicker(sourceType: .camera) {
                image in
                
                pVM.image = image
                pVM.actionImageAdd()
            }
        })
        .alert(isPresented: $pVM.showError, content: {
            Alert(title: Text(Globs.AppName), message: Text(pVM.errorMessage), dismissButton: .default(Text("OK")))
        })
        .background( Color.white)
        .navigationTitle("")
        .navigationBarBackButtonHidden()
        .navigationBarHidden(true)
        .ignoresSafeArea()
    }
}

#Preview {
    ProductInfoEditView()
}
