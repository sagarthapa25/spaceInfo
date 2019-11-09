//
//  Launces.swift
//  InfoSpaceX
//
//  Created by Sagar Thapa on 11/8/19.
//  Copyright © 2019 Tenhaff. All rights reserved.
//

import Foundation

struct Launches: Decodable {
    let mission_name: String?
    let launch_year: Int?
    let launch_success: Bool?
    let launch_site: LaunchSite?
    let rocket: Rocket?
    let details: String?
    
    enum RootKeys: String, CodingKey {
        case mission_name, launch_year, launch_success, details,launch_site, rocket
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: RootKeys.self)
        mission_name = try container.decodeIfPresent(String?.self, forKey: .mission_name) ?? nil
        let year = try container.decodeIfPresent(String?.self, forKey: .launch_year) ?? nil
        if let year = year {
            launch_year = Int(year)
        }else {
            launch_year = nil
        }
        launch_success = try container.decodeIfPresent(Bool?.self, forKey: .launch_success) ?? nil
        details = try container.decodeIfPresent(String?.self, forKey: .details) ?? nil
        launch_site = try container.decodeIfPresent(LaunchSite?.self, forKey: .launch_site) ?? nil
        rocket = try container.decodeIfPresent(Rocket?.self, forKey: .rocket) ?? nil
        
    }
    
    struct LaunchSite: Decodable {
        let site_name_long: String?
    }
    struct Rocket: Decodable {
        let rocket_id: String?
    }
}
