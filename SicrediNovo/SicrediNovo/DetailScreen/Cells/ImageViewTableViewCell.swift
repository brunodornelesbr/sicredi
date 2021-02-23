//
//  ImageViewTableViewCell.swift
//  fourAllChallenge
//
//  Created by Bruno Dorneles on 20/11/18.
//  Copyright © 2018 Bruno. All rights reserved.
//

import UIKit

class ImageViewTableViewCell: UITableViewCell {

    @IBOutlet weak var mainImageView: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var priceLabel: UILabel!

    static let xibName = "ImageViewCell"

    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }

    func setup(event : Event){
        titleLabel.text = event.title
        priceLabel.text = String(format: " R$%.02f", event.price)
       
        DispatchQueue.global().async {
            guard let url = URL(string: event.image), let data = try? Data(contentsOf: url) else {
                return
            }
            DispatchQueue.main.async { [weak self] in
                self?.mainImageView.image = UIImage(data: data)
            }
        }
    }
}
