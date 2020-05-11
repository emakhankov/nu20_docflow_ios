//
//  NevworkService.swift
//  DocFlow
//
//  Created by Evgeny Makhankov on 11.05.2020.
//  Copyright © 2020 Evgeny Makhankov. All rights reserved.
//


import Foundation

//typealias onApiSuccess = (Todos) -> Void

class NetworkService {
    static let shared = NetworkService()
    
    let URL_BASE = "http://194.67.108.5/docflow/api"
    let URL_SHOW_TASKS = "/tasks"
    
    let session = URLSession(configuration: .default)
    
    //  func getTodos(onSuccess: @escaping onApiSuccess, onError @escaping (String) -> Void )
    func getTasks(onSuccess: @escaping ([DocFlowTask]) -> Void, onError: @escaping (String) -> Void )
    {
        let url = URL(string: "\(URL_BASE)\(URL_SHOW_TASKS)")!
        
        let task = session.dataTask(with: url) { (data, response, error) in
            
            DispatchQueue.main.async {
                
                if let error = error {
                    onError(error.localizedDescription)
                    return
                }
                
                guard let data = data, let response = response as? HTTPURLResponse else {
                    onError("Invalid data or response")
                    return
                }
                
                do {
                    if response.statusCode == 200 {
                        
                        //let tagsArray = try container.decode([Tag].self, forKey: .tags)
                        //tags = List(tagsArray) // Now you are good
                        
                        let items = try JSONDecoder().decode([DocFlowTask].self, from: data)
                        onSuccess(items)
                    }
                    else
                    {
                        let err = try JSONDecoder().decode(APIError.self, from: data)
                        onError(err.message)
                    }
                    
                }
                catch {
                    onError(error.localizedDescription)
                }
            }
            
            
        }
        task.resume()
    }
    
    
    
}
