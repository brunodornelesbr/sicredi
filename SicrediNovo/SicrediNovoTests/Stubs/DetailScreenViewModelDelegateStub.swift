//
//  DetailScreenViewModelDelegateStub.swift
//  SicrediNovoTests
//
//  Created by Bruno Dorneles on 24/02/21.
//

import UIKit
@testable import SicrediNovo
class DetailScreenViewModelDelegateStub: DetailsScreenDelegate {
    var didCallEventAvailable = false
    var didCallShowShareScreenWith = false
    func eventAvailable(event: Event) {
        didCallEventAvailable = true
    }

    func showShareScreenWith(text: String) {
        didCallShowShareScreenWith = true
    }

    func showError(error: Error) {
        
    }
}
