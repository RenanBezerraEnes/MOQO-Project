//
//  MOQO Project
//  Created by Renan Bezerra.
//

import SwiftUI
import MapKit

struct ContentView: View {
    @StateObject private var viewModel = POIViewModel(service: POINetworkService())
    @State private var cameraPosition: MapCameraPosition = .region(.init(
        center: .init(latitude: 51.648968, longitude: 7.4278984),
        latitudinalMeters: 150000,
        longitudinalMeters: 150000
    ))
    @State private var selectedPOI: POI?
    @State private var isDetailViewVisible = false
    @State private var currentRegion: MKCoordinateRegion?

    var body: some View {
        NavigationStack {
            ZStack {
                Map(position: $cameraPosition, interactionModes: .all) {
                    ForEach(viewModel.pois ?? []) { poi in
                        Annotation(poi.name, coordinate: CLLocationCoordinate2D(latitude: poi.latitude, longitude: poi.longitude)) {
                            Image(systemName: "mappin.circle.fill")
                                .resizable()
                                .frame(width: 20, height: 20)
                                .foregroundColor(.blue)
                                .background(.white, in: Circle())
                                .shadow(radius: 3)
                                .onTapGesture {
                                    handlePOITap(poi: poi)
                                }
                        }
                    }
                }
                .onMapCameraChange { context in
                                    currentRegion = context.region
                }
                .toolbar {
                    ToolbarItem(placement: .topBarTrailing) {
                        Button(action: {
                            refreshPOIs()
                            print("🔄 Refresh button tapped!")
                        }) {
                            Image(systemName: "arrow.clockwise")
                        }
                    }
                }
                .simultaneousGesture(
                    TapGesture()
                        .onEnded {
                            withAnimation {
                                isDetailViewVisible = false
                                selectedPOI = nil
                            }
                        }
                )
                .onAppear {
                    viewModel.fetchPOIs()
                }

                if isDetailViewVisible, let selectedPOI = selectedPOI, let selectedPOIDetails = viewModel.selectedPOIDetails {
                    POIDetailView(poi: selectedPOI, details: selectedPOIDetails)
                        .frame(width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height / 2)
                        .background(Color.white)
                        .cornerRadius(15)
                        .shadow(radius: 10)
                        .transition(.move(edge: .bottom))
                        .padding(.top, UIScreen.main.bounds.height / 2.3)
                        .zIndex(1)
                        .id(selectedPOI.id)
                }
            }
        }
    }

    private func handlePOITap(poi: POI) {
        if selectedPOI?.id == poi.id && isDetailViewVisible {
            withAnimation {
                isDetailViewVisible = false
                selectedPOI = nil
            }
        } else {
            viewModel.fetchPOIDetails(id: poi.id)
            selectedPOI = poi
            withAnimation { isDetailViewVisible = true }
        }
    }

    private func refreshPOIs() {
            guard let region = currentRegion else {
                print("No region available")
                return
            }
            
                let neLat = region.center.latitude + (region.span.latitudeDelta / 2)
                let neLng = region.center.longitude + (region.span.longitudeDelta / 2)
                let swLat = region.center.latitude - (region.span.latitudeDelta / 2)
                let swLng = region.center.longitude - (region.span.longitudeDelta / 2)
            
            viewModel.refreshPOIs(
                neLat: neLat,
                neLng: neLng,
                swLat: swLat,
                swLng: swLng
            )
        }
}

#Preview {
    ContentView()
}

