//
//  MarvelUITests.swift
//  MarvelUITests
//
//  Created by Carlos Parada on 26/01/22.
//

import XCTest

class MarvelUITests: XCTestCase {
    private var app: XCUIApplication!
    
    private var labelData: XCUIElement!
    private var imageTitle: XCUIElement!
    private var imageFooter: XCUIElement!
    private var activityIndicator: XCUIElement!
    
    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
        try super.setUpWithError()
        app = XCUIApplication()
        app.launch()
        labelData = app.staticTexts["labelData"]
        imageTitle = app.images["MarvelLogo"]
        imageFooter = app.images["MarvelPeople"]
//        activityIndicator = app.descendants(matching: .any)["activityIndicator"]
        // In UI tests it is usually best to stop immediately when a failure occurs.
        continueAfterFailure = false
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        labelData = nil
        imageTitle = nil
        imageFooter = nil
        try super.tearDownWithError()
    }

    func testSplash_StartView_Inicial() throws {
        XCTAssert(labelData.exists, "Logo Marvel here")
        XCTAssert(imageTitle.exists, "Logo Marvel here")
        XCTAssert(imageFooter.exists, "Art MArvel here")
        let elementsQuery = app.collectionViews.otherElements
        let legalString = elementsQuery.staticTexts["Aaron Stack"]
        wait(element: legalString, duration: 10)
        
        app.collectionViews.staticTexts["Aaron Stack"].tap()
        
        let comics = app.tables/*@START_MENU_TOKEN@*/.staticTexts["Comics ⚔️"]/*[[".otherElements[\"Comics ⚔️\"].staticTexts[\"Comics ⚔️\"]",".staticTexts[\"Comics ⚔️\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/
        wait(element: comics, duration: 10)
        
        comics.swipeUp()
        comics.swipeUp()
        
        let closeButton = app.buttons["Close"]
        closeButton.tap()
        
        XCTAssert(true)
    }


    func testLaunchPerformance() throws {
        if #available(macOS 10.15, iOS 13.0, tvOS 13.0, watchOS 7.0, *) {
            // This measures how long it takes to launch your application.
            measure(metrics: [XCTApplicationLaunchMetric()]) {
                XCUIApplication().launch()
            }
        }
    }
    
    func wait(element: XCUIElement, duration: TimeInterval) {
        let predicate = NSPredicate(format: "exists == true")
        let _ = expectation(for: predicate, evaluatedWith: element, handler: nil)
        waitForExpectations(timeout: duration + 0.5)
    }
    
    func waitHidden(element: XCUIElement, duration: TimeInterval) {
        let predicate = NSPredicate(format: "exists == false")
        let _ = expectation(for: predicate, evaluatedWith: element, handler: nil)
        waitForExpectations(timeout: duration + 0.5)
    }
    
    func waiterResultWithExpextation(_ element: XCUIElement) -> XCTWaiter.Result {
        let myPredicate = NSPredicate(format: "exists == true")
        let myExpectation = expectation(for: myPredicate, evaluatedWith: element,
                                        handler: nil)
        
        let result = XCTWaiter().wait(for: [myExpectation], timeout: 5)
        return result
    }
    func scrollDownUntilVisible(element: XCUIElement) {
        while !element.displayed {
            app.swipeUp()
        }
    }
}

extension XCUIElement {
    var displayed: Bool {
        guard self.exists && !frame.isEmpty else { return false }
        return XCUIApplication().windows.element(boundBy: 0).frame.contains(frame)
    }
}
