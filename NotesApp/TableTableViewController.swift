//
//  TableTableViewController.swift
//  NotesApp
//
//  Created by Yuvraj Vijay Agarkar on 21/10/20.
//

import UIKit
var records = [Note]()
class TableTableViewController: UITableViewController {
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        loadManager.load()
        tableView.reloadData()
        
        
    }
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        print("main vc here")
        tableView.reloadData()
    }
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillAppear(animated)
        loadManager.save()
        
    }
    @IBAction func AddTapped(_ sender: UIButton) {
        let addVC = storyboard?.instantiateViewController(identifier: "AddVc") as! AddViewController
        addVC.delegate = self
        present(addVC, animated: true, completion: nil)
    }
//    MARK:- tableView delete
    
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return true
    }
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            records.remove(at: indexPath.row)
            loadManager.save()
            tableView.reloadData()
        }
    }
    
    // MARK: - Table view data source

    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return records.count
    }
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "TableViewCell", for: indexPath) as! TableViewCell
        cell.Label.text = records[indexPath.row].title
        cell.sideLabel.text = records[indexPath.row].date //records[indexPath.row].date
        return cell
    }
    var refNote:Note?
    var indexPATH:Int?
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath
                              , animated: true)
        
//        let detailVC = (storyboard?.instantiateViewController(identifier: "Detail")) as! DetailViewController
//
//        present(detailVC, animated: true, completion: nil)
        refNote = records[indexPath.row]
        indexPATH = indexPath.row
        performSegue(withIdentifier: "toDetail", sender: self)
        
    }
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let destinationVC = segue.destination as! DetailViewController
        destinationVC.slect = refNote
        destinationVC.indexPath = indexPATH
    }
}
extension TableTableViewController:passData{
    func passData(title: String, body: String) {
        let note = Note(title: title, body: body)
        records.append(note)
        tableView.reloadData()
        
    }
    
    
}
