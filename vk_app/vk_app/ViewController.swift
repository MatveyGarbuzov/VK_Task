//
//  ViewController.swift
//  vk_app
//
//  Created by Matvey Garbuzov on 14.07.2022.
//

import UIKit

class ViewController: UIViewController, UITableViewDelegate, UITableViewDataSource  {
    var listOfApps: ListOfApps?
    
    private let tableView: UITableView = {
        let table = UITableView(frame: .zero, style: .grouped)
        table.register(
            CustomTableViewCell.self,
            forCellReuseIdentifier: CustomTableViewCell.identifier
        )
        
        return table
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        parseJSON()
        
        view.addSubview(tableView)
        tableView.frame = view.bounds
        tableView.delegate = self
        tableView.dataSource = self
        tableView.backgroundColor = .bg
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return listOfApps?.body.services.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if let url = URL(string: listOfApps?.body.services[indexPath.section].link ?? "") {
            if indexPath.section == 1 || indexPath.section == 4 || indexPath.section == 5 { // Sorry za rickroll
                let url = URL(string: "https://www.youtube.com/watch?v=dQw4w9WgXcQ")!
                UIApplication.shared.open(url)
            } else {
                UIApplication.shared.open(url)
            }
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let model = listOfApps?.body.services[indexPath.section]
        guard let cell = tableView.dequeueReusableCell(withIdentifier: CustomTableViewCell.identifier, for: indexPath) as? CustomTableViewCell else {
            return UITableViewCell()
        }

        cell.configure(
            text: model?.name ?? "unknown app",
            description: model?.description ?? "unknown description",
            link: model?.link ?? "",
            icon_url: model?.icon_url ?? ""
        )
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 75
    }
    
    
    func parseJSON() {
        let urlString = "https://publicstorage.hb.bizmrg.com/sirius/result.json"
        let url = URL(string: urlString)
        
        guard url != nil else { return }
        
        let session = URLSession.shared
        
        let dataTask = session.dataTask(with: url!) { [self] (data, response, error) in
            // Check for errors
            if error == nil && data != nil {
                // Parse JSON
                let decoder = JSONDecoder()
                
                do {
                    listOfApps = try decoder.decode(ListOfApps.self, from: data!)
                    print(listOfApps as Any)
                } catch {
                    print("Error in JSON parsing")
                }
                
            }
        }
        dataTask.resume()
    }
}


