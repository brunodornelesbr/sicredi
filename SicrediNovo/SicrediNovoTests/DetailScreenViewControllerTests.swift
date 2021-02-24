//
//  DetailScreenViewControllerTests.swift
//  SicrediNovoTests
//
//  Created by Bruno Dorneles on 24/02/21.
//

import XCTest
@testable import SicrediNovo

class DetailScreenViewControllerTests: XCTestCase {
    var detailsScreenViewController: DetailScreenViewController!
    var modelStub: DetailScreenViewModelStub!

    override func setUp() {
        modelStub = DetailScreenViewModelStub()
        detailsScreenViewController = DetailScreenViewController.loadFromStoryboard(model: modelStub)
        detailsScreenViewController.loadView()
    }

    func testAfterloadingFromStoryboardShouldSetItselfAsADelegateToTheViewModel() {
        XCTAssertTrue(modelStub.detailsDelegate === detailsScreenViewController, "VC should assign itself as a delegate to the viewmodel")
    }

    func testViewControllerShouldInformModelThatItDidLoad() throws {
        detailsScreenViewController.viewDidLoad()
        XCTAssertTrue(modelStub.didCallViewDidFinishLoading, "View has to inform that it did finish load so we can start fetching event details.")
    }

    func testIfShowedActivityVCToShareInformation() {
        UIApplication.shared.keyWindow?.rootViewController = detailsScreenViewController
        let completedExpectation = expectation(description: "Completed")

        detailsScreenViewController.showShareScreenWith(text: "Test")
        //We present the VC in the main queue, so this piece of code forces to assert it after presenting in the main queue
        DispatchQueue.main.async {
            XCTAssertTrue(self.detailsScreenViewController.presentedViewController is UIActivityViewController, "Should have presented an activityviewcontroller")
            completedExpectation.fulfill()
        }
        waitForExpectations(timeout: 0.5, handler: nil)
    }

}
