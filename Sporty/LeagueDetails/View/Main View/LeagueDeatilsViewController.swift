//
//  LeagueDeatilsViewController.swift
//  Sporty
//
//  Created by ahmed on 23/05/2023.
//

import UIKit
import Kingfisher

class LeagueDeatilsViewController: UIViewController,UICollectionViewDelegate,UICollectionViewDataSource
                                ,UITableViewDelegate, UITableViewDataSource
                                ,ShowComingEventProtocol ,LeagueScoreProtocol{
 
    
    var eventList ,leagueScoreList:[ComeEventData]!
    var leagueId,sport :String!
    var presenter : LeagueDetailsPresenter!
 
    
    @IBOutlet weak var teamsCollectionView: UICollectionView!
    @IBOutlet weak var mstchresultTable: UITableView!
    @IBOutlet weak var collectionView: UICollectionView!
    
    func showEvents(eventList: [ComeEventData]) {
        self.eventList=eventList
        self.collectionView.reloadData()
    }
    func getLeagueScores(scorelist: [ComeEventData]) {
        leagueScoreList = scorelist
        self.mstchresultTable.reloadData()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        leagueScoreList = []
       eventList = []
        presenter = LeagueDetailsPresenter(comingEvent: self,leagueScore: self)
        presenter.getEvents(sport: sport,leagueId: leagueId)
        presenter.getScores(sport: sport, leagueId: leagueId)
        let layout = UICollectionViewCompositionalLayout{
            index, environment in
            return self.drawComingEventSecotion()
            }
        self.collectionView.setCollectionViewLayout(layout, animated: true)
        collectionView.register(UINib(nibName: "ComingEvenCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "comeingEventCell")
        // Do any additional setup after loading the view.
    }
  
  
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    func numberOfSections(in tableView: UITableView) -> Int {
        return leagueScoreList.count
    }
    var count = 0
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {

        let cell = tableView.dequeueReusableCell(withIdentifier: "matchResulttableCell", for: indexPath) as! GameResultTableViewCell
        if count < leagueScoreList.count{
            cell.awayTeamName.text = leagueScoreList[count].eventAwayTeam
            cell.homeTeamName.text = leagueScoreList[count].eventHomeTeam
            
            cell.gameDate.text = leagueScoreList[count].eventDate
            cell.gameScore.text =  leagueScoreList[count].eventFinalResult
            
            self.setImg(img: cell.awayTeamImg, url: leagueScoreList[count].awayTeamLogo ?? "")
            self.setImg(img: cell.homeTeamImg, url: leagueScoreList[count].homeTeamLogo ?? "")
            count = count + 1
        }
        return cell
    }
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        1
    }
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if collectionView == self.collectionView{
            return eventList.count
        }
        return 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if collectionView == self.collectionView{
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "comeingEventCell", for: indexPath) as! ComingEvenCollectionViewCell
            cell.awayTeamName.text = eventList[eventList.count-1-indexPath.row].eventAwayTeam
            cell.homeTeamName.text = eventList[eventList.count-1-indexPath.row].eventHomeTeam
            cell.eventDate.text =  eventList[eventList.count-1-indexPath.row].eventDate
            cell.eventTime.text = eventList[eventList.count-1-indexPath.row].eventTime
            
            setImg(img: cell.AwayTeamImg, url: eventList[eventList.count-1-indexPath.row].awayTeamLogo ?? "")
            
            setImg(img: cell.homeTeamImg, url: eventList[eventList.count-1-indexPath.row].homeTeamLogo ?? "")

            return cell
            
        }
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "teamsCell", for: indexPath) as! TeamesCollectionViewCell
    
        return cell
        
    }
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        if let sectionHeader = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: "SectionHeader", for: indexPath) as? HeaderCollectionReusableView{
            sectionHeader.sectionHeader.text = "Comming Eventes"
            return sectionHeader
        }
        return UICollectionReusableView()
    }
    

   
    
    func  drawComingEventSecotion() -> NSCollectionLayoutSection{
        let itemSize = NSCollectionLayoutSize (widthDimension:
                .fractionalWidth(1), heightDimension: .estimated(200))
        let item = NSCollectionLayoutItem(layoutSize: itemSize)
      let groupSize = NSCollectionLayoutSize (widthDimension:
            .fractionalWidth(1), heightDimension: .fractionalHeight (1))
        let group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize, subitems: [item])
        group.contentInsets = NSDirectionalEdgeInsets (top: 0, leading:
        0, bottom: 0, trailing: 0)
        
        let section = NSCollectionLayoutSection(group: group)
        section.orthogonalScrollingBehavior = .groupPaging
        section.contentInsets = NSDirectionalEdgeInsets(top: 0,
        leading: 0, bottom: 0, trailing: 0)
        let footerHeaderSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0),heightDimension: .absolute(50.0))
                    let header = NSCollectionLayoutBoundarySupplementaryItem(
                        layoutSize: footerHeaderSize,
                        elementKind: UICollectionView.elementKindSectionHeader,
                        alignment: .top)
        section.boundarySupplementaryItems = [header]
        return section
    }
    func  drawResultusSecotion() -> NSCollectionLayoutSection{
        let itemSize = NSCollectionLayoutSize (widthDimension:
                .fractionalWidth(1), heightDimension: .fractionalHeight (1))
        let item = NSCollectionLayoutItem(layoutSize: itemSize)
        
      let groupSize = NSCollectionLayoutSize (widthDimension:
            .fractionalWidth(1), heightDimension: .fractionalHeight (0.1))
        let group = NSCollectionLayoutGroup.vertical(layoutSize: groupSize, subitems: [item])
        group.contentInsets = NSDirectionalEdgeInsets (top: 5, leading:
        0, bottom: 0, trailing: 32)
        
        let section = NSCollectionLayoutSection(group: group)
        section.accessibilityScroll(UIAccessibilityScrollDirection.down)
        section.contentInsets = NSDirectionalEdgeInsets(top: 5,
        leading: 16, bottom: 16, trailing: 0)
    
        
        let footerHeaderSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0),heightDimension: .absolute(50.0))
                    let header = NSCollectionLayoutBoundarySupplementaryItem(
                        layoutSize: footerHeaderSize,
                        elementKind: UICollectionView.elementKindSectionHeader,
                        alignment: .top)
        section.boundarySupplementaryItems = [header]
                
        return section
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
