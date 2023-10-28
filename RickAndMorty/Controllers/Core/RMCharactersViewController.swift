//
//  RMCharacterViewController.swift
//  RickAndMorty
//
//  Created by Victor Domingues on 26/10/23.
//

import UIKit

/// Controller to show characters
final class RMCharactersViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        title = "Characters"
        // Do any additional setup after loading the view.
        
        // let request = RMRequest(
        //     endpoint: .character,
        //     queryParameters: [
        //         URLQueryItem(name: "name",value: "rick"),
        //         URLQueryItem(name: "status",value: "alive")
        //     ]
        // )
        //
        // print(request.url)
        //
        // RMService.shared.execute(request, expecting: RMCharacter.self) { result in
        //     switch result {
        //     case .success:
        //         break
        //     case .failure(let error):
        //         print(String(describing: error))
        //     }
        // }
        
        RMService.shared.execute( .listCharactersRequest,
                                  expecting: RMGetAllCharactersResponse.self) { result in
            switch result {
            case .success(let model):
                // print(String(describing: model))
                print("Total: "+String(model.info.count))
                print("Page result count: "+String(model.results.count))
            case .failure(let error):
                print(String(describing: error))
            }
            
        }
    }
}

