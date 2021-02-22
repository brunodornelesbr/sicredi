//
//  InitialScreenViewModel.swift
//  SicrediNovo
//
//  Created by Bruno Dorneles on 22/02/21.
//

import UIKit

protocol InitialScreenViewModelDelegate: class {
    func eventsAvailable(events: [Event])
    func showError(error: Error)
}

protocol InitialScreenViewModel {
    func viewDidFinishLoading()
    func numberOfEventsToShow()->Int
    func eventFor(row: Int)->Event?
    func didSelect(row: Int)
    var initialScreenDelegate: InitialScreenViewModelDelegate? {get set}
}

class InitialScreenViewModelImpl: InitialScreenViewModel {
    public weak var initialScreenDelegate: InitialScreenViewModelDelegate?
    private var networkRequest: EventsNetworkRequests!
    private var events: [Event] = []

    init(delegate: InitialScreenViewModelDelegate? = nil, networkRequest: EventsNetworkRequests!) {
        initialScreenDelegate = delegate
        self.networkRequest = networkRequest
    }

    public func viewDidFinishLoading() {
        requestEvents()
    }

    public func numberOfEventsToShow() -> Int {
        return events.count
    }

    public func eventFor(row: Int) -> Event? {
        return events[safe: row]
    }

    public func didSelect(row: Int) {

    }

    private func requestEvents() {
        networkRequest.requestEvents{ [weak self] events, error in
            guard error == nil else {
                self?.initialScreenDelegate?.showError(error: error!)
                return
            }
            self?.events = events
            self?.initialScreenDelegate?.eventsAvailable(events: events)
        }
    }

}


extension Collection where Indices.Iterator.Element == Index {
    subscript (safe index: Index) -> Iterator.Element? {
        return indices.contains(index) ? self[index] : nil
    }
}
