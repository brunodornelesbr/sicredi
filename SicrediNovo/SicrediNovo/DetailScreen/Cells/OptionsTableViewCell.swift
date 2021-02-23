//
//  OptionsTableViewCell.swift
//  fourAllChallenge
//
//  Created by Bruno Dorneles on 20/11/18.
//  Copyright © 2018 Bruno. All rights reserved.
//

import UIKit
import MapKit

class OptionsTableViewCell: UITableViewCell {
    static let xibName = "OptionsViewCell"
    @IBOutlet private weak var commentButton: UIButton!
    @IBOutlet private weak var addressButton: UIButton!
    @IBOutlet private weak var mainTextView: UITextView!
    @IBOutlet private weak var mapView: MKMapView!

    public var commentButtonDidTouch: ()->() = {}
    public var addressButtonDidTouch: ()->() = {}

    override func awakeFromNib() {
        super.awakeFromNib()
        commentButton.addTarget(self, action: #selector(didTouchComment), for: .touchUpInside)
        addressButton.addTarget(self, action: #selector(didTouchAddress), for: .touchUpInside)
    }

    @objc
    private func didTouchComment() {
        commentButtonDidTouch()
    }

    @objc
    private func didTouchAddress() {
        addressButtonDidTouch()
    }
    
    func setup(event: Event) {
        let initialLocation = CLLocation(latitude: Double(event.latitude), longitude: Double(event.longitude))
        let annotation = MKPointAnnotation()
        
        let region = MKCoordinateRegion(center: initialLocation.coordinate,
                                        latitudinalMeters: 300, longitudinalMeters: 300)
        mapView.setRegion(region, animated: true)
        annotation.coordinate = initialLocation.coordinate
        mapView.addAnnotation(annotation)
        
        mainTextView.text = event.description
    }
    
}
