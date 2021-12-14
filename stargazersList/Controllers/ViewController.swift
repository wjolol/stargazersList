//
//  ViewController.swift
//  stargazersList
//
//  Created by SERTORIG on 13/12/21.
//

import UIKit
import cleafychallenge

class ViewController: UIViewController {
    
    @IBOutlet weak var ownerTextField: UITextField!
    @IBOutlet weak var repoTextField: UITextField!
    
    
    @IBAction func onFetchTap(_ sender: Any) {
        if let owner = ownerTextField.text, let repo = repoTextField.text {
            if owner == "" || repo == "" {
                showError(info: "Fill the owner and repo name fields then tap on fetch")
            } else {
                login(owner: owner, repoName: repo)
            }
        } else {
            showError(info: "Fill the owner and repo name fields then tap on fetch")
        }
        
    }
    
    var stargazersList = [String]()

    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    private func login(owner: String, repoName: String) {
        //owne -> octocat  repoName -> hello-world
        CheckDevice().start(owner: owner, repoName: repoName) { result in
            switch result {
            case .ok(let list):
                self.showData(list: list)
            case .failure(let error):
                self.showError(info: error)
            @unknown default:
                self.showError()
            }
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "toStargazersTable" {
            if let nextViewController = segue.destination as? StargazersTableController {
                nextViewController.stargazersList = stargazersList
            }
        }
    }
    
    private func showData(list: [String]?) {
        if let lista = list {
            stargazersList = lista
            DispatchQueue.main.async {
                self.performSegue(withIdentifier: "toStargazersTable", sender: self)
            }
        }
    }
    
    private func showError(info: String? = nil) {
        DispatchQueue.main.async {
            let dialogMessage = UIAlertController(title: "Error", message: info == nil ? "An error occured while trying to verify the authenticity of the device" : info, preferredStyle: .alert)
            // Create OK button with action handler
            let ok = UIAlertAction(title: "OK", style: .default, handler: { (action) -> Void in
                self.dismiss(animated: true, completion: nil)
            })
            //Add OK button to a dialog message
            dialogMessage.addAction(ok)
            //Present Alert to
            self.present(dialogMessage, animated: true, completion: nil)
        }
    }
}

