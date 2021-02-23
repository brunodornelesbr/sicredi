//
//  EventsNetworkRequests.swift
//  SicrediNovo
//
//  Created by Bruno Dorneles on 22/02/21.
//

import UIKit

protocol EventsNetworkRequests {
    func requestEvents(completionHandler: @escaping ([Event], Error?)->())
    func requestSingleEventInformation(eventId: String, completionHandler: @escaping (Event?, Error?)->())
    func postCheckInInformation(checkInformation: CheckInInformation, completionHandler: @escaping (Bool, Error?)->())
}


struct EventsNetworkRequestsImpl: EventsNetworkRequests {
    var network: Network!

    init(network: Network = NetworkImpl()) {
        self.network = network
    }

    func requestEvents(completionHandler: @escaping ([Event], Error?) -> ()) {
        guard let url = URL(string: APIConstants.eventUrl) else {
            completionHandler([],NetworkError.networkError)
            return
        }

        network.requestGetList(url: url) {(data,error) in
            guard error == nil else {
                completionHandler([],error)
                return
            }
            guard let data = data, let eventList = try? JSONDecoder().decode([Event].self, from: data) else {
                completionHandler([],NetworkError.noData)
                return
            }
            completionHandler(eventList, nil)
        }
    }

    func requestSingleEventInformation(eventId: String,completionHandler: @escaping (Event?, Error?) -> ()) {
        let moreInfoString = String(format:APIConstants.eventDetail, eventId)

        guard let moreInfoURL = URL(string: moreInfoString) else {
            completionHandler(nil, NetworkError.networkError)
            return
        }

        network.requestGetList(url: moreInfoURL) {data, error in
            guard error == nil else {
                completionHandler(nil, error)
                return
            }

            guard let data = data, let event = try? JSONDecoder().decode(Event.self, from: data) else {
                completionHandler(nil, NetworkError.noData)
                return
            }

            completionHandler(event, nil)
        }
    }

    func postCheckInInformation(checkInformation: CheckInInformation, completionHandler: @escaping (Bool, Error?)->()) {
        
    }

}
