//
//  ViewController.swift
//  TestTask
//
//  Created by Igor Ryazancev on 12.03.2018.
//  Copyright © 2018 Igor Ryazancev. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    
    var textString: String?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.getData()
        self.tableView.dataSource = self
        
        self.registerNib()

    }
    
    func registerNib() {
        self.tableView.register(UINib(nibName: "TableViewCell", bundle: nil), forCellReuseIdentifier: "TableViewCell")
    }
    
    @IBAction func goLoginAction(_ sender: Any) {
        let str = UIStoryboard(name: "Login", bundle: nil)
        
        if let nextVC = str.instantiateInitialViewController() as? LoginViewController {
            present(nextVC, animated: true, completion: nil)
        }
    }
    
    @IBAction func getMyToken(_ sender: Any) {
        let alertVC = UIAlertController(title: "MY TOKEN", message: Globals.API.AUTH.access_token, preferredStyle: .alert)
        let buttonOk = UIAlertAction(title: "OK", style: .default, handler: nil)
        alertVC.addAction(buttonOk)
        return self.present(alertVC, animated: true, completion: nil)
    }
    
    func getData() {
        let presenter = ViewControllerPresenter(view: self)
        presenter.getTextData()
    }

}

extension ViewController: UITableViewDataSource {
     func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return Globals.Characters.arrayChars.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = self.tableView.dequeueReusableCell(withIdentifier: "TableViewCell", for: indexPath) as! TableViewCell
        
        guard let countChars = self.textString?.components(separatedBy: Globals.Characters.arrayChars[indexPath.row]) else { return cell }
        
        var chars = Globals.Characters.arrayChars[indexPath.row]
        let charsCount = String(describing: countChars.count)
        
        if chars == " " {
            chars = "\"space\""
        }
        
        let doneString = "<\"\(chars)\"> - \(charsCount) times"
        
        cell.stringLabel.text = doneString

        
        return cell
    
    }


}


