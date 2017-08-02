//
//  TableViewController.swift
//  SingleDataFlowDemo
//
//  Created by alexiuce  on 2017/8/2.
//  Copyright © 2017年 alexiuce . All rights reserved.
//

import UIKit

class TableViewController: UITableViewController {
    
    enum Section : Int {
        case input = 0, todos, max
    }
    
    var todos : [String] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        ToDoStore.shareStore.getToDoItems { (data) in
            self.todos += data
            self.title = "TODO - \(self.todos.count)"
            self.tableView.reloadData()
        }
        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem()
    }

    
    @IBAction func addButtonClicked(_ sender: UIBarButtonItem) {
        let inputPath = IndexPath(row: 0, section: Section.input.rawValue)
        guard let inputCell = tableView.cellForRow(at: inputPath) as? TableViewInputCell, let text = inputCell.textFiled.text else {
            return
        }
        todos.insert(text, at: 0)
        inputCell.textFiled.text = ""
        
        sender.isEnabled = false
        title = "TODO - \(todos.count)"
        let insertPath = IndexPath(row: 0, section: Section.todos.rawValue)
        tableView.insertRows(at: [insertPath], with: .top)
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return Section.max.rawValue
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        guard let section = Section.init(rawValue: section) else {
            fatalError()
        }
        switch section {
        case .input: return 1
        case .todos : return todos.count
        case .max : fatalError()
        }
        return 0
    }


    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        guard let section = Section.init(rawValue: indexPath.section) else {
            fatalError()
        }
        switch section {
        case .input:  // reture input cell
            let cell = tableView.dequeueReusableCell(withIdentifier: "InputReused", for: indexPath) as! TableViewInputCell
            cell.delegate = self
            return cell
        
        case .todos:  // normal cell
            let cell = tableView.dequeueReusableCell(withIdentifier: "reuseIdentifier", for: indexPath)
            cell.textLabel?.text = todos[indexPath.row]
            return cell
            
        default:
            fatalError()
        }
    }
 


    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        if indexPath.section == Section.input.rawValue {
            return false
        }
        return true
    }


    
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            todos.remove(at: indexPath.row)
            tableView.deleteRows(at: [indexPath], with: .bottom)
            title = "TODO - \(todos.count)"
        }
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
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}

extension TableViewController : TableViewInputCellDelegate{
    func inputChanged(cell: TableViewInputCell, text: String) {
        let itemLengthEngouth = text.characters.count > 3
        navigationItem.rightBarButtonItem?.isEnabled = itemLengthEngouth
    }
}

