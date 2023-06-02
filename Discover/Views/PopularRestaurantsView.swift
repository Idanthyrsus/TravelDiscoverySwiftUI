//
//  PopularRestaurantsView.swift
//  Discover
//
//  Created by Alexander Korchak on 31.03.2023.
//

import Foundation
import SwiftUI

struct PopularRestaurantsView: View {
    let restaurants: [Restaurant] = [
        Restaurant(name: "Japan's Finest Tapas", imageName: "Sushi"),
        Restaurant(name: "Mumbai Spicy", imageName: "samosas")
    ]
    var body: some View {
        VStack {
            HStack {
                Text("Popular places to eat")
                    .font(.system(size: 14, weight: .semibold))
                Spacer()
                Text("See all")
                    .font(.system(size: 14, weight: .semibold))
            }.padding(.horizontal)
                .padding(.top)
            ScrollView(.horizontal, showsIndicators: false) {
                HStack(spacing: 8) {
                    ForEach(restaurants, id: \.self) { element in
                        HStack(spacing: 8) {
                            Image(element.imageName)
                                .resizable()
                                .scaledToFill()
                                .frame(width: 60, height: 60)
                                .clipped()
                                .cornerRadius(5)
                                .padding(.leading, 6)
                                .padding(.vertical, 6)
                            
                            VStack(alignment: .leading, spacing: 6) {
                                HStack {
                                    Text(element.name)
                                    Spacer()
                                    Button {
                                        
                                    } label: {
                                        Image(systemName: "ellipsis")
                                            .foregroundColor(Color.gray)
                                    }
                                }
                                HStack {
                                    Image(systemName: "star.fill")
                                    Text("4.7 • Sushi • $$")
                                }
                                Text("Tokyo, Japan")
                                
                            }.font(.system(size: 12, weight: .semibold))
                            Spacer()
                            
                        }
                        .asTile()
                        .padding(.bottom)
                    }
                }.padding(.horizontal)
            }
        }
    }
}

