//
//  DetailScreenViewModelStub.swift
//  SicrediNovoTests
//
//  Created by Bruno Dorneles on 24/02/21.
//

import UIKit
@testable import SicrediNovo

class DetailScreenViewModelStub: DetailsScreenViewModel {
    var detailsDelegate: DetailsScreenDelegate?
    var didCallViewDidFinishLoading = false

    func viewDidFinishLoading() {
        didCallViewDidFinishLoading = true
    }

    func didTouchShareAction() {}
}
