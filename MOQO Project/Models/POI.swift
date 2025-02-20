//
//  MOQO Project
//  Created by Renan Bezerra.
//

import Foundation

struct POI: Identifiable, Decodable {
    var id: String
    var name: String
    var latitude: Double
    var longitude: Double
    
    enum CodingKeys: String, CodingKey {
        case id
        case name
        case latitude = "lat"
        case longitude = "lng"
    }
}

