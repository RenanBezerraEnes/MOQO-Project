import XCTest

//
//  MOQO Project
//  Created by Renan Bezerra.
//

class ContentViewUITests: XCTestCase {

    override func setUpWithError() throws {
        continueAfterFailure = false
        XCUIApplication().launch()
    }

    override func tearDownWithError() throws {
    }

    func testInitialState() throws {
        let app = XCUIApplication()
        
        let map = app.maps.element
        XCTAssertTrue(map.exists, "The map should be present")
        
        let detailView = app.otherElements["POIDetailView"]
        XCTAssertFalse(detailView.exists, "The detail view should not be visible initially")
    }

    func testMapCameraChange() throws {
        let app = XCUIApplication()
        
        let map = app.maps.element
        map.pinch(withScale: 2.0, velocity: 1.0)
    }

    func testRefreshButton() throws {
        let app = XCUIApplication()
        
        let refreshButton = app.buttons["arrow.clockwise"]
        XCTAssertTrue(refreshButton.exists, "The refresh button should be present")
        
        refreshButton.tap()
    }
}
