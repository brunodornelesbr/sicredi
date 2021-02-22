//
//  InitialScreenViewModelStub.swift
//  SicrediNovoTests
//
//  Created by Bruno Dorneles on 22/02/21.
//

import UIKit
@testable import SicrediNovo

class InitialScreenViewModelStub: InitialScreenViewModel {
    var didCallViewDidFinishLoading = false
    var didCallDidSelectRow = false

    func viewDidFinishLoading() {
        didCallViewDidFinishLoading = true
    }

    func numberOfEventsToShow() -> Int {
        return 1
    }

    func eventFor(row: Int) -> Event? {
        return nil
    }

    func didSelect(row: Int) {
        didCallDidSelectRow = true
    }

    var initialScreenDelegate: InitialScreenViewModelDelegate?

}
