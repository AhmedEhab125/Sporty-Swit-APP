//
//  LagueTableViewController.swift
//  Sporty
//
//  Created by ahmed on 20/05/2023.
//

import UIKit
import Kingfisher
protocol leaguesProtocol {
    func setLeagues(list : [CountryData])
    
}
class LagueTableViewController: UITableViewController,leaguesProtocol,UISearchBarDelegate {
    @IBOutlet weak var searchBar: UISearchBar!
    func setLeagues(list: [CountryData]) {
        leagueslist = list
        filterList = list
        self.tableView.reloadData()
    }
    var leaguesPresenter : LeaguesPresenter!
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        filterList = leagueslist
        if !searchText.isEmpty{
            filterList = filterList.filter { filteration in
                filteration.countryName.contains(searchText)
                
            }
        }
        tableView.reloadData()

    }

    var leagueslist,filterList : [CountryData]!

    override func viewDidLoad() {
        super.viewDidLoad()
        leagueslist = []
        filterList = leagueslist
        leaguesPresenter = LeaguesPresenter(leagueProtocol: self)
        leaguesPresenter.showLeagues()
        
        self.tableView.register(UINib(nibName: "LagueTableViewCell", bundle: nil), forCellReuseIdentifier: "Cell")
        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return filterList.count
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath) as! LagueTableViewCell
        
        cell.lagueName.text = filterList[indexPath.row].countryName
        
        let url = URL(string: filterList[indexPath.row].countryLogo ?? "" )
        let processor = DownsamplingImageProcessor(size: cell.lagueImg.bounds.size)
                     |> RoundCornerImageProcessor(cornerRadius: 20)
        cell.lagueImg.kf.indicatorType = .activity
        cell.lagueImg.kf.setImage(
            with: url,
            placeholder: UIImage(named: "placeholderImage"),
            options: [
                .processor(processor),
                .scaleFactor(UIScreen.main.scale),
                .transition(.fade(1)),
                .cacheOriginalImage
            ])
        
        
        
        
        // Configure the cell...
        cell.lagueImg.layer.cornerRadius = cell.lagueImg.frame.size.width / 2
        cell.lagueImg.clipsToBounds = true

        return cell
    }
    

    /*
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

    /*
    // Override to support rearranging the table view.
    override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
