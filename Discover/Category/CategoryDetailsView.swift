//
//  CategoryDetailsView.swift
//  Discover
//
//  Created by Alexander Korchak on 03.05.2023.
//

import SwiftUI
import Kingfisher

struct CategoryDetailsView: View {
    
    private let name: String
    @ObservedObject private var viewModel: CategoryDetailsViewModel

    init(name: String) {
        self.name = name
        self.viewModel = .init(name: name)
    }
    
    var body: some View {
        ZStack {
            if viewModel.isLoading {
                VStack {
                    ActivityIndicator()
                    Text("Loading...")
                        .foregroundColor(.white)
                }
                .padding()
                .background(Color.black)
                .cornerRadius(8)
            } else {
                ZStack {
                    if !viewModel.errorMessage.isEmpty {
                        VStack {
                            Image(systemName: "xmark.octagon.fill")
                                .padding()
                                .font(.system(size: 64, weight: .semibold))
                                .foregroundColor(.red)
                            Text(viewModel.errorMessage)
                        }
                    }
                   
                    ScrollView {
                        ForEach(viewModel.places, id: \.self) { tile in
                            VStack(alignment: .leading, spacing: 0) {
                                KFImage(URL(string: tile.thumbnail))
                                    .resizable()
                                    .scaledToFill()
                                Text(tile.name)
                                    .font(.system(size: 12, weight: .semibold))
                                    .padding()
                            }
                            .asTile()
                            .padding()
                        }
                    }
                }
            }
        }
       .navigationTitle(name)
     .navigationBarTitleDisplayMode(.inline)
    }
}

struct CategoryDetailsView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView {
            CategoryDetailsView(name: "Food")
        }
    }
}
