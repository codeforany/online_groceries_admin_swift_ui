//
//  PromoCodeView.swift
//  OnlineGroceriesAdminSwiftUI
//
//  Created by CodeForAny on 26/05/24.
//

import SwiftUI

struct PromoCodeView: View {
    @Environment(\.presentationMode) var mode:Binding<PresentationMode>
    @StateObject var pVM = PromoCodeViewModel.shared
    
    var body: some View {
        ZStack{
            
            if(pVM.listArr.isEmpty) {
                Text("Promo Code is Empty")
                    .font(.customfont(.bold, fontSize: 20))
            }
            
            ScrollView{
                
                LazyVStack(spacing: 8, content: {
                    ForEach( pVM.listArr , id: \.id) { pObj in
                        
                        
                        VStack{
                            HStack {
                                Text(pObj.title)
                                    .font(.customfont(.bold, fontSize: 14))
                                    .foregroundColor(.primaryText)
                                    .frame(minWidth: 0, maxWidth: .infinity, alignment: .leading)
                                
                                Text(pObj.code)
                                    .font(.customfont(.bold, fontSize: 15))
                                    .foregroundColor(.primaryApp)
                                    .padding(.horizontal, 8)
                                    .padding(.vertical, 2)
                                    .background(Color.secondaryText.opacity(0.3))
                                    .cornerRadius(5)
                            }
                            
                            Text(pObj.description)
                                .font(.customfont(.medium, fontSize: 14))
                                .foregroundColor(.secondaryText)
                                .multilineTextAlignment( .leading)
                                .frame(minWidth: 0, maxWidth: .infinity, alignment: .leading)
                            
                            HStack{
                                Text("Expiry Date:")
                                    .font(.customfont(.bold, fontSize: 14))
                                    .foregroundColor(.primaryText)
                                    .padding(.vertical, 8)
                                    
                                
                                Text( pObj.endDate.displayDate(format: "yyyy-MM-dd hh:mm a") )
                                    .font(.customfont(.bold, fontSize: 12))
                                    .foregroundColor(.secondaryText)
                                    .padding(.vertical, 8)
                                    .frame(minWidth: 0, maxWidth: .infinity, alignment: .leading)
                            }
                            
                            HStack{
                                
                                Spacer()
                                Button(action: {
                                    pVM.actionEdit(obj: pObj)
                                }, label: {
                                    Image(systemName: "pencil.line")
                                        .foregroundColor(.primaryApp)
                                })
                                Button(action: {
                                    pVM.actionDelete(obj: pObj)
                                }, label: {
                                    Image(systemName: "trash.fill")
                                        .foregroundColor(.red)
                                })
                            }
                        }
                        .padding(15)
                        .background(Color.white)
                        .cornerRadius(5)
                        .shadow(color: Color.black.opacity(0.15), radius: 2)
                        
                    }
                    
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
                    
                    Text("Promo Code")
                        .font(.customfont(.bold, fontSize: 20))
                        .frame(maxWidth: .infinity, alignment: .center)
                    
                    
                    Button(action: {
                        pVM.actionOpenAdd()
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
            pVM.apiList()
        }
        .background( NavigationLink(destination: PromoCodeAddView(), isActive: $pVM.showAddEdit, label: {
            EmptyView()
        }) )

        .alert(isPresented: $pVM.showError, content: {
            Alert(title: Text(Globs.AppName), message: Text( pVM.errorMessage ), dismissButton: .default(Text("OK")))
        })
        .background( Color.white )
        .navigationTitle("")
        .navigationBarBackButtonHidden()
        .navigationBarHidden(true)
        .ignoresSafeArea()
    }
}

#Preview {
    PromoCodeView()
}
