//
//  ViewController.swift
//  Moya_Demo
//
//  Created by Huy on 7/23/20.
//  Copyright © 2020 nhn. All rights reserved.
//

import UIKit
import Moya

class ViewController: UIViewController, UITableViewDataSource {
    
    @IBOutlet weak var tableView: UITableView!
    var users = [User]()
    let userProvider = MoyaProvider<UserService>()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.dataSource = self
        
        userProvider.request(.readUsers) { (result) in
            switch result {
            case .success(let response):
//                let json = try! JSONSerialization.jsonObject(with: response.data, options: [])
//                print(json)
                let users = try! JSONDecoder().decode([User].self, from: response.data)
                self.users = users
                self.tableView.reloadData()
            case .failure(let error):
                print(error)
            }
        }
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return users.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        
        let user = users[indexPath.row]
        cell.textLabel?.text = user.name
        cell.detailTextLabel?.text = String(user.id)
        
        return cell
    }
}

