//
//  DetailScreenViewModelTests.swift
//  SicrediNovoTests
//
//  Created by Bruno Dorneles on 24/02/21.
//

import XCTest
@testable import SicrediNovo

class DetailScreenViewModelTests: XCTestCase {
    var detailScreenViewModel: DetailScreenViewModelImpl!
    var detailDelegateStub: DetailScreenViewModelDelegateStub!
    var eventsNetworkStub: EventsNetworkStub!
    var eventId = "1"

    override func setUp() {
        detailDelegateStub = DetailScreenViewModelDelegateStub()
        eventsNetworkStub = EventsNetworkStub()
        detailScreenViewModel = DetailScreenViewModelImpl(delegate: detailDelegateStub, networkRequest: eventsNetworkStub, eventId: eventId)
    }

    func testAfterCallingViewDidFinishLoadingShouldRequestMoreDetailsAboutTheEventAndWarnTheDelegate () {
        detailScreenViewModel.viewDidFinishLoading()
        XCTAssertTrue(detailDelegateStub.didCallEventAvailable)
    }

    func testAfterCallingDidTouchShareActionShouldInformTheDelegateThatItShouldDisplayAnScreenToShareInformationAboutTheEvent() {
        detailScreenViewModel.didTouchShareAction()
        XCTAssertTrue(detailDelegateStub.didCallShowShareScreenWith)
    }
}
