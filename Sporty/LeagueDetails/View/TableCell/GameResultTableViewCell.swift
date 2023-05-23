//
//  GameResultTableViewCell.swift
//  Pods
//
//  Created by ahmed on 23/05/2023.
//

import UIKit

class GameResultTableViewCell: UITableViewCell {

    @IBOutlet weak var awayTeamName: UILabel!
    @IBOutlet weak var awayTeamImg: UIImageView!
    @IBOutlet weak var gameDate: UILabel!
    @IBOutlet weak var gameScore: UILabel!
    @IBOutlet weak var homeTeamName: UILabel!
    @IBOutlet weak var homeTeamImg: UIImageView!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
