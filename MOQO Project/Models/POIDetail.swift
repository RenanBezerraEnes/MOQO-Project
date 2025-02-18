//
//  MOQO Project
//  Created by Renan Bezerra.
//

import Foundation

struct POIDetail: Decodable {
    let id: String
    let lat: Double
    let lng: Double
    let name: String
    let position_type: String
    let vehicle_type: String?
    let image: ImageURLs?
    let provider: Provider?
}                               
