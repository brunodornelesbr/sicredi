//
//  ListOfEventsRequest.swift
//  SicrediChallenge
//
//  Created by Bruno Dorneles on 05/12/18.
//  Copyright © 2018 Bruno. All rights reserved.
//

import UIKit

struct Event: Codable {
    var id = "0"
    var title = "No Title"
    var price: Double = 0.0
    var latitude: Double = 0.0
    var longitude: Double = 0.0
    var description = ""
    var date: Double = 0.0
    var image = "http://lproweb.procempa.com.br/pmpa/prefpoa/seda_news/usu_img/Papel%20de%20Parede.png"
    var people = [String]()
}
