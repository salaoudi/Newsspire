//
//  ContentView.swift
//  newsspire
//
//  Created by Zayn on 10/14/21.
//

import SwiftUI
import CoreData
import SwiftyJSON
import SDWebImage
import SDWebImageSwiftUI


struct ContentView: View {
    
    @ObservedObject var newsList = getData()
    
    //    var layout = [GridItem(.flexible())]
    var layout = [GridItem(.adaptive(minimum: 300, maximum: 700))]
    
    
    var body: some View {
        
        
        
        ScrollView(.vertical) {
            ZStack {
                VStack {
                    LazyVGrid(columns: layout) {
                        
                        ForEach(newsList.news) { getNews in
                            VStack {
                                VStack {
                                    WebImage(url: URL(string: getNews.image), options: .highPriority, context: nil)
                                        .resizable()
                                        .aspectRatio(contentMode: .fit)
                                        .overlay(
                                            VStack {
                                                Spacer()
                                                HStack {
                                                    Text(getNews.title)
                                                        .foregroundColor(Color.white)
                                                        .font(.system(size: 20, weight: .bold, design: .rounded))
                                                        .shadow(color: Color.black.opacity(0.9), radius: 5, x: 0, y: 0)
                                                    Spacer()
                                                }.padding()
                                            }
                                        )
                                    
                                }
                                
                                .background(Color.white)
                                .cornerRadius(20)
                                .shadow(color: Color.black.opacity(0.5), radius: 8, x: 0, y: 0)
                            }
                            .frame(maxHeight: 500)
                            .padding()
                            
                            
                        }
                        
                    }
                }.padding(.top, 220)
                
                GeometryReader { geo in
                    VStack {
                        HStack {
                            
                               Rectangle()
                                .fill(Color.primary)
                                .frame(height:self.calculateHeight(minHeight: 100,maxHeight: 220, yOffset: geo.frame(in: .global).origin.y))
                                .cornerRadius(50)
                                .overlay(
                                    HStack {
                                        VStack(alignment: .leading) {
                                            Text("newsspire")
                                                .foregroundColor(Color.white)
                                                .font(.system(size: 55, weight: .bold, design: .rounded))
                                                .kerning(-3)
                                                .padding(.horizontal)
                                                .padding(.top, 70)
                                                .shadow(color: Color.black.opacity(0.9), radius: 8, x: 0, y: 0)
                                            Text("Top Headlines")
                                                .kerning(2)
                                                .foregroundColor(Color.white)
                                                .font(.system(size: 35, weight: .thin, design: .rounded))
                                                .padding(.horizontal)
                                                .padding(.vertical, 5)
                                        }
                                        Spacer()
                                    }
                                    
                                    
                                    
                                )
                        }
                        .offset(y: geo.frame(in: .global).origin.y < 0 // Is it going up?
                                    ? abs(geo.frame(in: .global).origin.y) // Push it down!
                                    : -geo.frame(in: .global).origin.y) // Push it up!
                        
                        
                        
                        
                        
                        Spacer()
                    }
                    
                    
                    
                    
                }
                
                
                
            }
            
            
            
        }.edgesIgnoringSafeArea(.vertical)
        
        
        
        
        
        
        
        
        
        
    }
    
    func calculateHeight(minHeight: CGFloat, maxHeight: CGFloat, yOffset: CGFloat) -> CGFloat {
        // If scrolling up, yOffset will be a negative number
        if maxHeight + yOffset < minHeight {
            // SCROLLING UP
            // Never go smaller than our minimum height
            return minHeight
        }
        
        // SCROLLING DOWN
        return maxHeight + yOffset
    }
    
}




struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView().environment(\.managedObjectContext, PersistenceController.preview.container.viewContext)
    }
}


