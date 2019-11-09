//
//  RocketViewModel.swift
//  InfoSpaceX
//
//  Created by Sagar Thapa on 11/9/19.
//  Copyright © 2019 Tenhaff. All rights reserved.
//

import Foundation

struct RocketViewModel {
    
    private var rocket: Rocket
    init(rocket: Rocket) {
        self.rocket = rocket
    }
    
    var getRocketName: String? {
        guard let rocketName = rocket.rocket_name else { return nil }
        return "Rocket name: \(rocketName)"
    }
    var getRocketType: String? {
        guard let rocketType = rocket.rocket_type else { return nil }
        return "Rocket type: \(rocketType)"
    }
    var getRocketFirstFlight: String? {
        guard let firstFlght = rocket.first_flight else { return nil }
        return "First flight: \(firstFlght)"
    }
    var getRocketCountry: String? {
        guard let country = rocket.country else { return nil }
        return "Country: \(country)"
    }
    var getRocketCompany: String? {
        guard let company = rocket.company else { return nil }
        return "Company: \(company)"
    }
    var getRocketHeight: String? {
        guard let height = rocket.height, let hgt = height.feet else { return nil }
        return "Height: \(hgt) feet"
    }
    var getRocketDiameter: String? {
        guard let diameter = rocket.diameter, let feet = diameter.feet else { return nil }
        return "Diameter: \(feet) feet"
    }
    var getRocketMass: String? {
        guard let mass = rocket.mass, let kg = mass.kg else { return nil }
        return "Mass: \(kg) kg"
    }
    var getRocketEngineType: String? {
        guard let engine = rocket.engines,let type = engine.type else { return nil }
        return "Type: \(type)"
    }
    var getRocketEngineVersion: String? {
        guard let engine = rocket.engines,let version = engine.version else { return nil }
        return "Version: \(version)"
    }
    var getRocketEngineLayout: String? {
        guard let engine = rocket.engines,let layout = engine.layout else { return nil }
        return "Layout: \(layout)"
    }
    var getRocketEnginePropellOne: String? {
        guard let engine = rocket.engines,let propellant_1 = engine.propellant_1 else { return nil }
        return "Propellant one: \(propellant_1)"
    }
    var getRocketEnginePropellTwo: String? {
        guard let engine = rocket.engines,let propellant_2 = engine.propellant_2 else { return nil }
        return "Propellant two: \(propellant_2)"
    }
    var getRocketDescription: String? {
        guard let description = rocket.description else {return nil}
        return "Description: \(description)"
    }
    var getRocketWikipedia: NSMutableAttributedString? {
        guard let wikipedia = rocket.wikipedia else { return nil }
        let finalString = NSMutableAttributedString(string: "Wikipedia: ")
        
        let attributedString = NSMutableAttributedString(string: wikipedia)
        attributedString.addAttribute( NSAttributedString.Key.underlineStyle,
                                       value: 1,
                                       range: NSRange(location: 0,
                                                      length: attributedString.length))
        
        finalString.append(attributedString)
        return finalString
    }
    
    var getWikipediaUrl: URL? {
        guard let wikipedia = rocket.wikipedia else { return nil }
        return URL(string: wikipedia)
    }
}

extension RocketViewModel: HomeViewModelItem {
    var type: LaunchInfoItemType {
        return .rocketInfo
    }
    
    var sectionTitle: String {
        return "Rocket Info"
    }
    
    var numberOfRows: Int {
        return 1
    }
    
}

