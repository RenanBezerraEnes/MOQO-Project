//
//  MOQO Project
//  Created by Renan Bezerra.
//

import Foundation

struct POI: Identifiable, Decodable {
    let id: String
    let name: String
    let latitude: Double
    let longitude: Double
    
    enum CodingKeys: String, CodingKey {
        case id
        case name
        case latitude = "lat"
        case longitude = "lng"
    }
}

