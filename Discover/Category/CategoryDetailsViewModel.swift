//
//  CategoryDetailsViewModel.swift
//  Discover
//
//  Created by Alexander Korchak on 02.06.2023.
//

import SwiftUI

@MainActor class CategoryDetailsViewModel: ObservableObject {
    @Published var isLoading: Bool = true
    @Published var places = [Place]()
    @Published var errorMessage: String = ""

    init(name: String) {
        Task {
            await fetchImage(name: name)
            self.isLoading = false
        }
    }

    func fetchImage(name: String) async {
        let urlString = "https://travel.letsbuildthatapp.com/travel_discovery/category?name=\(name.lowercased())"
            .addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed) ?? ""
        
        guard let url = URL(string: urlString) else {
            self.isLoading = false
            return
        }
        
        do {
            let (data, response) = try await URLSession.shared.data(from: url)
            if let statusCode = (response as? HTTPURLResponse)?.statusCode,
                  statusCode >= 400 {
                self.isLoading = false
                self.errorMessage = "Bad status: \(statusCode)"
            }
            let result = try JSONDecoder().decode([Place].self, from: data)
         
                self.places = result
            
        } catch let error {
            print(error.localizedDescription)
        }
    }
}

