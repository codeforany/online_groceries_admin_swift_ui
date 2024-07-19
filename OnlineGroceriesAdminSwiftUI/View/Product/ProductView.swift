//
//  ProductView.swift
//  OnlineGroceriesAdminSwiftUI
//
//  Created by CodeForAny on 08/06/24.
//

import SwiftUI

struct ProductView: View {
    
    @StateObject var pVM = ProductViewModel.shared
    
    var colums = [
        GridItem(.flexible(), spacing: 15),
        GridItem(.flexible(), spacing: 15)
    ]
    
    var body: some View {
        ZStack{
            VStack{
                
                HStack{
                    
                    EmptyView()
                        .frame(width: 40, height: 40)
                    
                    Spacer()
                    
                    Text("Products")
                        .font(.customfont(.bold, fontSize: 20))
                        .frame(height: 46)
                    
                    Spacer()
                    
                    
                    Button {
                        pVM.actionOpenAdd()
                    } label: {
                        Image("add_green")
                            .resizable()
                            .scaledToFit()
                            .frame(width: 20, height: 20)
                    }
                    .frame(width: 40, height: 40)

                    
                }
                .padding(.top, .topInsets)
                .padding(.horizontal, 20)
                
                ScrollView{
                    LazyVGrid(columns: colums, spacing: 15) {
                        
                        ForEach(0 ..< pVM.listArr.count, id:\.self) {
                            index in
                            
                            let obj = pVM.listArr[index]
                            ProductCell(pObj: obj) {
                                pVM.actionEdit(obj: obj)
                            } didDelete: {
                                pVM.actionDelete(obj: obj)
                            }
                            .onTapGesture {
                                pVM.selectOfferProduct = obj
                                pVM.showOfferAdd = true
                            }

                        }
                    }
                    .padding(.vertical, 10)
                    .padding(.bottom, .bottomInsets + 60)
                    .padding(.horizontal, 20)
                }
            }
            
        }
        .onAppear(){
            pVM.apiList()
        }
        .background( NavigationLink(destination: ProductAddView(), isActive: $pVM.showAdd,  label: {
            EmptyView()
        }) )
            .background( NavigationLink(destination: OfferAddView(), isActive: $pVM.showOfferAdd,  label: {
                EmptyView()
            }) )
            
        .background( NavigationLink(destination: ProductInfoEditView(), isActive: $pVM.isEdit,  label: {
            EmptyView()
        }) )
        .alert(isPresented: $pVM.showError, content: {
            Alert(title: Text(Globs.AppName), message: Text( pVM.errorMessage ), dismissButton: .default(Text("OK")))
        })
        .onAppear(){
            pVM.apiList()
        }
        .navigationTitle("")
        .navigationBarBackButtonHidden()
        .navigationBarHidden(true)
        .ignoresSafeArea()
    }
}

#Preview {
    ProductView()
}
