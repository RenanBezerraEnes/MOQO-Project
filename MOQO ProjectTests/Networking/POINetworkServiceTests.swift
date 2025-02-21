//
//  MOQO Project
//  Created by Renan Bezerra.
//

import XCTest
@testable import MOQO_Project

class POINetworkServiceTests: XCTestCase {
    var networkService: POINetworkService!
    
    override func setUp() {
        super.setUp()
        networkService = POINetworkService()
    }
    
    override func tearDown() {
        networkService = nil
        super.tearDown()
    }
    
    func testFetchPOIs_Success() {
        let expectation = self.expectation(description: "Fetch POIs")
        
        
        networkService.fetchPOIs(boundingBox: "{\"ne_lat\":51.648968,\"ne_lng\":7.4278984,\"sw_lat\":49.28752,\"sw_lng\":5.3754444}", pageSize: 10, pageNumber: 1) { pois in
            XCTAssertNotNil(pois)
            XCTAssertEqual(pois?.count, 10)
            expectation.fulfill()
        }
        
        waitForExpectations(timeout: 2, handler: nil)
    }
    
    //For testFetchPOIs_Errors I tried to implement by using other parameters like pageSize -1, but I still got some data.
    
    func testFetchPOIsDetails_Success() {
        let expectation = self.expectation(description: "Fetch POIs")
        
        networkService.fetchPOIDetails(id: "3080789") { pois in
            XCTAssertNotNil(pois)
            XCTAssertEqual(pois?.id, "3080789")
            XCTAssertEqual(pois?.name, "Renault R 21")
            XCTAssertEqual(pois?.lng, 9.49241)
            XCTAssertEqual(pois?.lat, 51.315455)
            XCTAssertEqual(pois?.position_type, "standalone")
            XCTAssertEqual(pois?.vehicle_type, "car")
            expectation.fulfill()
        }
        
        waitForExpectations(timeout: 2, handler: nil)
    }
    
    func testFetchPOIsDetails_Error() {
        let expectation = self.expectation(description: "Fetch POIs")
        
        networkService.fetchPOIDetails(id: "1") { pois in
            XCTAssertNil(pois)
            expectation.fulfill()
        }
        
        waitForExpectations(timeout: 2, handler: nil)
    }
}
