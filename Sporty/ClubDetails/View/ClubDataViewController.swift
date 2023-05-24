//
//  ClubDataViewController.swift
//  Sporty
//
//  Created by ahmed on 24/05/2023.
//

import UIKit
import Kingfisher
class ClubDataViewController: UIViewController,UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout {
   
    
    var clubData : TeamData!
    @IBOutlet weak var teamName: UILabel!
    @IBOutlet weak var clubImg: UIImageView!
    
    @IBOutlet weak var teamCollectionview: UICollectionView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setImg(img: clubImg, url: clubData.teamLogo)
        teamCollectionview.register(UINib(nibName: "TeamPlayersCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "teamPlayerCell")
        teamName.text = clubData.teamName
        // Do any additional setup after loading the view.
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return clubData.players.count
    }
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "teamPlayerCell", for: indexPath) as! TeamPlayersCollectionViewCell
        cell.playerName.text = clubData.players[indexPath.row].playerName
        setImg(img: cell.playerImg, url: clubData.players[indexPath.row].playerImage ?? "")
        return cell
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        return CGSize(width: collectionView.bounds.width*0.48, height: collectionView.bounds.height*0.34)
    }
    
    
    func setImg(img :UIImageView , url :String){
        let processor = DownsamplingImageProcessor(size: img.bounds.size)
                     |> RoundCornerImageProcessor(cornerRadius: 20)
        img.kf.indicatorType = .activity
        
        img.kf.setImage(with: URL(string: url),
            placeholder: UIImage(named: "noimg1"),
            options: [
                .processor(processor),
                .scaleFactor(UIScreen.main.scale),
                .transition(.fade(1)),
                .cacheOriginalImage
            ])
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
