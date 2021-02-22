//
//  InitialScreenViewModelDelegateStub.swift
//  SicrediNovoTests
//
//  Created by Bruno Dorneles on 22/02/21.
//

import UIKit
@testable import SicrediNovo

class InitialScreenViewModelDelegateStub: InitialScreenViewModelDelegate {
    var hasReceivedNumberOfEvents = 0
    var hasRequestedToShowError = false
    var hasAskedToPushVC = false
    func eventsAvailable(events: [Event]) {
        hasReceivedNumberOfEvents = events.count
    }

    func showError(error: Error) {
        hasRequestedToShowError = true
    }

    func pushViewController(vc: UIViewController) {
        hasAskedToPushVC = true
    }
}
