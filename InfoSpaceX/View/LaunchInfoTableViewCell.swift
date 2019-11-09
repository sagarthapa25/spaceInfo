//
//  LaunchInfoTableViewCell.swift
//  InfoSpaceX
//
//  Created by Sagar Thapa on 11/8/19.
//  Copyright © 2019 Tenhaff. All rights reserved.
//

import UIKit

class LaunchInfoTableViewCell: UITableViewCell {
    @IBOutlet weak var missionNameLbl: UILabel!
    @IBOutlet weak var launchYearLbl: UILabel!
    @IBOutlet weak var launchSiteLbl: UILabel!
    @IBOutlet weak var launchSuccessLbl: UILabel!
    @IBOutlet weak var launchDetailLbl: UILabel!
    
    var model:HomeViewModelItem?{
        didSet {
            guard let model = model as? LaunchDetailViewModel else { return  }
            self.setUp(missonName: model.getMissionName, launchYear: model.getLaunchYear, launchSite: model.getLaunchSite, launchSuccess: model.getLaunchSuccess, launchDetail: model.getLaunchDetails)
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
    
    private func setUp(missonName: String?, launchYear: String?, launchSite: String?, launchSuccess: String?, launchDetail: String?) {
        missionNameLbl.text = missonName
        launchYearLbl.text = launchYear
        launchSiteLbl.text = launchSite
        launchSuccessLbl.text = launchSuccess
        launchDetailLbl.text = launchDetail
    }
    
}
