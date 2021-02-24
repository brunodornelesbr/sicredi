//
//  DetailScreenViewModel.swift
//  SicrediNovo
//
//  Created by Bruno Dorneles on 22/02/21.
//

import UIKit
protocol DetailsScreenDelegate: class {
    func eventAvailable(event: Event)
    func showShareScreenWith(text: String)
    func showError(error: Error)
}
protocol DetailsScreenViewModel {
    func viewDidFinishLoading()
    func didTouchShareAction()
    var detailsDelegate: DetailsScreenDelegate? {get set}
}

class DetailScreenViewModelImpl: DetailsScreenViewModel {
    private var networkRequest: EventsNetworkRequests!
    private var eventId: String!
    private var event: Event?

    public var detailsDelegate: DetailsScreenDelegate?

    init(delegate: DetailsScreenDelegate? = nil, networkRequest: EventsNetworkRequests!, eventId: String) {
        detailsDelegate = delegate
        self.eventId = eventId
        self.networkRequest = networkRequest
    }

    func viewDidFinishLoading() {
        requestDetails()
    }

    public func didTouchShareAction() {
        detailsDelegate?.showShareScreenWith(text: getShareableText())
    }

    private func getShareableText()->String {
        return "\(event?.title ?? "") \(event?.description ?? "")"
    }

    private func requestDetails() {
        networkRequest.requestSingleEventInformation(eventId: eventId) {[weak self] event, error in
            guard error == nil, let strongSelf = self else {
                self?.detailsDelegate?.showError(error: error!)
                return
            }

            guard let event = event else {
                return
            }
            strongSelf.event = event
            strongSelf.detailsDelegate?.eventAvailable(event: event)
        }
    }
}
