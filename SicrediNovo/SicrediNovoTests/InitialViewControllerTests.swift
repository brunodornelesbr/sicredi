//
//  InitialViewControllerTests.swift
//  SicrediNovoTests
//
//  Created by Bruno Dorneles on 22/02/21.
//

import XCTest
@testable import SicrediNovo

class InitialViewControllerTests: XCTestCase {
    var initialScreenViewController: InitialScreenViewController!
    var modelStub: InitialScreenViewModelStub!

    override func setUp() {
        modelStub = InitialScreenViewModelStub()
        initialScreenViewController = InitialScreenViewController.loadFromStoryboard(model: modelStub)
        initialScreenViewController.loadView()
    }

    func testAfterloadingFromStoryboardShouldSetItselfAsADelegateToTheViewModel() {
        XCTAssertTrue(modelStub.initialScreenDelegate === initialScreenViewController, "VC should assign itself as a delegate to the viewmodel")
    }

    func testViewControllerShouldInformModelThatItDidLoad() throws {
        initialScreenViewController.viewDidLoad()
        XCTAssertTrue(modelStub.didCallViewDidFinishLoading, "View has to inform that it did finish load so we can start fetching events.")
    }

    func testViewControllerShouldInformTheViewModelThatASelectionWasMadeInTheTableVieW() {
        initialScreenViewController.tableView(UITableView(), didSelectRowAt: IndexPath(row: 0, section: 0))
        XCTAssertTrue(modelStub.didCallDidSelectRow)
    }
}
