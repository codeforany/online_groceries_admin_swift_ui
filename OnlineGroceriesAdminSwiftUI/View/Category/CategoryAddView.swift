//
//  CategoryAddView.swift
//  OnlineGroceriesAdminSwiftUI
//
//  Created by CodeForAny on 20/05/24.
//

import SwiftUI
import SDWebImageSwiftUI

struct CategoryAddView: View {
    @Environment(\.presentationMode) var mode:Binding<PresentationMode>
    @StateObject var cVM = CategoryViewModel.shared
    
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
                    
                    Text( cVM.isEdit ? "Edit Category" : "Add Category")
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
                        LineTextField(title: "Category Name", placholder: "Enter Category Name" , txt: $cVM.txtName)
                        LineTextField(title: "Color", placholder: "Enter Category Color" , txt: $cVM.txtColor)
                        
                        ZStack {
                            
                            RoundedRectangle(cornerRadius: 10)
                                .fill( Color.white)
                                .frame(width: .screenWidth - 40, height: .screenWidth - 40, alignment: .center )
                                .shadow(radius: 2)
                            
                            
                            if let image = cVM.image {
                                Image(uiImage: image)
                                    .resizable()
                                    .scaledToFit()
                                    .frame(width: .screenWidth - 40, height: .screenWidth - 40, alignment: .center )
                                    .cornerRadius(10)
                            }else if ( cVM.isEdit ) {
                                WebImage(url: URL(string: cVM.catObj?.image ?? ""))
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
                        
                        RoundButton(title: cVM.isEdit ? "Update" : "Add") {
                            if(cVM.isEdit) {
                                cVM.actionUpdate {
                                    mode.wrappedValue.dismiss()
                                }
                            }else{
                                cVM.actionAdd {
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
                cVM.image = image
            }
        })
        
        .sheet(isPresented: $showCamera, content: {
            ImagePicker(sourceType: .camera) {
                image in
                cVM.image = image
            }
        })
        .alert(isPresented: $cVM.showError, content: {
            Alert(title: Text(Globs.AppName), message: Text( cVM.errorMessage ), dismissButton: .default(Text("OK")))
        })
        .background( Color.white )
        .navigationTitle("")
        .navigationBarBackButtonHidden()
        .navigationBarHidden(true)
        .ignoresSafeArea()
    }
}

#Preview {
    CategoryAddView()
}
