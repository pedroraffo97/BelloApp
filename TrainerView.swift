//
//  TrainerView.swift
//  BelloApp
//
//  Created by Pedro Raffo Leon on 18.11.23.
//

import Foundation

import SwiftUI

struct TrainerView: View {
    
    @State var prompt: String = ""
    @State var GPTresponse: String = ""
    
    func fetchData() {
        
        guard let url = URL(string: "https://api.openai.com/v1/chat/completions") else {return}
        
        var request = URLRequest(url:url)
        request.httpMethod = "POST"
        // Set headers and parameters as needed
        request.setValue("OpenAIAPIKey", forHTTPHeaderField: "Authorization")
        // Include the user's prompt in the request body
        let requestBody = ["prompt": prompt]
        request .httpBody = try? JSONSerialization.data(withJSONObject: requestBody)
        URLSession.shared.dataTask(with: request) {
            data, response, error in
            if let data = data {
                if let decodedResponse = try? JSONDecoder().decode(ResponseModel.self, from: data) {
                    self.GPTresponse = decodedResponse.message
                }
            }
        }.resume()
    }

    var body: some View {
        VStack{
        Text("Ask Anything to your trainer").font(.headline)
                .padding()
        //Textfield for user input
        TextField("Enter your prompt", text: $prompt)
            .padding()
            .textFieldStyle(RoundedBorderTextFieldStyle())
            
        //Button to trigger the API Request
        Button("Enter"){
                fetchData()
            }
                .padding()
                            
        //Display the API response
        Text(GPTresponse)
                .padding()
        }
                .padding()
    }
}

struct ResponseModel: Decodable {
                                let message: String
                            }

struct TrainerView_previews: PreviewProvider {
    static var previews: some View {
        TrainerView()
    }
}
