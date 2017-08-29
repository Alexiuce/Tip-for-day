//
//  ViewController.swift
//  XCWebook
//
//  Created by alexiuce  on 2017/8/14.
//  Copyright © 2017年 alexiuce . All rights reserved.
//

import UIKit
import Alamofire


let baseHTML = "http://www.22ff.com"
let targetPage = "/xs/167580/"

class ViewController: UIViewController {
    
    lazy var regexHelper : RegexTool = {
        let regex = RegexTool()
        regex.delegate = self
        return regex
    }()
    

    lazy var divModels = [DIVModel]()
    
    
    @IBOutlet weak var tableView: UITableView!
 
    
    override func viewDidLoad() {
        super.viewDidLoad()
        hidesBottomBarWhenPushed = true
        
    Alamofire.request(baseHTML + targetPage).response { (response) in
        
        guard let result = response.data else {return}
        
        let encode = CFStringConvertEncodingToNSStringEncoding(CFStringEncoding(CFStringEncodings.GB_18030_2000.rawValue))
        
        guard let text = String(data: result, encoding: String.Encoding(rawValue: UInt(encode))) else {return}
    
        let pattern = "<div class=\"clc\">.*?</div>"
        self.regexHelper.matchString(inText: text, pattern: pattern)
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
    }

}

extension ViewController : RegexToolProcotol {

    func regexFinished(_ result: [String]) {
        for div in result {
            let model = DIVModel(div: div)
            divModels.append(model)
        }
        tableView.reloadData()
    }

}

extension ViewController : UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return divModels.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        var cell = tableView.dequeueReusableCell(withIdentifier: "webook")
        if cell == nil {
            cell = UITableViewCell(style: .default, reuseIdentifier: "webook")
        }
        
        cell?.textLabel?.text = divModels[indexPath.row].text
        return cell!
    }
    
}

extension ViewController : UITableViewDelegate{
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let detailVC = DetailViewController()
        detailVC.loadUrl = baseHTML + divModels[indexPath.row].href
        detailVC.title = divModels[indexPath.row].text
        
        navigationController?.pushViewController(detailVC, animated: true)
    }
}


