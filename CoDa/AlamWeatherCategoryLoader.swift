
import Foundation
import Alamofire

class WeatherCategoriesLoader2 {
    func loadWeatherCategories2(completion: @escaping (Bool) -> Void){
        AF.request("https://api.openweathermap.org/data/2.5/onecall?lat=55.75222&lon=37.615555&exclude=current,minutely,hourly,alerts&units=metric&appid=026cd65550ddf6923b003c41597ed98e").responseData { data in
            UserDefaults.standard.setValue(data.data, forKey: "DATA")
            print("Save")
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
                completion(true)
            }
        }
//            .responseDecodable(of: WeatherCategory.self) {response in
//            switch response.result {
//            case .success(let data):
//
//            completion(data)
//
//            case .failure:
//                print("Error")
//            }
     //   }
   }
}

//func reload(){
//
//    if let data = UserDefaults.standard.data(forKey: "Saved") {
//        let loaded = try? JSONDecoder().decode(Daily.self, from: data)
//        print(loaded)
//    }
//}
