//
//  CardsViewController.swift
//  Cardching
//
//  Created by Jakov Juric on 09/09/2019.
//  Copyright © 2019 Jakov Juric. All rights reserved.
//

import UIKit

class CardsViewController: UIViewController {
    //MARK: - Outlets
    @IBOutlet weak var headerView: UIView!
    @IBOutlet weak var cardsTableView: UITableView!
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    
    lazy var emptyView: EmptyView = {
        let empty = EmptyView()
        empty.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(empty)
        empty.anchor(top: (view.safeAreaLayoutGuide.topAnchor, 0), bottom: (view.safeAreaLayoutGuide.bottomAnchor, 0), leading: (view.safeAreaLayoutGuide.leadingAnchor, 0), trailing: (view.safeAreaLayoutGuide.trailingAnchor, 0))
        return empty
    }()
    lazy var noInternetView: NoInternetView = {
        let internet = NoInternetView()
        internet.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(internet)
        internet.anchor(top: (view.safeAreaLayoutGuide.topAnchor, 0), bottom: (view.safeAreaLayoutGuide.bottomAnchor, 0), leading: (view.safeAreaLayoutGuide.leadingAnchor, 0), trailing: (view.safeAreaLayoutGuide.trailingAnchor, 0))
        internet.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(noInternetTapped)))
        return internet
    }()
    
    var viewModel: CardsViewModel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(addCardTapped))
        self.navigationItem.leftBarButtonItem = UIBarButtonItem(title: "Odjavi se", style: .plain, target: self, action: #selector(logOutTapped))
        addCallbacks()
        setupTable()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.isNavigationBarHidden = false
        viewModel.loadUserCards()
    }
    
    private func setupTable() {
        cardsTableView.register(CardTableViewCell.self, forCellReuseIdentifier: "CardTableViewCell")
        cardsTableView.alwaysBounceVertical = false
        cardsTableView.alwaysBounceHorizontal = false
        cardsTableView.showsHorizontalScrollIndicator = false
        cardsTableView.showsVerticalScrollIndicator = false
        cardsTableView.delegate = self
        cardsTableView.dataSource = self
        cardsTableView.tableFooterView = UIView()
    }
    
    private func addCallbacks() {
        viewModel.onError = { [weak self] error in
            self?.showAlert(title: "Ups!", message: error)
        }
        viewModel.onStateChanged = { [weak self] state in
            switch state {
            case .initial:
                self?.emptyView.isHidden = true
                self?.noInternetView.isHidden = true
                self?.cardsTableView.reloadData()
                self?.activityIndicator.stopAnimating()
            case .loaded:
                self?.emptyView.isHidden = true
                self?.noInternetView.isHidden = true
                self?.cardsTableView.reloadData()
                self?.activityIndicator.stopAnimating()
            case .loading:
                self?.activityIndicator.startAnimating()
                self?.emptyView.isHidden = true
                self?.noInternetView.isHidden = true
            case .empty:
                //add empty view
                self?.activityIndicator.stopAnimating()
                self?.emptyView.isHidden = false
                self?.noInternetView.isHidden = true
            case .noInternet:
                self?.activityIndicator.stopAnimating()
                self?.emptyView.isHidden = true
                self?.noInternetView.isHidden = false
            }
        }
    }
    
    private func showAlert(title: String, message: String) {
        let ac = UIAlertController(title: title, message: message, preferredStyle: .alert)
        ac.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
        present(ac, animated: true)
    }
    
    @objc func addCardTapped() {
        viewModel.addNewCard()
    }
    
    @objc func logOutTapped() {
        viewModel.logOutUser()
    }
    
    @objc func noInternetTapped() {
        viewModel.loadUserCards()
    }
}

extension CardsViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.cards.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "CardTableViewCell", for: indexPath) as! CardTableViewCell
        cell.viewModel = viewModel
        cell.card = viewModel.cards[indexPath.row]
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 100
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        viewModel.showCardDetails(for: indexPath.row)
    }
}
