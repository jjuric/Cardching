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
    
    var viewModel: CardsViewModel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupTable()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.isNavigationBarHidden = false
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(addCardTapped))
    }
    
    func setupTable() {
        cardsTableView.register(CardTableViewCell.self, forCellReuseIdentifier: "CardTableViewCell")
        cardsTableView.alwaysBounceVertical = false
        cardsTableView.alwaysBounceHorizontal = false
        cardsTableView.showsHorizontalScrollIndicator = false
        cardsTableView.showsVerticalScrollIndicator = false
        cardsTableView.delegate = self
        cardsTableView.dataSource = self
        cardsTableView.tableFooterView = UIView()
    }
    
    @objc func addCardTapped() {
        viewModel.addNewCard()
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
