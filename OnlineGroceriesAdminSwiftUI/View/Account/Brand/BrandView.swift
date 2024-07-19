//
//  BrandView.swift
//  OnlineGroceriesAdminSwiftUI
//
//  Created by CodeForAny on 13/05/24.
//

import SwiftUI

struct BrandView: View {
    @Environment(\.presentationMode) var mode:Binding<PresentationMode>
    @StateObject var bVM = BrandViewModel.shared
    var body: some View {
        ZStack{
            
            if(bVM.listArr.isEmpty) {
                Text("Brand is Empty")
                    .font(.customfont(.bold, fontSize: 20))
            }
            
            ScrollView{
                
                LazyVStack(spacing: 8, content: {
                    ForEach( bVM.listArr , id: \.id) { bObj in
                        
                        HStack{
                            
                            Text(bObj.brandName)
                                .font(.customfont(.medium, fontSize: 17))
                                .frame(maxWidth: .infinity, alignment: .leading)
                            
                            Button(action: {
                                bVM.actionEdit(obj: bObj)
                            }, label: {
                                Image(systemName: "pencil.line")
                                    .foregroundColor(.primaryApp)
                            })
                            Button(action: {
                                bVM.actionDelete(obj: bObj)
                            }, label: {
                                Image(systemName: "trash.fill")
                                    .foregroundColor(.red)
                            })
                        }
                    }
                    .frame(height: 50)
                    .padding(.horizontal, 15)
                    .background( Color.white )
                    .cornerRadius(5)
                    .shadow(radius: 2)
                })
                .padding(20)
                .padding(.top, .topInsets + 46)
                .padding(.bottom, .bottomInsets )
                
            }
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
                    
                    Text("Brands")
                        .font(.customfont(.bold, fontSize: 20))
                        .frame(maxWidth: .infinity, alignment: .center)
                    
                    
                    Button(action: {
                        bVM.actionOpenAdd()
                        
                    }, label: {
                            
                        Image("add_green")
                            .resizable()
                            .scaledToFit()
                            .frame(width: 20, height: 20)
                        
                    })
                    .frame(width: 40, height: 40)
                    
                }
                .padding(.top, .topInsets)
                .padding(.horizontal, 8)
                .background( Color.white )
                .shadow(radius: 2)
                
                Spacer()
            }
            
        }
        .onAppear(){
            bVM.apiList()
        }
        .background( NavigationLink(destination: BrandAddView(), isActive: $bVM.showAddEdit, label: {
            EmptyView()
        }) )
        .alert(isPresented: $bVM.showError, content: {
            Alert(title: Text(Globs.AppName), message: Text( bVM.errorMessage ), dismissButton: .default(Text("OK")))
        })
        .background( Color.white )
        .navigationTitle("")
        .navigationBarBackButtonHidden()
        .navigationBarHidden(true)
        .ignoresSafeArea()
    }
}

#Preview {
    BrandView()
}
