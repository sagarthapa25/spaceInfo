//
//  LaunchDetailViewController.swift
//  InfoSpaceX
//
//  Created by Sagar Thapa on 11/8/19.
//  Copyright © 2019 Tenhaff. All rights reserved.
//

import UIKit
import SafariServices

enum LaunchInfoItemType {
    case launchInfo, rocketInfo
}

protocol HomeViewModelItem {
    var type: LaunchInfoItemType {get}
    var sectionTitle: String {get}
    var numberOfRows: Int {get}
}


class LaunchDetailViewController: UIViewController {
    
    var tableView:UITableView!
    var launchDetailViewModel: LaunchDetailViewModel! {
        didSet {
            guard let rocketId = launchDetailViewModel.getRocketId else { return  }
            self.fetchRocketInfo(id: rocketId)
        }
    }
    
    var sections = [HomeViewModelItem]()
    let spaceXClient = APIClient()
    var rocketViewModel: RocketViewModel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.sections.append(launchDetailViewModel)
        setupViews()
    }
    
   
    
}

extension LaunchDetailViewController {
    
    private func setupViews() {
        tableView = UITableView()
        tableView.rowHeight = UITableView.automaticDimension
        tableView.estimatedRowHeight = 44
        tableView.delegate = self
        tableView.dataSource = self
        
        tableView.separatorStyle = .none
        self.view.addSubview(tableView)
        tableView.translatesAutoresizingMaskIntoConstraints = false
        
        tableView.register(UINib(nibName: "LaunchInfoTableViewCell", bundle: nil), forCellReuseIdentifier: "launchInfoCell")
        tableView.register(RocketInfoTableViewCell.nib, forCellReuseIdentifier: RocketInfoTableViewCell.identifier)
        
        tableView.leftAnchor.constraint(equalTo: view.leftAnchor).isActive = true
        tableView.rightAnchor.constraint(equalTo: view.rightAnchor).isActive = true
        tableView.topAnchor.constraint(equalTo: view.topAnchor).isActive = true
        tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
        
        self.tableView.reloadData()
    }
    
    private func fetchRocketInfo(id: String) {
        let url = URL(string: "https://api.spacexdata.com/v3/rockets/"+id)!
        Logger.log(message: "url: \(url)", event: .i)
        spaceXClient.getRocket(of: Rocket.self, from: url) { result in
            switch result {
            case .failure(let error):
                if error is DataError {
                    Logger.log(message: "DataError: \(error)", event: .i)
                    
                } else {
                    Logger.log(message: "failure: \(error.localizedDescription)", event: .i)
                }
            case .success(let rocket):
                DispatchQueue.main.async {
                    self.rocketViewModel = RocketViewModel(rocket: rocket)
                    self.sections.append(self.rocketViewModel)
                    self.tableView.reloadData()
                }
            }
        }
    }
    
}
extension LaunchDetailViewController: UITableViewDataSource, UITableViewDelegate {
    func numberOfSections(in tableView: UITableView) -> Int {
        return sections.count
    }
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return sections[section].numberOfRows
    }
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {

        let info = sections[indexPath.section]
        switch info.type {
        case .launchInfo:
            let cell = tableView.dequeueReusableCell(withIdentifier: "launchInfoCell", for: indexPath) as! LaunchInfoTableViewCell
            cell.model = info
            cell.selectionStyle = .none
            return cell
        case .rocketInfo:
            let cell = tableView.dequeueReusableCell(withIdentifier: RocketInfoTableViewCell.identifier, for: indexPath) as! RocketInfoTableViewCell
            cell.model = info
            cell.delegate = self
            cell.selectionStyle = .none
            return cell
        }
   
        
        
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 45
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: false)
    }
    
    
}

extension LaunchDetailViewController: RocketInfoTableViewCellDelegate {
    
    func viewWikipediaTapped() {
        if let url = self.rocketViewModel.getWikipediaUrl {
            let config = SFSafariViewController.Configuration()
            config.entersReaderIfAvailable = true
            let vc = SFSafariViewController(url: url, configuration: config)
            self.present(vc, animated: true, completion: nil)
        }
    }
    
    
}
