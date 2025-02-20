import XCTest
@testable import MOQO_Project

class POIViewModelTests: XCTestCase {
    
    var viewModel: POIViewModel!
    var mockService: POINetworkServiceMock!
    
    override func setUp() {
        super.setUp()
        
        mockService = POINetworkServiceMock()
        
        viewModel = POIViewModel(service: mockService)
    }
    
    override func tearDown() {
        viewModel = nil
        mockService = nil
        super.tearDown()
    }
    
    func testFetchPOIs_Success() {
        let expectation = self.expectation(description: "POIs fetched successfully")

        viewModel.fetchPOIs()

        DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
            expectation.fulfill()
        }
        
        waitForExpectations(timeout: 5, handler: nil)

        XCTAssertNotNil(viewModel.pois)
        XCTAssertEqual(viewModel.pois?[0].id, "1")
        XCTAssertEqual(viewModel.pois?[0].name, "testmock")
        XCTAssertEqual(viewModel.pois?[0].latitude, 12324.5)
        XCTAssertEqual(viewModel.pois?[0].longitude, 45456.4)
    }
    
    func testFetchPOIs_NetworkError() {
        let expectation = self.expectation(description: "Network Error")
        viewModel.pageSize = 1
        viewModel.fetchPOIs()
        DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
            expectation.fulfill()
        }

        waitForExpectations(timeout: 2, handler: nil)
        
        XCTAssertNil(viewModel.pois)
    }
    
    

}
 
