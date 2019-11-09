//
//  HomeViewModel.swift
//  InfoSpaceX
//
//  Created by Sagar Thapa on 11/9/19.
//  Copyright © 2019 Tenhaff. All rights reserved.
//

import Foundation


struct HomeViewModel {
    private var originalLaunches = [Launches]()
    private var tempLaunches = [Launches]()
    
    init(orginalLaunches: [Launches], tempLaunches: [Launches]) {
        self.originalLaunches = orginalLaunches
        self.tempLaunches = tempLaunches
    }
    
    var numberOfRows:Int {
        return tempLaunches.count
    }
    
    func getLaunch(atIndex index: Int) -> HomeViewTableViewCellModel? {
        if tempLaunches.isEmpty {
            return nil
        } else {
            let launch = tempLaunches[index]
            return HomeViewTableViewCellModel(launch: launch)
        }
        
    }
    
    func getSotredList(sortOption: SortOption)-> [Launches] {
        
        if !tempLaunches.isEmpty {
            switch sortOption {
            case .name:
                return tempLaunches.sorted(by: {$0.mission_name ?? "" < $1.mission_name ?? ""})
            case .year:
                return tempLaunches.sorted(by: { $0.launch_year! < $1.launch_year!})
            case .success:
                return tempLaunches.filter { rocket in
                    if let success = rocket.launch_success {
                        if success {
                            return true
                        }
                    }
                    return false
                }
            case .reset:
                return self.originalLaunches
                
            }
        }else {
            return self.originalLaunches
        }
        
        
    }
    
    
}
