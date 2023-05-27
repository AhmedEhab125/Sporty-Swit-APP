//
//  FavouriteTeamsTableViewController.swift
//  Sporty
//
//  Created by ahmed on 26/05/2023.
//

import UIKit

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

        presenter = FavouriteTeamsPresenter(favTeams: self)
        presenter.getFavouriteTeams(appDelegat: appDeleate)
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
            cell.lagueImg.image = UIImage(data: teamList[indexPath.row].img)
        // Configure the cell...

        return cell
    }
    override func viewWillAppear(_ animated: Bool) {
        let appDeleate = UIApplication.shared.delegate as! AppDelegate
        presenter.getFavouriteTeams(appDelegat: appDeleate)
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
            self.presenter.deleteFromFavourite(appDelegat: appDeleate, team: indexPath.row)
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
