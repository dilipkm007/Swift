//
//  ContentView.swift
//  FetchAJoke
//
//  Created by Dilip Kumar on 2023.06.07.
//

import SwiftUI

struct ContentView: View {
    @State private var joke: String = "Dilip"
    var body: some View {
        Text(joke)
        Button {
            Task {
                let (data, _) = try await URLSession.shared.data(from: URL(string: "https://api.chucknorris.io/jokes/random")!)
                let decodeResponce =  try? JSONDecoder().decode(Joke.self, from: data)
                joke = decodeResponce?.value ?? "Its a joke please laugh"
            }
        }
    label:{
        Text("Fetch Joke")
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

struct Joke: Codable {
    let value: String
}
