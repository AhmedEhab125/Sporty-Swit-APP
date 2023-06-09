//
//  FavouriteTeamsTableViewController.swift
//  Sporty
//
//  Created by ahmed on 26/05/2023.
//

import UIKit
import Alamofire
class FavouriteTeamsTableViewController: UITableViewController
,FavouritTeamsProtocol{
    var teamList : [FavouritTeamModel]!
    var presenter :FavouriteTeamsPresenter!
    func showTeams(list: [FavouritTeamModel]) {
        teamList = list
        tableView.reloadData()
    }
    

    override func viewDidLoad() {
        super.viewDidLoad()
        teamList = []
        let appDeleate = UIApplication.shared.delegate as! AppDelegate

        presenter = FavouriteTeamsPresenter(favTeams: self,database: ClubDataBase.getInstance(appDeleate: appDeleate))
        presenter.getFavouriteTeams()
        self.tableView.register(UINib(nibName: "LagueTableViewCell", bundle: nil), forCellReuseIdentifier: "Cell")
        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

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
        return teamList.count
    }

        override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath) as! LagueTableViewCell
            cell.lagueName.text = teamList[indexPath.row].name
            cell.lagueImg.image = UIImage(data: teamList[indexPath.row].img ?? Data())
        // Configure the cell...

        return cell
    }
    override func viewWillAppear(_ animated: Bool) {
        let appDeleate = UIApplication.shared.delegate as! AppDelegate
        presenter.getFavouriteTeams()
    }
    

    /*
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

  
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            showNoNetworkAlert(indexPath: indexPath)
            
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    func showNoNetworkAlert(indexPath : IndexPath){
        let alertController = UIAlertController(title: "Delete Confirmation", message: "Are you sure you want to delete ?", preferredStyle: .alert)

        let okAction = UIAlertAction(title: "Delete", style: .default) { (action) in
            let appDeleate = UIApplication.shared.delegate as! AppDelegate

            // Handle OK button tap action
            self.presenter.deleteFromFavourite( team: indexPath.row)
            self.teamList.remove(at: indexPath.row)
            self.tableView.deleteRows(at: [indexPath], with: .fade)
        }
        let caneleAction = UIAlertAction(title: "canele", style: .default) { (action) in
            // Handle OK button tap action
        }
        alertController.addAction(caneleAction)
        alertController.addAction(okAction)
        present(alertController, animated: true, completion: nil)
    }
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let manager = NetworkReachabilityManager(host: "www.apple.com")
        if ((manager!.isReachable)) {
            var nav : ClubDataViewController = self.storyboard?.instantiateViewController(withIdentifier: "ClubDataViewController") as! ClubDataViewController
            nav.sport = self.teamList[indexPath.row].sport
            nav.teamId = String(Int(self.teamList[indexPath.row].id ?? 0))
            self.navigationController?.pushViewController(nav, animated: true)
            
        }else{
            showNoNetworkAlert()
        }
    }
    func showNoNetworkAlert(){
        let alertController = UIAlertController(title: "No Internet", message: "No Internet Connection", preferredStyle: .alert)

        let okAction = UIAlertAction(title: "OK", style: .default) { (action) in
            // Handle OK button tap action
        }
        alertController.addAction(okAction)
        present(alertController, animated: true, completion: nil)
    }
    

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
