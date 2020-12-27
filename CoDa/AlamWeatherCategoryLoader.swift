
import Foundation
import Alamofire

class WeatherCategoriesLoader {
    func loadWeatherCategories(completion: @escaping (WeatherCategory) -> Void){// в запросе в параметр получаем значения прописанных структур и соотвтетственно ключи по которым будет формироваться запрос
        AF.request("https://api.openweathermap.org/data/2.5/onecall?lat=55.75222&lon=37.615555&exclude=current,minutely,hourly,alerts&units=metric&appid=026cd65550ddf6923b003c41597ed98e").responseDecodable(of: WeatherCategory.self) {response in // по адресу запрашиваем данные и декодируем их
            switch response.result {// получаем результаты запроса
            case .success(let category):
                UserDefaults.standard.setValue(response.data, forKey: "DATA")// если данные успешно получены сохраняем их в ЮД
                completion(category)
            case .failure:
                print("Error")// если нет в логе отображантся ошибка
            }
        }
   }
}

