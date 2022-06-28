//
//  Networking.swift
//  Colormind
//
//  Created by Amin  Bagheri  on 2022-06-27.
//

import Foundation

class Networking {
    
    static let shared = Networking()
    
    func getPalette(mode: String, hex: String, count: Int, completion: @escaping (Result<Scheme, Error>) -> Void) {
        
     let urlString = "https://www.thecolorapi.com/scheme?hex=\(hex)&mode=\(mode)&count=\(count)"
        guard let url = URL(string: urlString) else {
            print("Problem converting urlString to type URL")
            return
        }
        print("THIS IS THE FULL URL: \(urlString)")
        
        let task = URLSession.shared.dataTask(with: URLRequest(url: url)) { data, _, error in
            guard let data = data, error == nil else {
                print("Either there was no data form the url, or we recieved an error.")
                return
            }
            let decoder = JSONDecoder()
            do {
                let decodedScheme = try decoder.decode(Scheme.self, from: data)
                completion(.success(decodedScheme))
            } catch(let error) {
                print("Error decoding data: \n\(error)")
                completion(.failure(error))
            }
            
            
            
        }.resume()
    }
}
