//
//  MOQO Project
//  Created by Renan Bezerra.
//
                                                                    
import Foundation
import MapKit

class POIViewModel: ObservableObject {
    @Published var pois: [POI]?
    @Published var selectedPOI: POI?
    @Published var selectedPOIDetails: POIDetail?
    
    private let service: POINetworkServiceProtocol!
    
    init(service: POINetworkServiceProtocol!) {
        self.service = service
    }
    
    private var currentBoundingBox: String = "{\"ne_lat\":51.648968,\"ne_lng\":7.4278984,\"sw_lat\":49.28752,\"sw_lng\":5.3754444}"
    private var currentPage = 1
    var pageSize = 10
     
     func fetchPOIs() {
         service.fetchPOIs(boundingBox: currentBoundingBox, pageSize: pageSize, pageNumber: currentPage) { [weak self] pois in
             DispatchQueue.main.async {
                 self?.pois = pois
             }
         }
     }
    
     func fetchPOIDetails(id: String) {
        selectedPOIDetails = nil
         service.fetchPOIDetails(id: id) { [weak self] details in
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
