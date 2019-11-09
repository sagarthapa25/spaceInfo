//
//  LaunchDetailViewModel.swift
//  InfoSpaceX
//
//  Created by Sagar Thapa on 11/9/19.
//  Copyright © 2019 Tenhaff. All rights reserved.
//

import Foundation

struct LaunchDetailViewModel {
    
    private var rocket: Launches
    
    init(rocket: Launches) {
        self.rocket = rocket
    }
    
    var getMissionName: String? {
        guard let name = rocket.mission_name else { return nil }
        return "Misson name: \(name)"
    }
    var getLaunchYear: String? {
        guard let launchYear = rocket.launch_year else { return nil }
        return "Launch year: \(launchYear)"
    }
    var getLaunchSuccess: String? {
        guard let success = rocket.launch_success else { return nil }
        var sucs = "No"
        if success {
            sucs = "Yes"
        }
        return "Launch success: \(sucs)"
    }
    
    var getLaunchSite: String? {
        guard let launchSite = rocket.launch_site, let siteName = launchSite.site_name_long else { return nil }
        return "Launch site: \(siteName)"
        
    }
    
    var getLaunchDetails: String? {
        guard let details = rocket.details else { return nil }
        return "Details: \(details)"
    }
    
    var getRocketId: String? {
        return rocket.rocket?.rocket_id
    }
    
    var getSortLaunchYear: Int {
        return rocket.launch_year ?? 0
    }
    var getSortLaunchSuccess: Bool {
        return rocket.launch_success ?? false
    }
    
}


extension LaunchDetailViewModel: HomeViewModelItem {
    var type: LaunchInfoItemType {
        return .launchInfo
    }
    
    var sectionTitle: String {
        return "Launch Info"
    }
    
    var numberOfRows: Int {
        return 1
    }
}
