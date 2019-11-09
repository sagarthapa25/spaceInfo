//
//  HomeViewTableViewCellModel.swift
//  InfoSpaceX
//
//  Created by Sagar Thapa on 11/9/19.
//  Copyright © 2019 Tenhaff. All rights reserved.
//

import Foundation

struct HomeViewTableViewCellModel {
    private var launch:Launches
    
    init(launch: Launches) {
        self.launch = launch
    }
    
    var getMissionName: String? {
        guard let name = launch.mission_name else { return nil }
        return "Mission name: \(name)"
    }
    var getMissionLaunchYear: String? {
        guard let year = launch.launch_year else { return nil }
        return "Launch year: \(year)"
    }
    var getMissionIsSuccess: String? {
        guard let success = launch.launch_success else { return nil }
        var sucs = "No"
        if success {
            sucs = "Yes"
        }
        return "Launch success: \(sucs)"
    }
    
}
