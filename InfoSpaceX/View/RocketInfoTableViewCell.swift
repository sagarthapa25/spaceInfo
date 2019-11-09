//
//  RocketInfoTableViewCell.swift
//  InfoSpaceX
//
//  Created by Sagar Thapa on 11/9/19.
//  Copyright © 2019 Tenhaff. All rights reserved.
//

import UIKit

protocol RocketInfoTableViewCellDelegate {
    func viewWikipediaTapped()
}


class RocketInfoTableViewCell: UITableViewCell {
    
    @IBOutlet weak var rocketNameLbl: UILabel!
    @IBOutlet weak var rocketTypeLbl: UILabel!
    @IBOutlet weak var rocketFirstFlgtLbl: UILabel!
    @IBOutlet weak var rocketCountryLbl: UILabel!
    @IBOutlet weak var rocketCompanyLbl: UILabel!
    @IBOutlet weak var rocketHeightLbl: UILabel!
    @IBOutlet weak var rocketDiameterLbl: UILabel!
    @IBOutlet weak var rocketMassLbl: UILabel!
    @IBOutlet weak var rocketEngineTypeLbl: UILabel!
    @IBOutlet weak var rocketEngineVersionLbl: UILabel!
    @IBOutlet weak var rocketEngineLayoutLbl: UILabel!
    @IBOutlet weak var rocketEnginePropellantOneLbl: UILabel!
    @IBOutlet weak var rocketEnginePropellantTwoLbl: UILabel!
    @IBOutlet weak var rocketDescriptionLbl: UILabel!
    @IBOutlet weak var rocketWikipediaLbl: UILabel!{
        didSet {
            rocketWikipediaLbl.isUserInteractionEnabled = true
            let tapGesture = UITapGestureRecognizer(target: self, action: #selector(wikipediaTapped(_:)))
            tapGesture.numberOfTapsRequired = 1
            tapGesture.numberOfTouchesRequired = 1
            rocketWikipediaLbl.addGestureRecognizer(tapGesture)
        }
    }
    
   
    
    static var identifier: String {
        return String(describing: self)
    }
    
    static var nib: UINib {
        return UINib(nibName: identifier, bundle: nil)
    }
    
    var delegate:RocketInfoTableViewCellDelegate?
    
    var model: HomeViewModelItem? {
        didSet {
            guard let model = model as? RocketViewModel else { return }
            self.setUpRocket(name: model.getRocketName, type: model.getRocketType, firstFlight: model.getRocketFirstFlight, country: model.getRocketCountry, company: model.getRocketCompany, height: model.getRocketHeight, diameter: model.getRocketDiameter, mass: model.getRocketMass, engineType: model.getRocketEngineType, version: model.getRocketEngineVersion, layout: model.getRocketEngineLayout, propellant1: model.getRocketEnginePropellOne, propellant2: model.getRocketEnginePropellTwo, description: model.getRocketDescription, wikipedia: model.getRocketWikipedia)
            
        }
    }

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    private func setUpRocket(name: String?, type: String?, firstFlight: String?, country: String?, company: String?, height: String?, diameter: String?, mass: String?, engineType: String?, version: String?, layout: String?, propellant1: String?, propellant2: String?, description: String?, wikipedia: NSAttributedString?) {
        
        rocketNameLbl.text = name
        rocketTypeLbl.text = type
        rocketFirstFlgtLbl.text = firstFlight
        rocketCountryLbl.text = country
        rocketCompanyLbl.text = company
        rocketHeightLbl.text = height
        rocketDiameterLbl.text = diameter
        rocketMassLbl.text = mass
        
        rocketEngineTypeLbl.text = engineType
        rocketEngineVersionLbl.text = version
        rocketEngineLayoutLbl.text = layout
        rocketEnginePropellantOneLbl.text = propellant1
        rocketEnginePropellantTwoLbl.text = propellant2
        
        rocketDescriptionLbl.text = description
        rocketWikipediaLbl.attributedText = wikipedia
    }
    
    @objc func wikipediaTapped(_ sender: UITapGestureRecognizer) {
        self.delegate?.viewWikipediaTapped()
    }
}
