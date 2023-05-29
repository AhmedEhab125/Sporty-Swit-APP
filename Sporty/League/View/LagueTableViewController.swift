//
//  LagueTableViewController.swift
//  Sporty
//
//  Created by ahmed on 20/05/2023.
//

import UIKit
import Kingfisher
import Alamofire
protocol leaguesProtocol {
    func setLeagues(list : [LeaguesData])
    
}
class LagueTableViewController: UITableViewController,leaguesProtocol,UISearchBarDelegate {
    var sport : String!
    @IBOutlet weak var searchBar: UISearchBar!
    let networkIndicator=UIActivityIndicatorView(style: .large)
    func setLeagues(list: [LeaguesData]) {
        setCashData(list: list)
        leagueslist = list
        filterList = list
        self.tableView.reloadData()
        self.networkIndicator.stopAnimating()
    }
    var leaguesPresenter : LeaguesPresenter!
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        filterList = leagueslist
        if !searchText.isEmpty{
            filterList = filterList.filter { filteration in
                filteration.leagueName.contains(searchText)
            }
        }
        tableView.reloadData()

    }

    var leagueslist,filterList : [LeaguesData]!

    override func viewDidLoad() {
        
        super.viewDidLoad()
        let manager = NetworkReachabilityManager(host: "www.apple.com")
        if ((manager!.isReachable)) {
            initNetworkIndicator()
            leagueslist = []
            filterList = leagueslist
            tableView.reloadData()
            leaguesPresenter = LeaguesPresenter(leagueProtocol: self,network: NetworkServise.getInstance)
            leaguesPresenter.showLeagues(sport: sport)
        }else{
            
            showNoNetworkAlert()
            getCashedData()
            
        }
        
        
        
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
        
        cell.lagueName.text = filterList[indexPath.row].leagueName
        
        let url = URL(string: filterList[indexPath.row].leagueLogo ?? "" )
        let processor = DownsamplingImageProcessor(size: cell.lagueImg.bounds.size)
                     |> RoundCornerImageProcessor(cornerRadius: 20)
        cell.lagueImg.kf.indicatorType = .activity
        cell.lagueImg.kf.setImage(
            with: url,
            placeholder: UIImage(named: "noimg1"),
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
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let manager = NetworkReachabilityManager(host: "www.apple.com")
        if ((manager!.isReachable)) {
            var nav : LeagueDeatilsViewController = self.storyboard?.instantiateViewController(withIdentifier: "LeagueDeatilsViewController") as! LeagueDeatilsViewController
            nav.leagueId = String(filterList[indexPath.row].leagueKey)
            nav.sport = self.sport
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
    func setCashData(list : [LeaguesData]){
        let encoder = JSONEncoder()
        if let encoded = try? encoder.encode(list) {

            // Save the encoded data object into UserDefaults
            let defaults = UserDefaults.standard
            defaults.set(encoded, forKey: sport)
            print("saved")
        }
    }
    func initNetworkIndicator(){
        networkIndicator.center = view.center
        networkIndicator.color = UIColor.blue
        networkIndicator.startAnimating()
        view.addSubview(networkIndicator)
    }
    
    func getCashedData(){
        let defaults = UserDefaults.standard
        if let savedData = defaults.object(forKey: sport) as? Data {
            let decoder = JSONDecoder()
            
            // Decode the data object back into a list of objects
            if let loadedObjects = try? decoder.decode([LeaguesData].self, from: savedData) {
                leagueslist = loadedObjects
                filterList = loadedObjects
                tableView.reloadData()
            }
        }
    }
    override func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        cell.transform = CGAffineTransform(scaleX: 0.2, y: 0.8)
        UIView.animate(withDuration: 0.5, delay: 0.0, options: [.curveEaseOut], animations: {
            cell.transform = CGAffineTransform.identity
        }, completion: nil)
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
