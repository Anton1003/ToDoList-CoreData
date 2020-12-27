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
    var daysAlam: [Daily] = []// создаем массив значений для отображения в таблице
    var categoryAlam: WeatherCategory?// через переменную получаем доступ к значениям для декодирования
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        reloadTableView()// при наличии сохранненых данных выгружаем их в таблицу до поступления новых данных
        
        WeatherCategoriesLoader().loadWeatherCategories { category in//парсим новые данные
            self.categoryAlam = category// получаем данные для лейблов хедера
            self.daysAlam = category.daily//получаем данные для лейблов таблицы
            self.AlamTableView.reloadData()// обновляем таблицу
          }
        }

    func reloadTableView() {
     if let data = UserDefaults.standard.object(forKey: "DATA") as? Data {// при наличии сохранненых данных получаем и из БД
       let category = try! JSONDecoder().decode(WeatherCategory.self, from: data)// декодируем полученные данные
        print("Done")
       self.categoryAlam = category// получаем данные для лейблов хедера
       self.daysAlam = category.daily//получаем данные для лейблов таблицы
       self.AlamTableView.reloadData()// обновляем таблицу
     }
    }
}


extension AlamofireViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
     
        return daysAlam.count
        // количество строк в таблице
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "AlamCell") as! AlamWeatherCell
        // задаем путь к каждой созданной ячейке
        let model = daysAlam[indexPath.row]// задаем значения из полученного массива
        cell.dayTempAlamLabel.text = "\(model.temp.day )"
        cell.nightTempAlamLabel.text = "\(model.temp.night)"
        cell.dateAlamLabel.text = "\(model.date)"
        return cell// создаем ячейку и задаем значения лейблов в ячейке
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        guard let category = categoryAlam else {return nil} // получаем в хедер значение категорий
        let view = UIView() // создаем вью в хедере
       
        view.backgroundColor = .lightGray// задаем цыет хедера
        let dayTempAlamLabel = UILabel()
        let nightTempAlamLabel = UILabel()// создаем лейблы в хедере
        let dateAlamLabel = UILabel()
         if let day = category.daily.first { // получаем первый элемент массива категорий
            dayTempAlamLabel.text = "\(day.temp.day)" // задаем значение лейблов полученных при парсинге
            nightTempAlamLabel.text = "\(day.temp.night)"
         }
        if category.timezone.first != nil {
            dateAlamLabel.text = category.timezone // задаем значение места так же из первого элемента массива
        }
        dayTempAlamLabel.textAlignment = .center
        nightTempAlamLabel.textAlignment = .center // задаем расположение текста по центру
        dateAlamLabel.textAlignment = .center
         let stack = UIStackView(arrangedSubviews: [dateAlamLabel, dayTempAlamLabel, nightTempAlamLabel])// создаем стэквью и добавляем в него лейблы через массив
        stack.axis = .vertical// задаем вертикальное расположение лейблов в стэквью
        view.addSubview(stack)// добавляем стэквью на экран
        stack.translatesAutoresizingMaskIntoConstraints = false// отключаем авторесайзинг
        stack.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
        stack.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true// задаем констрейты для размещения стэквью по центру

                return view

        
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 200 // высота хедера
    }
}
