//
//  CategoriesViewController.swift
//  NetworkingExampleSwift
//
//  Created by Seryozha Poghosyan on 11/27/16.
//  Copyright © 2016 Workfront. All rights reserved.
//

import UIKit

class CategoriesViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {

    @IBOutlet weak var tableView: UITableView!
    
    private lazy var refreshControl: UIRefreshControl = {
        let control = UIRefreshControl()
        control.addTarget(self, action: #selector(refreshAction), for: .valueChanged)
        return control
    }()
    
    var categories = [Category]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.addSubview(refreshControl)
        loadData()
    }
    
    // MARK: Actions
    
    func refreshAction() {
        loadData()
    }
    
    private func loadData() {
        self.categories = DataManager.shared.loadCategories { (categories) in
            DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + 3, execute: {
                self.categories = categories
                self.refreshControl.endRefreshing()
                self.tableView.reloadData()
            })
        }
        self.tableView.reloadData()
    }
    
    // MARK: UITableViewDataSource & UITableViewDelegate methods
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return categories.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "categoryCell", for: indexPath)
        let category = categories[indexPath.row]
        cell.textLabel?.text = category.title
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }
}
