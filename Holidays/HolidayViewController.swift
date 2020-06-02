//
//  HolidayViewController.swift
//  Holidays
//
//  Created by Nick Ivanov on 01.06.2020.
//  Copyright © 2020 Nick Ivanov. All rights reserved.
//

import UIKit

class HolidayViewController: UITableViewController {
    
    @IBOutlet var searchBar: UISearchBar!
    
    var holidaysList = [HolidayDetail]() {
        didSet {
            DispatchQueue.main.async {
                self.tableView.reloadData()
                self.navigationItem.title = "\(self.holidaysList.count) Holidays found"
            }
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        searchBar.delegate = self
    }

    // MARK: - Table view data source
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)
        
        let holiday = holidaysList[indexPath.row]
        
        cell.textLabel?.text = holiday.name
        cell.detailTextLabel?.text = holiday.date.iso
        return cell
    }

    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return holidaysList.count
    }
}

extension HolidayViewController: UISearchBarDelegate {
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        guard let searchBarText = searchBar.text else {return}
        let holidayRequest = HolidayRequest(country: searchBarText)
        print(holidayRequest)
        holidayRequest.getHolidays{ [weak self]  result in
            switch result {
            case .failure(let error):
                print(error)
            case .success(let holidays):
                self?.holidaysList = holidays
            }
        }
    }
}
