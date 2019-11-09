//
//  Rocket.swift
//  InfoSpaceX
//
//  Created by Sagar Thapa on 11/9/19.
//  Copyright © 2019 Tenhaff. All rights reserved.
//

import Foundation

struct Rocket: Decodable {
    let first_flight: String?
    let country: String?
    let company: String?
    let height: Height?
    let diameter: Diameter?
    let mass: Mass?
    let engines: Engines?
    let wikipedia: String?
    let description: String?
    let rocket_name: String?
    let rocket_type: String?
    
    struct Height: Decodable {
        let meters: Double?
        let feet: Double?
    }
    
    struct Diameter:Decodable {
        let meters: Double?
        let feet: Double?
    }
    
    struct Mass: Decodable{
        let kg: Double?
        let lb: Double?
    }
    
    struct Engines:Decodable {
        
        let type: String?
        let version: String?
        let layout: String?
        
        let propellant_1: String?
        let propellant_2: String?
        
    }
    
}

