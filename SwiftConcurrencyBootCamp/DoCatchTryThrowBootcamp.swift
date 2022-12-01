//
//  DoCatchTryThrowBootcamp.swift
//  SwiftConcurrencyBootCamp
//
//  Created by Nunu Nugraha on 29/11/22.
//

import SwiftUI

class DoCatchTryThrowBootcampManager {
     
    let isActive: Bool = false
    
    func getTitle() -> (title: String?, error: Error?) {
        if isActive {
            return ("New Text...", nil)
        } else {
            return (nil, URLError(.badURL))
        }
        
    }
    
    func getTitle2() -> Result<String, Error> {
        if isActive {
            return .success("New Text...")
        } else {
            return .failure(URLError(.appTransportSecurityRequiresSecureConnection))
        }
    }
    
    func getTitle3() throws -> String {
        if isActive {
            return "New Text no error..."
        } else {
            throw URLError(.badServerResponse)
        }
    }
}

class DoCatchTryThrowBootcampViewModel: ObservableObject {
    
    @Published var text: String = "Starting text..."
    let manager = DoCatchTryThrowBootcampManager()
    
    func fetchTitle() {
        /*
        let getReturnTitle = manager.getTitle()
        if let newTitle = getReturnTitle.title {
            self.text = newTitle
        } else if let error = getReturnTitle.error {
            self.text = error.localizedDescription
        }
         */
        
        /*
        let result = manager.getTitle2()
        switch result {
        case .success(let newTitle):
            self.text = newTitle
        case .failure(let error):
            self.text = error.localizedDescription
        }
        */
        
        
        do {
            let result = try manager.getTitle3()
            self.text = result
        } catch let error {
            self.text = error.localizedDescription
        }
        
    }
    
}

struct DoCatchTryThrowBootcamp: View {
    
    @StateObject private var viewModel = DoCatchTryThrowBootcampViewModel()
    
    var body: some View {
        Text(viewModel.text)
            .frame(width: 300, height: 300)
            .background(Color.blue)
            .onTapGesture {
                viewModel.fetchTitle()
            }
    }
}

struct DoCatchTryThrowBootcamp_Previews: PreviewProvider {
    static var previews: some View {
        DoCatchTryThrowBootcamp()
    }
}
