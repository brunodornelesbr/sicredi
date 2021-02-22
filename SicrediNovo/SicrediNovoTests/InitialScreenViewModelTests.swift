//
//  InitialScreenViewModelTests.swift
//  SicrediNovoTests
//
//  Created by Bruno Dorneles on 22/02/21.
//

import XCTest
@testable import SicrediNovo

class InitialScreenViewModelTests: XCTestCase {
    var initialScreenViewModel: InitialScreenViewModelImpl!
    var initialDelegateStub: InitialScreenViewModelDelegateStub!
    var eventsNetworkStub: EventsNetworkStub!

    override func setUp() {
        initialDelegateStub = InitialScreenViewModelDelegateStub()
        eventsNetworkStub = EventsNetworkStub()
        initialScreenViewModel = InitialScreenViewModelImpl(delegate: initialDelegateStub, networkRequest: eventsNetworkStub)
    }

    func testAfterViewDidFinishLoadingShouldRequestEventsAndInformDelegateThatNewEventsHaveArrived() {
        initialScreenViewModel.viewDidFinishLoading()
        XCTAssert(initialDelegateStub.hasReceivedNumberOfEvents == 1, "Expecting one event")
        XCTAssert(initialScreenViewModel.numberOfEventsToShow() == 1, "Expecting one event")
        XCTAssertNil(initialScreenViewModel.eventFor(row: 2),"Should return nil if event is out of bounds")
    }

    func testViewModelShouldWarnDelegateThatAErrorOccured() {
        eventsNetworkStub.shouldThrowError = true
        initialScreenViewModel.viewDidFinishLoading()
        XCTAssertTrue(initialDelegateStub.hasRequestedToShowError, "Should warn about errors in the delegate")
    }

    func testAfterEventSelectionShouldAskForDelegateToNavigateToDetailsScreen() {
        initialScreenViewModel.viewDidFinishLoading()
        initialScreenViewModel.didSelect(row: 0)
        XCTAssertTrue(initialDelegateStub.hasAskedToPushVC)
    }
}
