//
//  ExploreCategoryCell.swift
//  OnlineGroceriesSwiftUI
//
//  Created by CodeForAny on 06/08/23.
//

import SwiftUI
import SDWebImageSwiftUI

struct ExploreCategoryCell: View {
    @State var cObj: CategoryModel = CategoryModel(dict: [ : ])
    var onEdit: (()->())?
    var onDelete: (()->())?
   
    
    var body: some View {
        
        ZStack(alignment: .bottom){
            VStack{
                
                WebImage(url: URL(string: cObj.image ))
                    .resizable()
                    .indicator(.activity) // Activity Indicator
                    .transition(.fade(duration: 0.5))
                    .scaledToFit()
                    .frame(width: 120, height: 90)
                
            
                Spacer()
                Text(cObj.name)
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
            .background( cObj.color )
            .cornerRadius(10, corner: [.topLeft, .topRight])
        }
        
        .background( cObj.color.opacity(0.3) )
        .cornerRadius(16)
        .overlay (
            RoundedRectangle(cornerRadius: 16)
                .stroke(cObj.color, lineWidth: 1)
        )
    }}

struct ExploreCategoryCell_Previews: PreviewProvider {
    static var previews: some View {
        ExploreCategoryCell(cObj: CategoryModel(dict: [ "cat_id": 1,
                                                               "cat_name": "Pulses",
                                                               "image": "http://192.168.1.3:3001/img/type/202307261610181018aVOpgmY1W1.png",
                                                               "color": "F8A44C"]) )
        .padding(20)
    }
}
