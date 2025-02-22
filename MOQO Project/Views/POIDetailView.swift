//
//  MOQO Project
//  Created by Renan Bezerra.
//

import SwiftUI

struct POIDetailView: View {
    var poi: POI
    var details: POIDetail
    
    var body: some View {
        VStack(alignment: .leading, spacing: 12) {
            
            if let imageUrl = details.image?.url, let url = URL(string: imageUrl) {
                AsyncImage(url: url) { phase in
                    switch phase {
                    case .empty:
                        ProgressView()
                    case .success(let image):
                        image.resizable()
                            .scaledToFit()
                            .frame(height: 200)
                            .cornerRadius(10)
                    case .failure:
                        Image(systemName: "photo")
                            .resizable()
                            .scaledToFit()
                            .frame(height: 200)
                            .foregroundColor(.gray)
                    @unknown default:
                        EmptyView()
                    }
                }
                .frame(maxWidth: .infinity, alignment: .center)
            }
            
            Text(details.name)
                .font(.title2)
                .fontWeight(.bold)
            
            if let vehicleType = details.vehicle_type {
                HStack {
                    Image(systemName: "car.fill")
                    Text("Type: \(vehicleType)")
                }
            }
            
            if let provider = details.provider {
                Divider()
                HStack {
                    if let providerImageUrl = provider.image?.thumb_url, let url = URL(string: providerImageUrl) {
                        AsyncImage(url: url) { image in
                            image.resizable()
                                .scaledToFill()
                                .aspectRatio(contentMode: .fill)
                                .frame(width: 40, height: 40)
                                .clipShape(Circle())
                        } placeholder: {
                            Image(systemName: "person.circle.fill")
                                .resizable()
                                .scaledToFit()
                                .frame(width: 40, height: 40)
                                .foregroundColor(.gray)
                        }
                    }
                    
                    Text(provider.name)
                        .font(.headline)
                }
            }
            Spacer()
            
            HStack {
                Spacer()
                SwipeToUnlockButton(vehicleName: details.name)
                    .frame(height: 50)
                    .padding(.bottom, 20)
                Spacer()
            }                           
        }
        
        .padding()
    }
}
