//
//  OfferProductCell.swift
//  OnlineGroceriesAdminSwiftUI
//
//  Created by CodeForAny on 13/06/24.
//

import SwiftUI
import SDWebImageSwiftUI

struct OfferProductCell: View {
    @State var pObj: OfferProductModel = OfferProductModel(dict: [:])
   
    var didDelete: ( () -> () )?
    
    var body: some View {
        
        VStack{
            
            WebImage(url: URL(string: pObj.image))
                .resizable()
                .indicator(.activity)
                .transition(.fade(duration: 0.5))
                .scaledToFit()
                .frame(width: 100, height: 100)
            
            Spacer()
            
            Text(pObj.name)
                .font(.customfont(.bold, fontSize: 16))
                .foregroundColor(.primaryText)
                .frame(maxWidth: .infinity, alignment: .leading)
            
            Text("\( pObj.unitValue ) \(pObj.unitName), price")
                .font(.customfont(.medium, fontSize: 14))
                .foregroundColor(.secondaryText)
                .frame(maxWidth: .infinity, alignment: .leading)
            
            Spacer()
            
            HStack(spacing: 8){
                
                
                VStack(alignment: .leading){
                    Text("$\( pObj.offerPrice ?? pObj.price, specifier: "%.2f" )")
                        .font(.customfont(.semibold, fontSize: 18))
                        .foregroundColor(.red)
                        .frame(maxWidth: .infinity, alignment: .leading)
                    
                    Text("$\( pObj.price, specifier: "%.2f" )")
                        .font(.customfont(.semibold, fontSize: 14))
                        .foregroundColor(.primaryText)
                        .overlay(
                            Rectangle()
                                .fill( Color.primaryText)
                                .frame(height: 1, alignment: .center)
                        )
                }
                
                Button {
                    didDelete?()
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
            }
            
        }
        .padding(15)
        .frame( height: 230)
        .frame( maxWidth: .infinity)
        .overlay( RoundedRectangle(cornerRadius: 16)
            .stroke( Color.placeholder.opacity(0.5), lineWidth: 1))
    }
}

#Preview {
    OfferProductCell()
}
