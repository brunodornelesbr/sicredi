//
//  DetailScreenViewController.swift
//  SicrediNovo
//
//  Created by Bruno Dorneles on 22/02/21.
//

import UIKit

class DetailScreenViewController: UIViewController {
    private static var storyboardName = "Main"
    private static var storyboardIdentifier = "detail"
    private var viewModel: DetailsScreenViewModel!
    @IBOutlet private weak var tableView: UITableView!
    private var imageViewCell: ImageViewTableViewCell!
    private var optionsTableViewCell: OptionsTableViewCell!

    static public func loadFromStoryboard(model:  DetailsScreenViewModel)->DetailScreenViewController {
        let storyboard = UIStoryboard.init(name: storyboardName, bundle: nil)
        let vc = storyboard.instantiateViewController(withIdentifier: storyboardIdentifier) as! DetailScreenViewController
        vc.viewModel = model
        vc.viewModel.detailsDelegate = vc
        return vc
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        tableViewSetup()
        viewModel.viewDidFinishLoading()
    }

    private func tableViewSetup() {
        imageViewCell = Bundle.main.loadNibNamed(ImageViewTableViewCell.xibName, owner: nil, options: nil)?.first as? ImageViewTableViewCell
        optionsTableViewCell = Bundle.main.loadNibNamed(OptionsTableViewCell.xibName, owner: nil, options: nil)?.first as? OptionsTableViewCell

        optionsTableViewCell.commentButtonDidTouch = {
            self.viewModel.didTouchShareAction()
        }

        tableView.delegate = self
        tableView.dataSource = self
    }

    private func showCheckIn() {
        let alert = UIAlertController(title: "CHECK-IN", message: "Precisamos do seu nome e email para fazer checkin", preferredStyle: .alert)

        alert.addTextField { (textField) in
            textField.placeholder = "Nome"
        }
        alert.addTextField { (textField) in
            textField.placeholder = "Email"
        }

        alert.addAction(UIAlertAction(title: "Checkin", style: .default, handler: { [weak self] _ in
            guard let textFields = alert.textFields, let nameField = textFields[safe: 0], let emailField = textFields[safe: 1], let email = emailField.text, let name = nameField.text else {
                return
            }
            self?.viewModel.checkInWith(email: email, name: name)
        }))

        DispatchQueue.main.async {
            self.present(alert, animated: true, completion: nil)
        }
    }
}

extension DetailScreenViewController: DetailsScreenDelegate {
    func eventAvailable(event: Event) {
        DispatchQueue.main.async {
            self.imageViewCell.setup(event: event)
            self.optionsTableViewCell.setup(event: event)
        }
    }

    func showError(error: Error) {

    }

    func showShareScreenWith(text: String) {
        let activityViewController = UIActivityViewController(activityItems: [text], applicationActivities: nil)
        if let popOver = activityViewController.popoverPresentationController {
            popOver.sourceView = optionsTableViewCell
        }

        DispatchQueue.main.async {
            self.present(activityViewController, animated: true, completion: nil)
        }
    }
}

extension DetailScreenViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 2
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        switch indexPath.row {
            case 0:
                return imageViewCell
            default:
                return optionsTableViewCell
        }
    }

    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        switch indexPath.row {
            case 0:
                return 315
            default:
                return 550
        }
    }
}
