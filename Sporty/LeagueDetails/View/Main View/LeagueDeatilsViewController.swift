//
//  LeagueDeatilsViewController.swift
//  Sporty
//
//  Created by ahmed on 23/05/2023.
//

import UIKit

class LeagueDeatilsViewController: UIViewController,UICollectionViewDelegate,UICollectionViewDataSource,UITableViewDelegate, UITableViewDataSource {
    @IBOutlet weak var teamsCollectionView: UICollectionView!
    @IBOutlet weak var mstchresultTable: UITableView!
    @IBOutlet weak var collectionView: UICollectionView!

    
    override func viewDidLoad() {
        super.viewDidLoad()
       
       
        let layout = UICollectionViewCompositionalLayout{
            index, environment in
            return self.drawComingEventSecotion()
            }
        self.collectionView.setCollectionViewLayout(layout, animated: true)
        collectionView.register(UINib(nibName: "ComingEvenCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "comeingEventCell")
        // Do any additional setup after loading the view.
    }
  
  
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        1
    }
    func numberOfSections(in tableView: UITableView) -> Int {
        9
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "matchResulttableCell", for: indexPath) as! GameResultTableViewCell
        cell.awayTeamName.text = "ahmed"
        return cell
    }
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        1
    }
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        5
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if collectionView == self.collectionView{
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "comeingEventCell", for: indexPath) as! ComingEvenCollectionViewCell
        
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
                .fractionalWidth(1), heightDimension: .fractionalHeight (1))
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
    
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
