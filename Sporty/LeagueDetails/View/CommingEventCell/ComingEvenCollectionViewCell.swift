//
//  ComingEvenCollectionViewCell.swift
//  Sporty
//
//  Created by ahmed on 23/05/2023.
//

import UIKit

class ComingEvenCollectionViewCell: UICollectionViewCell {
    @IBOutlet weak var homeTeamImg: UIImageView!
    @IBOutlet weak var homeTeamName: UILabel!
 
    @IBOutlet weak var eventStadium: UILabel!
    @IBOutlet weak var eventTime: UILabel!
    @IBOutlet weak var eventDate: UILabel!
    
    @IBOutlet weak var AwayTeamImg: UIImageView!

    @IBOutlet weak var awayTeamName: UILabel!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

}
