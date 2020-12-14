//
//  AlamofireViewController.swift
//  модуль 12
//
//  Created by User on 08.10.2020.
//  Copyright © 2020 User. All rights reserved.
//

import UIKit

class AlamofireViewController: UIViewController {

    @IBOutlet weak var AlamTableView: UITableView!
    var daysAlam: [Daily] = []
    var categoryAlam: WeatherCategory?
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        reloadTableView()

        WeatherCategoriesLoader2().loadWeatherCategories2 { success in
        if success {
        self.AlamTableView.reloadData()
                }
            }
        }

    func reloadTableView() {
     if let data = UserDefaults.standard.object(forKey: "DATA") as? Data {
       let category = try! JSONDecoder().decode(WeatherCategory.self, from: data)
        print("Done")
       self.categoryAlam = category
       self.daysAlam = category.daily
       self.AlamTableView.reloadData()
     }
    }
}


extension AlamofireViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
     
        return daysAlam.count
        
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "AlamCell") as! AlamWeatherCell
        
        let model = daysAlam[indexPath.row]
        cell.dayTempAlamLabel.text = "\(model.temp.day )"
        cell.nightTempAlamLabel.text = "\(model.temp.night)"
        cell.dateAlamLabel.text = "\(model.date)"
        return cell
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        guard let category = categoryAlam else {return nil}
        let view = UIView()
       
        view.backgroundColor = .lightGray
        let dayTempAlamLabel = UILabel()
        let nightTempAlamLabel = UILabel()
        let dateAlamLabel = UILabel()
         if let day = category.daily.first {
            dayTempAlamLabel.text = "\(day.temp.day)"
            nightTempAlamLabel.text = "\(day.temp.night)"
         }
        if category.timezone.first != nil {
            dateAlamLabel.text = category.timezone
        }
        dayTempAlamLabel.textAlignment = .center
        nightTempAlamLabel.textAlignment = .center
        dateAlamLabel.textAlignment = .center
         let stack = UIStackView(arrangedSubviews: [dateAlamLabel, dayTempAlamLabel, nightTempAlamLabel])
        stack.axis = .vertical
        view.addSubview(stack)
        stack.translatesAutoresizingMaskIntoConstraints = false
        stack.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
        stack.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true

                return view

        
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 300
    }
}
