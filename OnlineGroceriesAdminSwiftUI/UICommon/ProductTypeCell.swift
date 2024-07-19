//
//  ProductTypeCell.swift
//  OnlineGroceriesAdminSwiftUI
//
//  Created by CodeForAny on 23/05/24.
//

import SwiftUI
import SDWebImageSwiftUI

struct ProductTypeCell: View {
    @State var tObj: TypeModel = TypeModel(dict: [ : ])
    var onEdit: (()->())?
    var onDelete: (()->())?
   
    
    var body: some View {
        
        ZStack(alignment: .bottom){
            VStack{
                
                WebImage(url: URL(string: tObj.image ))
                    .resizable()
                    .indicator(.activity) // Activity Indicator
                    .transition(.fade(duration: 0.5))
                    .scaledToFit()
                    .frame(width: 120, height: 90)
                
            
                Spacer()
                Text(tObj.name)
                    .font(.customfont(.bold, fontSize: 16))
                    .multilineTextAlignment(.center)
                    .foregroundColor(.primaryText)
                    .frame(minWidth: 0, maxWidth: .infinity, alignment: .center)
                    .padding(.bottom, 15)
                
                
                
            }
            .padding(15)
            
            
            HStack{
                    
                Button(action: {
                    onEdit?()
                }, label: {
                    Image(systemName: "pencil.line")
                        .foregroundColor(.primaryText)
                })
                
                Button(action: {
                    onDelete?()
                }, label: {
                    Image(systemName: "trash.fill")
                        .foregroundColor(.primaryText)
                })
                
            }
            .padding(.horizontal, 10)
            .padding(.vertical, 4)
            .background( tObj.color )
            .cornerRadius(10, corner: [.topLeft, .topRight])
        }
        
        .background( tObj.color.opacity(0.3) )
        .cornerRadius(16)
        .overlay (
            RoundedRectangle(cornerRadius: 16)
                .stroke(tObj.color, lineWidth: 1)
        )
    }}

struct ProductTypeCell_Previews: PreviewProvider {
    static var previews: some View {
        ProductTypeCell(tObj: TypeModel(dict: [ "type_id": 1,
                                                               "type_name": "Pulses",
                                                               "image": "http://192.168.1.3:3001/img/type/202307261610181018aVOpgmY1W1.png",
                                                               "color": "F8A44C"]) )
        .padding(20)
    }
}


