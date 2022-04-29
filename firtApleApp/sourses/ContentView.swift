//
//  ContentView.swift
//  firtApleApp
//
//  Created by shegida on 28.04.2022.
//

import SwiftUI
import CoreData

public var testData = "dada";

struct ContentView: View {
    @State var changingState = "testState"
    
    @Environment(\.managedObjectContext) private var viewContext
    
    @FetchRequest(
        sortDescriptors: [NSSortDescriptor(keyPath: \Item.timestamp, ascending: true)],
        animation: .default)
    private var items: FetchedResults<Item>
    
    
    
    
    var body: some View {
        
        
        VStack {
            HStack {
                NavigationView {
                    VStack {
                        Button(changingState, action: changeText)
                        
                        NavigationLink(
                            destination: SecondScreen(), label: {
                                Text("nextPageButton")
                                
                            }
                        )
                        Button("NetworkButton", action: getData)
                            .accessibilityLabel(/*@START_MENU_TOKEN@*/"Label"/*@END_MENU_TOKEN@*/)
                    }.navigationTitle("home")
                }
            }
        }
    }
    
    private func changeText(){
        changingState = "pushedState"
    }
    
    public func getData(){
        let url2 = "https://api.sunrise-sunset.org/json?lat=36.7201600&lng=-4.4203400"
        let url = URL(string: url2)!
        
        let task = URLSession.shared.dataTask(with: url) {(data, response, error) in
            guard let data = data else { return }
            
            var result: Responce?
            do {
                result = try JSONDecoder().decode(Responce.self, from: data)
            }
            catch {
                print("error")
            }
            
            changingState = result?.results.sunrise ?? "fail"
            
        }
        
        task.resume()
    }
}


struct SecondScreen : View{
    var body: some View {
        VStack {
            Text("second")
        }
    }
}


struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView().environment(\.managedObjectContext, PersistenceController.preview.container.viewContext)
    }
}


struct SunsetInfo: Decodable {
    let sunrise: String
    let sunset: String
}


struct Responce: Decodable {
    let results: SunsetInfo
    let status: String
}

