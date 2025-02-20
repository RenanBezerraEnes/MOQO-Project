//
//  POINetworkServiceMock.swift
//  MOQO Project
//
//  Created by Renan Bezerra.
//

import Foundation

class POINetworkServiceMock: POINetworkServiceProtocol {
    private let POIData: POI = POI(
        id: "1",
        name: "testmock",
        latitude: 12324.5,
        longitude: 45456.4
    )
    
    private let POIDetailData: POIDetail = POIDetail(id: "1", lat: 45674.4, lng: 65894.2, name: "testingID", position_type: "test", vehicle_type: "car", image: nil, provider: nil)
    
    static let shared = POINetworkServiceMock()
    
    func fetchPOIs(boundingBox: String, pageSize:Int, pageNumber:Int, completion: @escaping ([POI]?) -> Void) {
        if(pageSize == 10) {
            completion([POIData])
        }
        else {
            completion(nil)
        }
    }
    
    func fetchPOIDetails(id: String, completion: @escaping (POIDetail?) -> Void) {
        completion(POIDetailData)
    }
}
