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
,ShowComingEventProtocol ,LeagueScoreProtocol,TeamsProtocol{
  
    
 
    private var indicatorCounter : Int!
    private var eventList ,leagueScoreList:[ComeEventData]!
    private  var teamlist : [TeamData]!
    var leagueId,sport :String!
    private var presenter : LeagueDetailsPresenter!
    private let teamsNetworkIndicator = UIActivityIndicatorView(style: .large)


 
    
    @IBOutlet weak var teamsCollectionView: UICollectionView!
    @IBOutlet weak var mstchresultTable: UITableView!
    @IBOutlet weak var collectionView: UICollectionView!
    
    func showEvents(eventList: [ComeEventData]) {
        self.eventList=eventList
        if eventList.isEmpty{
            let temp = ComeEventData()
            temp.eventKey = -1
            temp.eventTime = "Not Avilable"
            self.eventList.append(temp)
         //   self.collectionView.isHidden = true
        }
        self.collectionView.reloadData()
        indicatorCounter+=1
        if indicatorCounter == 3{
            teamsNetworkIndicator.stopAnimating()
        }
    }
    func getLeagueScores(scorelist: [ComeEventData]) {
        leagueScoreList = scorelist
        if leagueScoreList.isEmpty{
            let temp = ComeEventData()
            temp.eventKey = -1
            temp.eventTime = "Not Avilable"
            leagueScoreList.append(temp)
        }
        self.mstchresultTable.reloadData()
        indicatorCounter+=1
        if indicatorCounter == 3{
            teamsNetworkIndicator.stopAnimating()
        }
    }
    func getTeams(teamList: [TeamData]) {
        self.teamlist = teamList
        if teamList.isEmpty{
            self.teamsCollectionView.isHidden = true
        }
        self.teamsCollectionView.reloadData()
        indicatorCounter+=1
        if indicatorCounter == 3{
            teamsNetworkIndicator.stopAnimating()
        }
    }
    
    override func viewDidLoad() {
        indicatorCounter = 0
        super.viewDidLoad()
        teamlist = []
        leagueScoreList = []
       eventList = []
        presenter = LeagueDetailsPresenter(comingEvent: self,leagueScore: self,teams: self)
        presenter.getEvents(sport: sport,leagueId: leagueId)
        presenter.getScores(sport: sport, leagueId: leagueId)
        presenter.getTeams(sport: sport, leagueId: leagueId)
        initNetworkIndicator()
        let layout = UICollectionViewCompositionalLayout{
            index, environment in
            return self.drawComingEventSecotion()
            }
        self.collectionView.setCollectionViewLayout(layout, animated: true)
        collectionView.register(UINib(nibName: "ComingEvenCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "comeingEventCell")
        // Do any additional setup after loading the view.
    }
    func initNetworkIndicator(){
        teamsNetworkIndicator.center = view.center
        teamsNetworkIndicator.color = UIColor.blue
        teamsNetworkIndicator.startAnimating()
        self.view.addSubview(teamsNetworkIndicator)
        
        
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
            if leagueScoreList[0].eventKey != -1{
                cell.awayTeamName.text = leagueScoreList[count].eventAwayTeam
                cell.homeTeamName.text = leagueScoreList[count].eventHomeTeam
                
                cell.gameDate.text = leagueScoreList[count].eventDate
                cell.gameScore.text =  leagueScoreList[count].eventFinalResult
                
                self.setImg(img: cell.awayTeamImg, url: leagueScoreList[count].awayTeamLogo ?? "")
                self.setImg(img: cell.homeTeamImg, url: leagueScoreList[count].homeTeamLogo ?? "")
                
            }else{
                cell.gameScore.text = "Not Avilable"
                cell.awayTeamImg.isHidden = true
                cell.awayTeamName.isHidden = true
                cell.gameDate.isHidden = true
                cell.homeTeamImg.isHidden = true
                cell.homeTeamName.isHidden = true
            }
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
        return teamlist.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if collectionView == self.collectionView{
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "comeingEventCell", for: indexPath) as! ComingEvenCollectionViewCell
            if eventList[0].eventKey != -1{
                cell.awayTeamName.text = eventList[eventList.count-1-indexPath.row].eventAwayTeam
                cell.homeTeamName.text = eventList[eventList.count-1-indexPath.row].eventHomeTeam
                cell.eventDate.text =  eventList[eventList.count-1-indexPath.row].eventDate
                cell.eventTime.text = eventList[eventList.count-1-indexPath.row].eventTime
                
                setImg(img: cell.AwayTeamImg, url: eventList[eventList.count-1-indexPath.row].awayTeamLogo ?? "")
                
                setImg(img: cell.homeTeamImg, url: eventList[eventList.count-1-indexPath.row].homeTeamLogo ?? "")
                
            }else{
                cell.AwayTeamImg.isHidden = true
                cell.homeTeamImg.isHidden = true
                cell.awayTeamName.isHidden = true
                cell.homeTeamName.isHidden = true
                cell.eventTime.isHidden = true
                cell.eventStadium.isHidden = true

                cell.eventDate.text = eventList[0].eventTime
              

            }

            return cell
            
        }
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "teamsCell", for: indexPath) as! TeamesCollectionViewCell
        setImg(img: cell.teamImg, url:teamlist[indexPath.row].teamLogo ?? "")
        cell.teamName.text = teamlist[indexPath.row].teamName
        return cell
        
    }
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        if let sectionHeader = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: "SectionHeader", for: indexPath) as? HeaderCollectionReusableView{
            sectionHeader.sectionHeader.text = "Comming Eventes"
            return sectionHeader
        }
        return UICollectionReusableView()
    }
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if collectionView == teamsCollectionView{
            var nav : ClubDataViewController = self.storyboard?.instantiateViewController(withIdentifier: "ClubDataViewController") as! ClubDataViewController
            nav.clubData = teamlist[indexPath.row]
            nav.sport = sport
            self.navigationController?.pushViewController(nav, animated: true)
        }
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
