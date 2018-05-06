//
//  ConcentrationThemeViewController.swift
//  Concentration Game
//
//  Created by Henrik Anthony Odden Sandberg on 21.04.2018.
//  Copyright © 2018 Henrik Anthony Odden Sandberg. All rights reserved.
//

import UIKit

class ConcentrationThemeViewController: UIViewController, UISplitViewControllerDelegate{
    
    @IBOutlet private var themeChooserButtons: [UIButton]!
    
    private var gameNumber: Int?
    private var lastSeguaeToController: ConcentrationViewController?
    
    private var splitViewDetailConcentrationViewController: ConcentrationViewController?{
        return splitViewController?.viewControllers.last as? ConcentrationViewController
    }
    
    override func awakeFromNib() {
        splitViewController?.delegate = self
    }
    
    func splitViewController(_ splitViewController: UISplitViewController, collapseSecondary secondaryViewController: UIViewController, onto primaryViewController: UIViewController) -> Bool {
        if let cvc = secondaryViewController as? ConcentrationViewController{
            if cvc.theme == nil{
                return true
            }
        }
        return false
    }
    
    @IBAction func buttonPressed(_ sender: UIButton) {
        gameNumber = sender.tag == 5 ? nil : sender.tag
        
        if let currentGame = splitViewDetailConcentrationViewController{
            currentGame.theme = gameNumber
            currentGame.resetFromOtherVC()
            
        } else if let currentGame = lastSeguaeToController{
            
            currentGame.theme = gameNumber
            currentGame.resetFromOtherVC()
            navigationController?.pushViewController(currentGame, animated: true)
        } else {
            performSegue(withIdentifier: "chooseATheme", sender: self)
        }
    }
    
    // MARK: - Navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "chooseATheme"{
            if let destination = segue.destination as? ConcentrationViewController{
                destination.theme = gameNumber ?? nil
                lastSeguaeToController = destination
            }
        }
    }
}
