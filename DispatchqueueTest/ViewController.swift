//
//  ViewController.swift
//  DispatchqueueTest
//
//  Created by Yuki Shinohara on 2020/07/05.
//  Copyright © 2020 Yuki Shinohara. All rights reserved.
//

import UIKit
import Alamofire
import SwiftyJSON

class ViewController: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    
    var dataArray = [TestData]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        getData()
    }
    
    func getData(){
        let urlString = "https://jsonplaceholder.typicode.com/posts"
        guard let url = URL(string: urlString) else {return}
        
        AF.request(url).responseJSON { [weak self](response) in
            let data = JSON(response.value as Any)
            let tempArray = data.arrayValue
            
            for element in tempArray{
                let id = element["id"].intValue
                let title = element["title"].stringValue
                let body = element["body"].stringValue
                let data = TestData(id: id, title: title, body: body)
                self?.dataArray.append(data)
            }
            
            DispatchQueue.main.async {
                self?.tableView.reloadData()
                self?.view.backgroundColor = .systemBlue
            }
        }

    }


}

extension ViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return dataArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        cell.textLabel?.text = dataArray[indexPath.row].title
        return cell
    }
    
    
}
