//
//  MarvelTests.swift
//  MarvelTests
//
//  Created by Carlos Parada on 26/01/22.
//

import XCTest
@testable import Marvel

class SplashMarvelTests: XCTestCase {

    var rootViewController: SplashViewController!
    
    override func setUp() {
        // Put setup code here. This method is called before the invocation of each test method in the class.
        rootViewController = SplashConfiguration.setup() as? SplashViewController
        rootViewController.loadViewIfNeeded()
        
    }
    
    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testSplashTests_WhenCreated_HasRequiredLoading() throws {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
        if let splashVC = rootViewController {
            
            let loadingLabel = try XCTUnwrap(splashVC.labelData," Aun no se ha iniciado la consulta de datos")
            let imageMarvel = try XCTUnwrap(splashVC.logoHeader," El logo de Marvel esta presente en la vista")
            let imageFooterMarvel = try XCTUnwrap(splashVC.logoFooter," La Art Marvel esta presente en la vista")
            XCTAssertEqual(loadingLabel.text, "cargando...", "LabelData label no esta vacio")
            XCTAssertEqual(imageMarvel.image, UIImage(named: "MarvelLogo"), "Se muestra el logo de Marvel")
            XCTAssertEqual(imageFooterMarvel.image, UIImage(named: "MarvelPeople"), "Se muestra el Art de Marvel")
        }
    }

    func testPerformanceExample() throws {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }

}
