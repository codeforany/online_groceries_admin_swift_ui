//
//  TypeAddView.swift
//  OnlineGroceriesAdminSwiftUI
//
//  Created by CodeForAny on 23/05/24.
//

import SwiftUI
import SDWebImageSwiftUI

struct TypeAddView: View {
    @Environment(\.presentationMode) var mode:Binding<PresentationMode>
    @StateObject var tVM = TypeViewModel.shared
    
    @State var showImagePicker = false
    @State var showPhotoLibrary = false
    @State var showCamera = false
    
    var body: some View {
        ZStack{
            VStack{
                
                HStack{
                    
                    Button(action: {
                        
                        mode.wrappedValue.dismiss()
                    }, label: {
                            
                        Image("back")
                            .resizable()
                            .scaledToFit()
                            .frame(width: 20, height: 20)
                        
                    })
                    .frame(width: 40, height: 40)
                    
                    Text( tVM.isEdit ? "Edit Product Type" : "Add Product Type")
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
                        LineTextField(title: "Product Type Name", placholder: "Enter Type Name" , txt: $tVM.txtName)
                        LineTextField(title: "Color", placholder: "Enter Type Color" , txt: $tVM.txtColor)
                        
                        ZStack {
                            
                            RoundedRectangle(cornerRadius: 10)
                                .fill( Color.white)
                                .frame(width: .screenWidth - 40, height: .screenWidth - 40, alignment: .center )
                                .shadow(radius: 2)
                            
                            
                            if let image = tVM.image {
                                Image(uiImage: image)
                                    .resizable()
                                    .scaledToFit()
                                    .frame(width: .screenWidth - 40, height: .screenWidth - 40, alignment: .center )
                                    .cornerRadius(10)
                            }else if ( tVM.isEdit ) {
                                WebImage(url: URL(string: tVM.catObj?.image ?? ""))
                                    .resizable()
                                    .indicator(.activity)
                                    .transition(.fade(duration: 0.5))
                                    .scaledToFit()
                                    .frame(width: .screenWidth - 40, height: .screenWidth - 40, alignment: .center )
                                    .cornerRadius(10)
                            }else{
                                Image(systemName: "photo.fill")
                                    .font(.system(size: 100))
                                    .scaledToFit()
                                    .frame(width: 200, height: 200, alignment: .center )
                            }
                            
                            
                        }
                        .padding(.vertical, 20)
                        .onTapGesture {
                            showImagePicker = true
                        }
                        
                        RoundButton(title: tVM.isEdit ? "Update" : "Add") {
                            if(tVM.isEdit) {
                                tVM.actionUpdate {
                                    mode.wrappedValue.dismiss()
                                }
                            }else{
                                tVM.actionAdd {
                                    mode.wrappedValue.dismiss()
                                }
                            }
                        }
                    }
                    .padding(20)
                    
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
                }
            ,
                .destructive(Text("Cancel"))
            ])
        })
        .sheet(isPresented: $showPhotoLibrary, content: {
            ImagePicker(sourceType: .photoLibrary) {
                image in
                tVM.image = image
            }
        })
        
        .sheet(isPresented: $showCamera, content: {
            ImagePicker(sourceType: .camera) {
                image in
                tVM.image = image
            }
        })
        .alert(isPresented: $tVM.showError, content: {
            Alert(title: Text(Globs.AppName), message: Text( tVM.errorMessage ), dismissButton: .default(Text("OK")))
        })
        .background( Color.white )
        .navigationTitle("")
        .navigationBarBackButtonHidden()
        .navigationBarHidden(true)
        .ignoresSafeArea()
    }
}

#Preview {
    TypeAddView()
}
