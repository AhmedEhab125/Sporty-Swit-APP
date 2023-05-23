//
//  LagueTableViewCell.swift
//  Sporty
//
//  Created by ahmed on 20/05/2023.
//

import UIKit

class LagueTableViewCell: UITableViewCell {

    @IBOutlet weak var lagueName: UILabel!
    @IBOutlet weak var lagueImg: UIImageView!
    override func awakeFromNib() {
        super.awakeFromNib()
        
        // Initialization code
        
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
