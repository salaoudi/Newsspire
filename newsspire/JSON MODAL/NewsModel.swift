//
//  NewsModel.swift
//  newsspire
//
//  Created by Zayn on 10/14/21.
//

import Foundation
import SwiftUI
import SwiftyJSON

struct NewsModel: Identifiable {
    
    var id : String
    var title : String
    var author : String
    var description : String
    var url : String
    var image : String
    
}




class getData: ObservableObject {
    
    @Published var news = [NewsModel]()
    
    init() {
        
        
        let source = "https://newsapi.org/v2/top-headlines?country=ar&apiKey=c97a42e9821243998696552a32020e56"
        let url = URL(string: source)!
        let session = URLSession(configuration: .default)
        session.dataTask(with: url) { (data, _, err) in
            if err != nil {
                print((err?.localizedDescription)!)
                return
            }
            
            let json = try! JSON(data: data!)
            
            for s in json["articles"] {
                let id = s.1["publishedAt"].stringValue
                let title = s.1["title"].stringValue
                let author = s.1["author"].stringValue
                let description = s.1["description"].stringValue
                let url = s.1["url"].stringValue
                let image = s.1["urlToImage"].stringValue
               
                DispatchQueue.main.async {
                    self.news.append(NewsModel(id: id, title: title, author: author, description: description, url: url, image: image))
                }
               
            
            }
        }.resume()
        
        
        
        
    }
    
}
