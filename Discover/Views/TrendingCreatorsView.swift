//
//  TrendingCreatorsView.swift
//  Discover
//
//  Created by Alexander Korchak on 31.03.2023.
//

import Foundation
import SwiftUI

struct TrendingCreatorsView: View {
    let creators: [Creator] = [
        Creator(name: "Amy Smith", imageName: "donna_dalrymple"),
        Creator(name: "Bill Adams", imageName: "photo-15"),
        Creator(name: "Audrey Murphey", imageName: "granny")
    ]
    var body: some View {
       VStack {
           HStack {
               Text("Trending Creators")
                   .font(.system(size: 14, weight: .semibold))
               Spacer()
               Text("See all")
                   .font(.system(size: 14, weight: .semibold))
           }.padding(.horizontal)
               .padding(.top)
           ScrollView(.horizontal, showsIndicators: false) {
               HStack(alignment: .top, spacing: 12) {
                   ForEach(creators, id: \.self) { element in
                       VStack {
                           Image(element.imageName)
                               .resizable()
                               .scaledToFill()
                               .frame(width: 60, height: 60)
                               .cornerRadius(.infinity)
                           Text(element.name)
                               .font(.system(size: 11, weight: .semibold))
                               .multilineTextAlignment(.center)
                       }
                       .frame(width: 60)
                       .shadow(color: .gray, radius: 4, x: 0.0, y: 2)
                       .padding(.bottom)
                   }
               }.padding(EdgeInsets(top: 6, leading: 16, bottom: 0, trailing: 0))
           }
        }
    }
}

