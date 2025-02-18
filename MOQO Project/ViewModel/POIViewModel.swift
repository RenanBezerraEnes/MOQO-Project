//
//  MOQO Project
//  Created by Renan Bezerra.
//

import Foundation
import MapKit

class POIViewModel: ObservableObject {
    @Published var pois: [POI] = []
    @Published var selectedPOI: POI?
    @Published var selectedPOIDetails: POIDetail?
    
     private var currentBoundingBox: String = "{\"ne_lat\":51.648968,\"ne_lng\":7.4278984,\"sw_lat\":49.28752,\"sw_lng\":5.3754444}"
     private var currentPage = 1
     private let pageSize = 10
     
     func fetchPOIs() {
         POINetworkService.shared.fetchPOIs(boundingBox: currentBoundingBox, pageSize: pageSize, pageNumber: currentPage) { [weak self] pois in
             DispatchQueue.main.async {
                 self?.pois = pois ?? []
             }
         }
     }
    
     func fetchPOIDetails(id: String) {
        selectedPOIDetails = nil
         POINetworkService.shared.fetchPOIDetails(id: id) { [weak self] details in
            DispatchQueue.main.async {
                self?.selectedPOIDetails = details
            }
        }
    }
    
    func refreshPOIs(neLat: Double, neLng: Double, swLat: Double, swLng: Double) {
            currentBoundingBox = "{\"ne_lat\":\(neLat),\"ne_lng\":\(neLng),\"sw_lat\":\(swLat),\"sw_lng\":\(swLng)}"
            currentPage = 1
            fetchPOIs()
        }
}
