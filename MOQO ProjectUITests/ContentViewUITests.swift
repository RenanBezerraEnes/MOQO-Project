import XCTest

//
//  MOQO Project
//  Created by Renan Bezerra.
//

class ContentViewUITests: XCTestCase {
    var app: XCUIApplication!
    
    override func setUpWithError() throws {
        continueAfterFailure = false
        app = XCUIApplication()
        app.launch()
    }
    
    override func tearDownWithError() throws {
        app = nil
    }
    
    func testInitialState() throws {
        let app = XCUIApplication()
        
        let map = app.maps.element
        XCTAssertTrue(map.exists, "The map should be present")
        
        let detailView = app.otherElements["POIDetailView"]
        XCTAssertFalse(detailView.exists, "The detail view should not be visible initially")
    }
    
    func testPOISelectionDetailView() throws {
        let map = app.maps.firstMatch
        XCTAssertTrue(map.waitForExistence(timeout: 10))
        
        let poiMarker = app.images["mappin.circle.fill"].firstMatch
        XCTAssertTrue(poiMarker.waitForExistence(timeout: 10))
        
        if poiMarker.exists && poiMarker.isHittable {
            let coordinate = poiMarker.coordinate(withNormalizedOffset: CGVector(dx: 0.5, dy: 0.5))
            coordinate.tap()
            
            let detailView = app.descendants(matching: .any)["POIDetailView"].firstMatch
            XCTAssertTrue(detailView.waitForExistence(timeout: 15))
        }
    }
    
    func testMapCameraChange() throws {
        let app = XCUIApplication()
        
        let map = app.maps.element
        map.pinch(withScale: 2.0, velocity: 1.0)
    }
    
    func testRefreshButton() throws {
        let refreshButton = app.buttons["Refresh POIs"]
        XCTAssertTrue(refreshButton.waitForExistence(timeout: 2), "The refresh button should be present")
        
        refreshButton.tap()
        
        Thread.sleep(forTimeInterval: 1)
        
        let map = app.maps.element
        XCTAssertTrue(map.exists, "The map should still be present after refresh")
    }
}
