//
//  MainEventTableViewCell.swift
//  SicrediChallenge
//
//  Created by Bruno Dorneles on 05/12/18.
//  Copyright © 2018 Bruno. All rights reserved.
//

import UIKit

class MainEventTableViewCell: UITableViewCell {
    @IBOutlet private weak var eventThumbnail: UIImageView!
    @IBOutlet private weak var eventNameLabel: UILabel!
    
    static public let xibName = "MainEventCell"

    func setup(event : Event){
        eventNameLabel.text = event.title
        DispatchQueue.global().async {
            guard let url = URL(string: event.image), let data = try? Data(contentsOf: url) else {
                return
            }
            DispatchQueue.main.async { [weak self] in
                self?.eventThumbnail.image = UIImage(data: data)
            }
        }
    }

}

extension UITableViewCell{
    static func reuseIdentifier()-> String {
        return  String(describing: type(of: self))
    }
}
