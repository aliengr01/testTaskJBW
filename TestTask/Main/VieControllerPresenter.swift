//
//  VieControllerPresenter.swift
//  TestTask
//
//  Created by Igor Ryazancev on 14.03.2018.
//  Copyright © 2018 Igor Ryazancev. All rights reserved.
//

import Foundation


class ViewControllerPresenter {
    
    let view: ViewController
    let networkingServise: GetTextNetworkingService
    
    init(view: ViewController, with networkingService: GetTextNetworkingService = GetTextNetworkingService()) {
        self.view = view
        self.networkingServise = networkingService
    }
    
    func getTextData() {
        
            self.networkingServise.getText { (responde) in
                if let responde = responde {
                    self.view.textString = responde.data
                    self.view.tableView.reloadData()
                }
        }
    }
    
    
}
