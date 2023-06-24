//
//  PopularDestinationsView.swift
//  Discover
//
//  Created by Alexander Korchak on 31.03.2023.
//

import Foundation
import SwiftUI
import MapKit

struct PopularDestinationsView: View {
    let destinations: [Destination] = [
        Destination(name: "Paris", country: "France", imageName: "La_Tour_Eiffel", latitude: 48.859565, longitude: 2.353235),
        Destination(name: "New York", country: "US", imageName: "Empire_State_Building", latitude: 40.71592, longitude: -74.0055),
        Destination(name: "Tokyo", country: "Japan", imageName: "Japan", latitude: 35.679693, longitude: 139.771913)
    ]
    var body: some View {
       VStack {
           HStack {
               Text("Popular destinations")
                   .font(.system(size: 14, weight: .semibold))
               Spacer()
               Text("See all")
                   .font(.system(size: 14, weight: .semibold))
           }.padding(.horizontal)
               .padding(.top)
           ScrollView(.horizontal, showsIndicators: false) {
               HStack(spacing: 8.0) {
                   ForEach(destinations, id: \.self) { destination in
                       NavigationLink {
                           PopularDestinationDetailsView(destination: destination)
                       } label: {
                           PopularDestinationTile(destination: destination)
                           .padding(.bottom)
                       }
                   }
               }.padding(.horizontal)
           }
        }
    }
}

struct PopularDestinationDetailsView: View {
    
    let destination: Destination
    @State var region: MKCoordinateRegion
    @State var isShown: Bool = false
    let attractions: [Attraction] = [
        Attraction(name: "Eiffel Tower", imageName: "La_Tour_Eiffel", latitude: 48.858605, longitude: 2.2946),
        Attraction(name: "Champs-Elysses", imageName: "Champs-Élysées", latitude: 48.866867, longitude: 2.311780),
        Attraction(name: "Louvre Museum", imageName: "Louvre_Museum", latitude: 48.860288, longitude: 2.337789)
    ]
    
    init(destination: Destination) {
        self.destination = destination
        self.region = MKCoordinateRegion(center: .init(latitude: destination.latitude,
                                                       longitude: destination.longitude),
                                         span: .init(latitudeDelta: 0.1,
                                                     longitudeDelta: 0.1))
    }

    var body: some View {
        ScrollView {
            DestinationHeaderContainer()
                .frame(height: 250)
            
            VStack(alignment: .leading) {
                Text(destination.name)
                    .font(.system(size: 18, weight: .bold))
                Text(destination.country)
                HStack {
                    ForEach(0..<5, id: \.self) { star in
                        Image(systemName: "star.fill")
                            .foregroundColor(.orange)
                    }
                }
                .padding(.top, 2)
                Text("At vero eos et accusamus et iusto odio dignissimos ducimus qui blanditiis praesentium voluptatum deleniti atque corrupti quos dolores et quas molestias excepturi sint occaecati cupiditate non provident, similique sunt in culpa qui officia deserunt mollitia animi, id est laborum et dolorum fuga. Et harum quidem rerum facilis est et expedita distinctio. Nam libero tempore, cum soluta nobis est eligendi optio cumque nihil impedit quo minus id quod maxime placeat facere possimus, omnis voluptas assumenda est, omnis dolor repellendus.")
                    .font(.system(size: 14))
                    .padding(.top, 8)
             
                HStack {
                    Spacer()
                }
            }
            .padding(.horizontal)
            HStack {
                Text("Location")
                    .font(.system(size: 18, weight: .semibold))
                Spacer()
                Button {
                    isShown.toggle()
                } label: {
                    Text(isShown ? "Hide attractions" : "Show attractions")
                        .font(.system(size: 12, weight: .semibold))
                }
                Toggle("", isOn: $isShown)
                    .labelsHidden()

            }
            .padding(.horizontal)
            
            Map(coordinateRegion: $region, annotationItems: isShown ? attractions : []) { attraction in
                MapAnnotation(coordinate: .init(latitude: attraction.latitude,
                                                longitude: attraction.longitude)) {
                    CustomMapAnnotation(attraction: attraction)
                }
            }
            .frame(width: 390, height: 300)
           
        }
        .navigationTitle(destination.name)
        .navigationBarTitleDisplayMode(.inline)
    }
}

struct Attraction: Identifiable {
    var id = UUID().uuidString
    let name: String
    let imageName: String
    let latitude: Double
    let longitude: Double
}

struct CustomMapAnnotation: View {
    
    let attraction: Attraction
    
    var body: some View {
        VStack {
            Image(attraction.imageName)
                .resizable()
                .frame(width: 80, height: 60)
                .cornerRadius(4)
                .overlay(
                    RoundedRectangle(cornerRadius: 4)
                        .stroke(Color(.init(white: 0, alpha: 0.5)))
                )
            Text(attraction.name)
                .font(.system(size: 12, weight: .semibold))
                .padding(.horizontal, 6)
                .padding(.vertical, 4)
                .background(
                    LinearGradient(gradient: Gradient(colors: [Color.red, Color.blue]), startPoint: .leading, endPoint: .trailing)
                )
                .foregroundColor(.white)
                
                .cornerRadius(4)
                .overlay(
                    RoundedRectangle(cornerRadius: 4)
                        .stroke(Color(.init(white: 0, alpha: 0.5)))
                )
                
        }
        .shadow(radius: 5)
    }
}

struct PopularDestinationTile: View {
    
    let destination: Destination
    
    var body: some View {
        VStack(alignment: .leading, spacing: 0) {
            Image(destination.imageName)
                .resizable()
                .scaledToFill()
                .frame(width: 125, height: 125)
                .cornerRadius(4)
                .padding(.horizontal, 6)
                .padding(.vertical, 6)
            Text(destination.name)
                .font(.system(size: 12, weight: .semibold))
                .foregroundColor(.black)
                .padding(.horizontal, 12)
            Text(destination.country)
                .font(.system(size: 12, weight: .semibold))
                .padding(.horizontal, 12)
                .padding(.bottom, 8)
                .foregroundColor(.gray)
        }
        .asTile()
    }
}

struct PopularDestinationsView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView {

            PopularDestinationDetailsView(destination: Destination(name: "Paris",
                                                                   country: "France",
                                                                   imageName: "La_Tour_Eiffel",
                                                                   latitude: 48.859565,
                                                                   longitude: 2.353235))
        }
        DiscoverView()
        PopularDestinationsView()
    }
}
