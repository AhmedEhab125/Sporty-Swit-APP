//
//  ClubDataViewController.swift
//  Sporty
//
//  Created by ahmed on 24/05/2023.
//

import UIKit
import Kingfisher
class ClubDataViewController: UIViewController,UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout,TeamDataProtocol {
    
    
    var clubData : TeamData?
    var clubPresenter :ClubDataPresenter!
    var sport :String!
    var teamId : String?
    var clubState = ""
    let networkIndicator=UIActivityIndicatorView(style: .large)
    
    @IBOutlet weak var facBtnImg: UIButton!
    @IBOutlet weak var teamName: UILabel!
    @IBOutlet weak var clubImg: UIImageView!
    @IBOutlet weak var teamCollectionview: UICollectionView!
    func getTeamData(teamData: TeamData?) {
        if teamData != nil{
            clubState = "In Favourite"
            clubData = teamData
            setImg(img: clubImg, url: clubData?.teamLogo ?? "")
            teamName.text = clubData?.teamName
            self.teamCollectionview.reloadData()
            clubImg.isHidden = false
            
        }
        self.networkIndicator.stopAnimating()
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let appDeleate = UIApplication.shared.delegate as! AppDelegate

        clubPresenter = ClubDataPresenter(network: NetworkServise.getInstance,showTeamData: self,database: ClubDataBase.getInstance(appDeleate: appDeleate))
        teamCollectionview.register(UINib(nibName: "TeamPlayersCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "teamPlayerCell")
        
        if clubData != nil{
            setImg(img: clubImg, url: clubData?.teamLogo ?? "")
            teamName.text = clubData?.teamName
            
        }else{
            initNetworkIndicator()
            clubImg.isHidden = true
            facBtnImg.isHidden = true
            clubPresenter.getTeamData(teamId: teamId ?? "0" ,sport: sport)
            
        }
        // Do any additional setup after loading the view.
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return clubData?.players?.count ?? 0
    }
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "teamPlayerCell", for: indexPath) as! TeamPlayersCollectionViewCell
        cell.playerName.text = clubData?.players?[indexPath.row].playerName
        setImg(img: cell.playerImg, url: clubData?.players?[indexPath.row].playerImage ?? "")
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
    
    @IBAction func addtoFavBtn(_ sender: UIButton) {
        if (clubState.elementsEqual("In Favourite")){
            
        }else{
            self.facBtnImg.setImage(UIImage(systemName: "heart.fill"), for: .normal)
            clubPresenter.addTeamToDB( id: clubData?.teamKey ?? 0, name: clubData?.teamName ?? "", img: (clubImg.image?.jpegData(compressionQuality: 1.0))!, sport: sport)
            
        }
    }
    func initNetworkIndicator(){
        networkIndicator.center = view.center
        networkIndicator.color = UIColor.blue
        networkIndicator.startAnimating()
        view.addSubview(networkIndicator)
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
