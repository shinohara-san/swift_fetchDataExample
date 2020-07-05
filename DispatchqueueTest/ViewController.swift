//
//  ViewController.swift
//  DispatchqueueTest
//
//  Created by Yuki Shinohara on 2020/07/05.
//  Copyright © 2020 Yuki Shinohara. All rights reserved.
//

import UIKit

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
       
        let task = URLSession.shared.dataTask(with: url) { [weak self](data, response, error) in
            if let error = error {
                print(error)
                return
            }
            
            guard let data = data else {return}
            let decoder = JSONDecoder()
            let tempArray = try? decoder.decode([TestData].self, from: data)
            guard let unwrappedArray = tempArray else {return}
            
            self?.dataArray = unwrappedArray
            
            DispatchQueue.main.async {
                self?.tableView.reloadData()
            }
        }
        task.resume()
        
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
