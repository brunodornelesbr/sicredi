//
//  EventsNetworkStub.swift
//  SicrediNovoTests
//
//  Created by Bruno Dorneles on 22/02/21.
//

import UIKit
@testable import SicrediNovo

class EventsNetworkStub: EventsNetworkRequests {
    var shouldThrowError = false
    func requestEvents(completionHandler: @escaping ([Event], Error?) -> ()) {
        completionHandler([Event(id: "0", title: "Evento Teste", price: 23, latitude: 10, longitude: 10, description: "Descricao teste", date: 20, image: "imagem", people: [""])], shouldThrowError ? NetworkError.noData : nil)
    }
}
