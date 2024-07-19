//
//  OfferView.swift
//  OnlineGroceriesAdminSwiftUI
//
//  Created by CodeForAny on 13/06/24.
//

import SwiftUI

struct OfferView: View {
    @StateObject var pVM = OfferViewModel.shared
    
    var colums = [
        GridItem(.flexible(), spacing: 15),
        GridItem(.flexible(), spacing: 15)
    ]
    
    var body: some View {
        ZStack{
            VStack{
                
                HStack{
                    
                 
                    
                    Spacer()
                    
                    Text("Offer")
                        .font(.customfont(.bold, fontSize: 20))
                        .frame(height: 46)
                    
                    Spacer()
                    
                    
                   
                    
                }
                .padding(.top, .topInsets)
                .padding(.horizontal, 20)
                
                if pVM.listArr.isEmpty {
                    Spacer()
                    
                    Text("No Offer")
                        .font(.customfont(.bold, fontSize: 20))
                        .foregroundColor( Color.placeholder )
                        .frame(maxWidth: .infinity, alignment: .center)
                    
                    Spacer()
                }else{
                    ScrollView{
                        LazyVGrid(columns: colums, spacing: 15) {
                            
                            ForEach(0 ..< pVM.listArr.count, id:\.self) {
                                index in
                                
                                let obj = pVM.listArr[index]
                                OfferProductCell(pObj: obj)  {
                                    pVM.actionDelete(obj: obj)
                                }
                               

                            }
                        }
                        .padding(.vertical, 10)
                        .padding(.bottom, .bottomInsets + 60)
                        .padding(.horizontal, 20)
                    }
                }

            }
            
        }
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
    OfferView()
}
