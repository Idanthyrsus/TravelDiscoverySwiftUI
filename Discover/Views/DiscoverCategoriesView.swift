//
//  DiscoverCategoriesView.swift
//  Discover
//
//  Created by Alexander Korchak on 29.03.2023.
//

import Foundation
import SwiftUI

struct NavigationLazyView<Content: View>: View {
    let build: () -> Content
    init(_ build: @autoclosure @escaping () -> Content) {
        self.build = build
    }
    var body: Content {
        build()
    }
}

struct DiscoverCategoriesView: View {
    var iconColor = #colorLiteral(red: 1, green: 0.6066272855, blue: 0.3789773285, alpha: 1)
    let categories: [Category] = [.init(name: "Art", imageName: "paintpalette.fill"),
                                  .init(name: "Sports", imageName: "sportscourt.fill"),
                                  .init(name: "Live events", imageName: "music.mic"),
                                  .init(name: "Food", imageName: "fork.knife"),
                                  .init(name: "History", imageName: "book.fill"),
    ]
    var body: some View {
        ScrollView(.horizontal, showsIndicators: false) {
            HStack(alignment: .top, spacing: 14) {
                ForEach(categories, id: \.self) { element in
                    NavigationLink {
                        NavigationLazyView(CategoryDetailsView(name: element.name))
        
                    } label: {
                        VStack(spacing: 8) {
                            Image(systemName: element.imageName)
                                .font(.system(size: 20))
                                .foregroundColor(Color(iconColor))
                                .frame(width: 64, height: 64)
                                .background(Color.white)
                                .cornerRadius(64)
                            Text(element.name)
                                .font(.system(size: 12, weight: .semibold))
                                .multilineTextAlignment(.center)
                                .foregroundColor(.white)
                        }.frame(width: 68)
                    }
                }
            }.padding(.horizontal)
        }
    }
}


struct DiscoverCategoriesView_Previews: PreviewProvider {
    static var previews: some View {
        DiscoverCategoriesView()
    }
}
