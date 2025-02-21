//
//  MOQO Project
//  Created by Renan Bezerra.
//

import Foundation

protocol POINetworkServiceProtocol {
    func fetchPOIs(boundingBox: String, pageSize:Int, pageNumber:Int, completion: @escaping ([POI]?) -> Void)
    func fetchPOIDetails(id: String, completion: @escaping (POIDetail?) -> Void)
}

class POINetworkService: POINetworkServiceProtocol {
    private let session: URLSession = URLSession.shared
    
    static let shared = POINetworkService()
    
    let url = URL(string: "https://prerelease.moqo.de/api/graph/discovery/pois")!
    
    func fetchPOIs(boundingBox: String, pageSize:Int, pageNumber:Int, completion: @escaping ([POI]?) -> Void) {
        let urlString = "\(url)?filter[bounding_box]=\(boundingBox)&page[size]=\(pageSize)&page[number]=\(pageNumber)"
        
        guard let url = URL(string: urlString) else {
            completion(nil)
            return
        }
        
        let task = session.dataTask(with: url) { data, response, error in
            if let error = error {
                completion(nil)
                return
            }
            
            guard let data = data else {
                completion(nil)
                return
            }
            
            do {
                let response = try JSONDecoder().decode(POIResponse.self, from: data)
                print(response.data)
                completion(response.data)
            } catch {
                completion(nil)
            }
        }
        
        task.resume()
    }
    
    func fetchPOIDetails(id: String, completion: @escaping (POIDetail?) -> Void) {
        let urlString = "https://prerelease.moqo.de/api/graph/discovery/pois?filter[id]=\(id)&extra_fields[pois]=image,provider"
        
        guard let url = URL(string: urlString) else {
            completion(nil)
            return
        }
        
        let task = session.dataTask(with: url) { data, response, error in
            if let error = error {
                completion(nil)
                return
            }
            
            guard let data = data else {
                completion(nil)
                return
            }
            
            do {
                let response = try JSONDecoder().decode(POIDetailResponse.self, from: data)
                completion(response.data.first)
            } catch {
                print("Failed to decode POI details: \(error)")
                completion(nil)
            }
        }
        
        task.resume()
    }
}
