//
//  PopularDestinationViewModel.swift
//  Discover
//
//  Created by Alexander Korchak on 25.06.2023.
//

import Foundation

@MainActor
class PopularDestinationsViewModel: ObservableObject {
    
    @Published var isLoading: Bool = true
    @Published var destination: DestinationDetails?
    
    init(name: String) {
        Task {
            destination = try await fetchDestination(name: name.lowercased())
        }
    }
    
    @MainActor
    func fetchDestination(name: String) async throws -> DestinationDetails {
        
        guard let url = createURL(name: name) else {
            throw URLError(.badURL)
        }
        
        do {
            let (data, response) = try await URLSession.shared.data(from: url)
            guard let response = (response as? HTTPURLResponse),
                  response.statusCode >= 200 && response.statusCode < 300 else {
                throw URLError(.badServerResponse)
            }
            return try JSONDecoder().decode(DestinationDetails.self, from: data)
            
        } catch let error {
            print(error.localizedDescription)
            throw URLError(.unknown)
        }
    }
    
    func createURL(name: String) -> URL? {
        
        var components = URLComponents()
        components.scheme = "https"
        components.host = "travel.letsbuildthatapp.com"
        components.path = "/travel_discovery/destination"
        
        let queryItems = [
            URLQueryItem(name: "name", value: name)
        ]
        
        components.queryItems = queryItems
        return components.url
    }
}
