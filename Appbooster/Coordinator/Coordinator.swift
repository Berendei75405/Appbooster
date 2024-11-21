//
//  Coordinator.swift
//  Appbooster
//
//  Created by Novgorodcev on 21/11/2024.
//

import UIKit

//MARK: - CoordinatorProtocol
protocol CoordinatorProtocol: AnyObject {
    
}

final class Coordinator: CoordinatorProtocol {
    var navController: UINavigationController?
    
    init(navController: UINavigationController) {
        self.navController = navController
    }
    
    //MARK: - createStartVC
    func createStartVC() -> UIViewController {
        let view = StartViewController()
        let viewModel = StartViewModel()
        
        view.viewModel = viewModel
        
        return view
    }
    
    //MARK: - initialStartVC
    func initialStartVC() {
        if let navController = navController {
            let view = createStartVC()
            
            navController.viewControllers = [view]
        }
    }
    
}
