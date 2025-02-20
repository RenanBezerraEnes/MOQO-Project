//
//  MOQO Project
//  Created by Renan Bezerra.
//

import Foundation

extension URLSession: URLSessionProtocol {
    func dataTask(with url: URL, completionHandler: @escaping (Data?, URLResponse?, Error?) -> Void) -> URLSessionDataTaskProtocol {
        return (dataTask(with: url, completionHandler: completionHandler) as URLSessionDataTask) as URLSessionDataTaskProtocol
    }
}

extension URLSessionDataTask: URLSessionDataTaskProtocol {}

class POINetworkService {
    private let session: URLSessionProtocol

    init(session: URLSessionProtocol = URLSession.shared) {
        self.session = session
    }
    
    static let shared = POINetworkService()
    
    let url = URL(string: "https://prerelease.moqo.de/api/graph/discovery/pois")!
    
    func fetchPOIs(boundingBox: String, pageSize:Int, pageNumber:Int, completion: @escaping ([POI]?) -> Void) {
        let urlString = "\(url)?filter[bounding_box]=\(boundingBox)&page[size]=\(pageSize)&page[number]=\(pageNumber)"
        
        guard let url = URL(string: urlString) else {
            print("Invalid URL")
            completion(nil)
            return
        }
        
        let task = session.dataTask(with: url) { data, response, error in
            if let error = error {
                print("Error fetching POIs: \(error)")
                completion(nil)
                return
            }
            
            guard let data = data else {
                print("No data returned")
                completion(nil)
                return
            }
            
            do {
                let response = try JSONDecoder().decode(POIResponse.self, from: data)
                completion(response.data)
            } catch {
                print("Failed to decode POIs: \(error)")
                completion(nil)
            }
        }
        
        task.resume()
    }
    
    func fetchPOIDetails(id: String, completion: @escaping (POIDetail?) -> Void) {
        let urlString = "https://prerelease.moqo.de/api/graph/discovery/pois?filter[id]=\(id)&extra_fields[pois]=image,provider"

        guard let url = URL(string: urlString) else {
            print("Invalid URL: \(urlString)")
            completion(nil)
            return
        }

        let task = session.dataTask(with: url) { data, response, error in
            if let error = error {
                print("Error fetching POI details: \(error)")
                completion(nil)
                return
            }

            guard let data = data else {
                print("No data returned")
                completion(nil)
                return
            }

            if let jsonString = String(data: data, encoding: .utf8) {
                print("Raw JSON Response: \(jsonString)")
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
