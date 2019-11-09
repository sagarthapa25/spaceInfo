//
//  ViewController.swift
//  InfoSpaceX
//
//  Created by Sagar Thapa on 11/8/19.
//  Copyright © 2019 Tenhaff. All rights reserved.
//

import UIKit

enum SortOption: Int {
    case name, year, success, reset
}

class HomeViewController: UIViewController {
    
    let spaceXClient = APIClient()
    var launches: [Launches]?
    var tempLaunches: [Launches]?
    
    var homeViewModel = HomeViewModel(orginalLaunches: [], tempLaunches: [])
    
    @IBOutlet weak var activityIndicatorView: UIActivityIndicatorView!
    @IBOutlet weak var tableView: UITableView!{
        didSet {
            tableView.rowHeight = UITableView.automaticDimension
            tableView.estimatedRowHeight = 44
            tableView.isHidden = true
        }
    }
    
    @IBOutlet weak var reloadBtn: UIButton!{
        didSet {
            reloadBtn.isHidden = true
            reloadBtn.addTarget(self, action: #selector(reload(_:)), for: .touchUpInside)
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.setupViews()
        self.fetchLaunches()
        
        
        
    }
    
    
    
    
}

extension HomeViewController: UITableViewDataSource, UITableViewDelegate {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.homeViewModel.numberOfRows
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: LaunchCell.identifier, for: indexPath) as! LaunchCell
        cell.model = self.homeViewModel.getLaunch(atIndex: indexPath.row)
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        
        guard let launches = launches else { return }
        let rocket = launches[indexPath.row]
        
        let detailVC = LaunchDetailViewController()
        detailVC.launchDetailViewModel = LaunchDetailViewModel(rocket: rocket)
        detailVC.view.frame = self.view.bounds
        
        self.navigationController?.pushViewController(detailVC, animated: true)
    }
}

extension HomeViewController {
    
    private func setupViews() {
        self.title = "Rocket Launches"
        let barButton = UIBarButtonItem(title: "Sort", style: .plain, target: self, action: #selector(sort(_:)))
        let attrs = [
            NSAttributedString.Key.foregroundColor: UIColor.black,
            NSAttributedString.Key.font: UIFont(name: "Roboto-Medium", size: 18)!
        ]
        barButton.setTitleTextAttributes(attrs, for: .normal)
        self.navigationItem.rightBarButtonItem = barButton
    }
    
    private func fetchLaunches() {
        self.activityIndicatorView.startAnimating()
        self.reloadBtn.isHidden = true
        spaceXClient.getLaunchList(of: Launches.self, from: URL(string: "https://api.spacexdata.com/v3/launches")!) { (result) in
            switch result {
            case .failure(let error):
                self.hideIndicator()
                
                if error is DataError {
                    Logger.log(message: "DataError: \(error)", event: .i)
                    
                } else {
                    Logger.log(message: "failure: \(error.localizedDescription)", event: .i)
                }
                DispatchQueue.main.async {
                    self.reloadBtn.isHidden = false
                    self.reloadBtn.setTitle("\(error) ,Tap to reload", for: .normal)
                }
            case .success(let launches):
                self.launches = launches
                self.tempLaunches = launches
                self.hideIndicator()
                DispatchQueue.main.async {
                    self.homeViewModel = HomeViewModel(orginalLaunches: launches, tempLaunches: launches)
                    self.tableView.isHidden = false
                    self.tableView.reloadData()
                }
            }
        }
    }
    
    @objc private func reload(_ sender: UIButton) {
        fetchLaunches()
    }
    
    func hideIndicator() {
        DispatchQueue.main.async {
            self.activityIndicatorView.stopAnimating()
        }
        
    }
    

    
    
    @objc func sort(_ sender: UIBarButtonItem) {
        self.showSortOptins()
    }
    
    
    private func showSortOptins() {
        let alert = UIAlertController(title: "Sort By", message: "Please Select Sort Option", preferredStyle: .actionSheet)
        alert.addAction(UIAlertAction(title: "Misson Name", style: .default, handler: { (_) in
            self.sortBy(sortOption: .name)
        }))
        
        alert.addAction(UIAlertAction(title: "Launch Year", style: .default, handler: { (_) in
            self.sortBy(sortOption: .year)
        }))
        
        alert.addAction(UIAlertAction(title: "Launch Success", style: .default, handler: { (_) in
            self.sortBy(sortOption: .success)
        }))
        alert.addAction(UIAlertAction(title: "Reset", style: .default, handler: { (_) in
            self.sortBy(sortOption: .reset)
        }))
        
        alert.addAction(UIAlertAction(title: "Dismiss", style: .cancel, handler: { (_) in
            Logger.log(message: "Dismiss", event: .i)
        }))
        
        self.present(alert, animated: true, completion: nil)
    }
    
    private func sortBy(sortOption: SortOption) {
        guard let originalLaunches = launches else {
            return
        }
        let sortedLaunches = self.homeViewModel.getSotredList(sortOption: sortOption)
        self.homeViewModel = HomeViewModel(orginalLaunches: originalLaunches, tempLaunches: sortedLaunches)

        self.tableView.reloadSections(IndexSet(integer: 0), with: .automatic)
        self.tableView.scrollToRow(at: IndexPath(row: 0, section: 0), at: .top, animated: true)
    }
}

class LaunchCell: UITableViewCell {
    
    @IBOutlet weak var missionNameLbl: UILabel!
    @IBOutlet weak var launchYearLbl: UILabel!
    @IBOutlet weak var launchSuccessLbl: UILabel!
    
    static var identifier: String {
        return String(describing: self)
    }
    
    var model: HomeViewTableViewCellModel? {
        didSet {
            guard let model = model else { return }
            setup(missionName: model.getMissionName, launchYear: model.getMissionLaunchYear, isLaunchSuccess: model.getMissionIsSuccess)
        }
    }
    
    private func setup(missionName: String?, launchYear: String?, isLaunchSuccess: String?) {
        missionNameLbl.text = missionName
        launchYearLbl.text = launchYear
        launchSuccessLbl.text = isLaunchSuccess
    }
    
}
