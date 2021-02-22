//
//  InitialScreenViewController.swift
//  SicrediNovo
//
//  Created by Bruno Dorneles on 22/02/21.
//

import UIKit

class InitialScreenViewController: UIViewController {
    @IBOutlet private weak var tableView: UITableView!
    fileprivate var viewModel: InitialScreenViewModel!
    fileprivate static var storyboardName = "Main"
    fileprivate static var storyboardIdentifier = "InitialScreen"

    static public func loadFromStoryboard(model:  InitialScreenViewModel)->InitialScreenViewController {
        let storyboard = UIStoryboard.init(name: storyboardName, bundle: nil)
        let vc = storyboard.instantiateViewController(withIdentifier: storyboardIdentifier) as! InitialScreenViewController
        vc.viewModel = model
        vc.viewModel.initialScreenDelegate = vc
        return vc
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        setupTableView()
        viewModel.viewDidFinishLoading()
    }

    private func setupTableView() {
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(UINib(nibName: MainEventTableViewCell.xibName, bundle: nil), forCellReuseIdentifier: MainEventTableViewCell.reuseIdentifier())
    }
}

extension InitialScreenViewController: InitialScreenViewModelDelegate {
    func eventsAvailable(events: [Event]) {
        DispatchQueue.main.async {
            self.tableView.reloadData()
        }
    }

    func showError(error: Error) {
        //TODO
    }
}

extension InitialScreenViewController: UITableViewDelegate, UITableViewDataSource {

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.numberOfEventsToShow()
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: MainEventTableViewCell.reuseIdentifier()) as? MainEventTableViewCell, let event = viewModel.eventFor(row: indexPath.row) else {
            return UITableViewCell()
        }

        cell.setup(event: event)
        return cell
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        viewModel.didSelect(row: indexPath.row)
    }

    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 70
    }
}
