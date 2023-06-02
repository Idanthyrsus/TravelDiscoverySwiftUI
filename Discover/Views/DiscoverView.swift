//
//  ContentView.swift
//  Discover
//
//  Created by Alexander Korchak on 22.03.2023.
//

import SwiftUI

extension Color {
    static let discoverBackground = Color(.init(white: 0.95, alpha: 1))
}

struct DiscoverView: View {
    var startingColor = #colorLiteral(red: 0.9819278121, green: 0.744823873, blue: 0.209161818, alpha: 1)
    var endingColor = #colorLiteral(red: 1, green: 0.1416777968, blue: 0.4112811685, alpha: 1)
    
    init() {
        UINavigationBar.appearance().largeTitleTextAttributes = [
            .foregroundColor: UIColor.white
        ]
    }
    
    var body: some View {
        NavigationView {
            ZStack {
                LinearGradient(colors: [Color(startingColor), Color(endingColor)], startPoint: .top, endPoint: .bottom)
                    .ignoresSafeArea()
                Color.discoverBackground
                    .offset(y: 400)
                
                ScrollView {
                    DiscoverCategoriesView()
                    VStack {
                        PopularDestinationsView()
                        PopularRestaurantsView()
                        TrendingCreatorsView()
                    }
                    .background(Color.discoverBackground)
                    .cornerRadius(16)
                    .padding(.top, 32)
                }
            }
           .navigationTitle("Discover")
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        DiscoverView()
    }
}


