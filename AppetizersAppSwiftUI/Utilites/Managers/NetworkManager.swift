//
//  NetworkManager.swift
//  AppetizersAppSwiftUI
//
//  Created by Emirhan İpek on 6.11.2025.
//

import UIKit

final class NetworkManager {
    
    static let shared = NetworkManager()
    private let cache = NSCache<NSString, UIImage>()
    
    static let baseURL = "https://690c9087a6d92d83e84e463d.mockapi.io/api/v1/"
    private let appetizerURL = baseURL + "appetizers"
    
    private init() {}
    
    
    //    func getAppetizers(completed: @escaping (Result<[Appetizer], APError>) -> Void) {
    //        guard let url = URL(string: appetizerURL) else {
    //            completed(.failure(.invalidURL))
    //            return
    //        }
    //
    //        let task = URLSession.shared.dataTask(with: URLRequest(url: url)) { data, response, error in
    //            if let _ = error {
    //                completed(.failure(.unableToComplete))
    //                return
    //            }
    //
    //            guard let response = response as? HTTPURLResponse, response.statusCode == 200 else {
    //                completed(.failure(.invalidResponse))
    //                return
    //            }
    //
    //            guard let data = data else {
    //                completed(.failure(.invalidData))
    //                return
    //            }
    //
    //            do {
    //                let decoder = JSONDecoder()
    //                let decodedResponse = try decoder.decode(AppetizerRespose.self, from: data)
    //                completed(.success(decodedResponse.request))
    //            } catch {
    //                completed(.failure(.invalidData))
    //            }
    //        }
    //
    //        task.resume()
    //    }
        
        func getAppetizers() async throws -> [Appetizer] {
            guard let url = URL(string: appetizerURL) else {
                throw APError.invalidURL
            }
            
            let (data, _) = try await URLSession.shared.data(from: url)
            
            do {
                let decoder = JSONDecoder()
                return try decoder.decode([Appetizer].self, from: data)
            } catch {
                throw APError.invalidData
            }
        }
        
        
        func downloadImage(fromURLString urlString: String, completed: @escaping (UIImage?) -> Void ) {
            
            let cacheKey = NSString(string: urlString)
            
            if let image = cache.object(forKey: cacheKey) {
                completed(image)
                return
            }
            
            guard let url = URL(string: urlString) else {
                completed(nil)
                return
            }
            
            let task = URLSession.shared.dataTask(with: URLRequest(url: url)) { data, response, error in
                
                guard let data, let image = UIImage(data: data) else {
                    completed(nil)
                    return
                }
                
                self.cache.setObject(image, forKey: cacheKey)
                completed(image)
            }
            
            task.resume()
        }
}

// JSON RESPONSE

//[
//  {
//    "name": "Asian Flank Steak",
//    "description": "This perfectly thin cut just melts in your mouth.",
//    "protein": 14,
//    "id": 1,
//    "calories": 300,
//    "price": 8.99,
//    "carbs": 0,
//    "imageURL": "https://ameessavorydish.com/wp-content/uploads/2021/08/Asian-flank-cauli-rice-feature.jpg"
//  },
//  {
//    "name": "Blackened Shrimp",
//    "description": "Seasoned shrimp from the depths of the Atlantic Ocean.",
//    "protein": 4,
//    "id": 2,
//    "calories": 450,
//    "price": 6.99,
//    "carbs": 3,
//    "imageURL": "https://amandascookin.com/wp-content/uploads/2022/07/Blackened-Shrimp-RCSQ.jpg"
//  },
//  {
//    "name": "Buffalo Chicken Bites",
//    "description": "The tasty bites of chicken have just the right amount of kick to them.",
//    "protein": 5,
//    "id": 3,
//    "calories": 800,
//    "price": 7.49,
//    "carbs": 22,
//    "imageURL": "https://www.southernliving.com/thmb/jliuzEpgkCjktLSk7uWpo8G9sJU=/1500x0/filters:no_upscale():max_bytes(150000):strip_icc()/Buffalo-Chicken-Bites_3x4_269-90ea5fd31b01446ab1a690aaab8d8df1.jpg"
//  },
//  {
//    "name": "Garlic Parmesan Knots",
//    "description": "Warm dough knots tossed in garlic butter and parmesan.",
//    "protein": 6,
//    "id": 4,
//    "calories": 410,
//    "price": 4.99,
//    "carbs": 28,
//    "imageURL": "https://www.thecomfortofcooking.com/wp-content/uploads/2014/03/12-720x720.jpg"
//  },
//  {
//    "name": "Honey Garlic Wings",
//    "description": "Crispy wings glazed with a sweet and garlicky sauce.",
//    "protein": 15,
//    "id": 5,
//    "calories": 620,
//    "price": 9.49,
//    "carbs": 12,
//    "imageURL": "https://recipeteacher.com/wp-content/uploads/2024/06/Best-Damn-Air-Fryer-Honey-Garlic-Wings-feature.jpg"
//  },
//  {
//    "name": "Teriyaki Tofu Bites",
//    "description": "Pan-seared tofu tossed in a classic teriyaki reduction.",
//    "protein": 9,
//    "id": 6,
//    "calories": 350,
//    "price": 5.99,
//    "carbs": 18,
//    "imageURL": "https://thewoksoflife.com/wp-content/uploads/2018/01/teriyaki-tofu-3-1.jpg"
//  },
//  {
//    "name": "Spicy Tuna Tartare",
//    "description": "Diced tuna with sesame, scallions and a chili kick.",
//    "protein": 13,
//    "id": 7,
//    "calories": 280,
//    "price": 10.99,
//    "carbs": 2,
//    "imageURL": "https://images.getrecipekit.com/20221102171125-spicy-20tuna-20tartare-20main-20image.jpg?aspect_ratio=1:1&quality=90&"
//  },
//  {
//    "name": "Avocado Lime Dip",
//    "description": "Creamy avocado blended with fresh lime and cilantro.",
//    "protein": 3,
//    "id": 8,
//    "calories": 240,
//    "price": 4.49,
//    "carbs": 6,
//    "imageURL": "https://www.idratherbeachef.com/wp-content/uploads/2024/04/avocado-lime-crema-featured-image.jpg"
//  },
//  {
//    "name": "Crispy Calamari",
//    "description": "Lightly breaded squid rings with lemon aioli.",
//    "protein": 12,
//    "id": 9,
//    "calories": 540,
//    "price": 8.49,
//    "carbs": 20,
//    "imageURL": "https://getfish.com.au/cdn/shop/articles/Step_3_-_Calamari.png?v=1721972259"
//  },
//  {
//    "name": "Truffle Fries",
//    "description": "Hand-cut fries finished with truffle oil and herbs.",
//    "protein": 4,
//    "id": 10,
//    "calories": 520,
//    "price": 6.49,
//    "carbs": 48,
//    "imageURL": "https://www.billyparisi.com/wp-content/uploads/2018/05/truffle-fries-featured.jpg"
//  },
//  {
//    "name": "Caprese Skewers",
//    "description": "Tomato, mozzarella and basil with a balsamic drizzle.",
//    "protein": 7,
//    "id": 11,
//    "calories": 260,
//    "price": 5.49,
//    "carbs": 8,
//    "imageURL": "https://umamiology.com/wp-content/uploads/2024/06/Umamiology-Caprese-Skewers-RecipeCard1.jpg"
//  },
//  {
//    "name": "BBQ Pulled Pork Sliders",
//    "description": "Mini brioche buns stacked with slow-cooked pork and slaw.",
//    "protein": 18,
//    "id": 12,
//    "calories": 700,
//    "price": 9.99,
//    "carbs": 35,
//    "imageURL": "https://cdn.craftbeer.com/wp-content/uploads/Breakfast-Stout-BBQ-Pulled-Pork-Sliders.jpg"
//  },
//  {
//    "name": "Veggie Spring Rolls",
//    "description": "Crisp rolls packed with seasonal vegetables and herbs.",
//    "protein": 5,
//    "id": 13,
//    "calories": 300,
//    "price": 5.29,
//    "carbs": 32,
//    "imageURL": "https://amycaseycooks.com/wp-content/uploads/2016/02/Webp.net-resizeimage-2021-01-30T193616.712.jpg"
//  }
//]
