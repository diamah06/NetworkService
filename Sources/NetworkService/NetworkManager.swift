//
//  NetworkManager.swift
//  JokeAPI
//
//  Created by Mahdia Amriou on 30/03/2023.
//

import Foundation

@available(macOS 12.0, *)
@available(iOS 15.0, *)
struct NetworkManager {
    
   
    func fetch<Anything: Codable>(from urlString: String) async throws -> Anything {
        
// construire l'URL à partir de la chaîne d'URL passée à l'aide d'une instruction de gard.
        guard let url = URL(string: urlString) else  {
            throw URLError(.badURL)
        }
//     appel sur l'instance URLSession.URLSession.Shared.data(from:) returns a tuple with data and response. We will create a variable to hold those values.
        let (data, response) = try await URLSession.shared.data(from: url)
        
//we need to make sure that the response code from the API is correct. The HTTP 200 OK success status response code indicates that the request has succeeded so we will check the status code from response using guard statement.
        guard (response as? HTTPURLResponse)?.statusCode == 200 else {
            throw URLError(.badServerResponse)
        }
//Next step is to decode our downloaded data into an object. We will take JSONDecoder’s help to decode data into the object.
        let result = try JSONDecoder().decode(Anything.self, from: data)
        
        return result
    }
}
    
    
    
    
    
    

