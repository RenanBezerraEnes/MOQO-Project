//
//  MOQO Project
//  Created by Renan Bezerra.
//

import XCTest
@testable import MOQO_Project

class URLSessionMock: URLSessionProtocol {
    var mockData: Data?
    var mockResponse: URLResponse?
    var mockError: Error?

    func dataTask(with url: URL, completionHandler: @escaping (Data?, URLResponse?, Error?) -> Void) -> URLSessionDataTaskProtocol {
        let task = URLSessionDataTaskMock()
        task.completionHandler = { completionHandler(self.mockData, self.mockResponse, self.mockError) }
        return task
    }
}

class URLSessionDataTaskMock: URLSessionDataTaskProtocol {
    var completionHandler: (() -> Void)?

    func resume() {
        completionHandler?()
    }
}

class POINetworkServiceTests: XCTestCase {
    var networkService: POINetworkService!
    var mockSession: URLSessionMock!

    override func setUp() {
        super.setUp()
        mockSession = URLSessionMock()
        networkService = POINetworkService(session: mockSession)
    }

    override func tearDown() {
        networkService = nil
        mockSession = nil
        super.tearDown()
    }

    func testFetchPOIs_Success() {
        let jsonData = """
        {
            "data": [
                {
                    "id": "1",
                    "name": "Test POI",
                    "lat": 51.648968,
                    "lng": 7.4278984
                }
            ]
        }
        """.data(using: .utf8)!

        mockSession.mockData = jsonData
        mockSession.mockResponse = HTTPURLResponse(url: URL(string: "https://example.com")!,
                                                   statusCode: 200, httpVersion: nil, headerFields: nil)

        let expectation = self.expectation(description: "Fetch POIs")

        networkService.fetchPOIs(boundingBox: "test", pageSize: 10, pageNumber: 1) { pois in
            XCTAssertNotNil(pois)
            XCTAssertEqual(pois?.count, 1)
            XCTAssertEqual(pois?.first?.id, "1")
            XCTAssertEqual(pois?.first?.name, "Test POI")
            XCTAssertEqual(pois?.first?.latitude, 51.648968)
            XCTAssertEqual(pois?.first?.longitude, 7.4278984)
            expectation.fulfill()
        }

        waitForExpectations(timeout: 2, handler: nil)
    }

    func testFetchPOIs_NetworkError() {
        mockSession.mockError = NSError(domain: "TestError", code: 0, userInfo: nil)

        let expectation = self.expectation(description: "Network Error")

        networkService.fetchPOIs(boundingBox: "test", pageSize: 10, pageNumber: 1) { pois in
            XCTAssertNil(pois)
            expectation.fulfill()
        }

        waitForExpectations(timeout: 2, handler: nil)
    }

    func testFetchPOIs_InvalidJSON() {
        let invalidData = "invalid json".data(using: .utf8)!

        mockSession.mockData = invalidData

        let expectation = self.expectation(description: "Invalid JSON")

        networkService.fetchPOIs(boundingBox: "test", pageSize: 10, pageNumber: 1) { pois in
            XCTAssertNil(pois)
            expectation.fulfill()
        }

        waitForExpectations(timeout: 2, handler: nil)
    }
}
