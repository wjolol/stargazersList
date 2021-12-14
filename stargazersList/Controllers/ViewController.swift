//
//  ViewController.swift
//  stargazersList
//
//  Created by SERTORIG on 13/12/21.
//

import UIKit
import cleafychallenge

class ViewController: UIViewController {
    
    //MARK: - Outlets
    @IBOutlet weak var ownerTextField: UITextField!
    @IBOutlet weak var repoTextField: UITextField!
    
    //MARK: - Actions
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
    
    //MARK: - Vars
    var stargazersList = [String]()

    //MARK: - Controller lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    //MARK: - Login function
    /*  takes owner and repoName then passes them to the sdk that proceeds to check the security of the device, if the device passes all the tests then the sdk proceeds to download the data from the API, at the end it return a list of users to be shown in a table view.
        If the security checks fail or there is a problem with the api the sdk return a .failure with a string that represents the error that occured.
    */
    private func login(owner: String, repoName: String) {
        //owner -> octocat  repoName -> hello-world
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
    
    //MARK: - Navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "toStargazersTable" {
            if let nextViewController = segue.destination as? StargazersTableController {
                nextViewController.stargazersList = stargazersList
            }
        }
    }
    
    //MARK: - Show data
    private func showData(list: [String]?) {
        if let lista = list {
            stargazersList = lista
            DispatchQueue.main.async {
                self.performSegue(withIdentifier: "toStargazersTable", sender: self)
            }
        }
    }
    
    //MARK: - Show alert error, if no info is passed the message shown is a generic error.
    private func showError(info: String? = nil) {
        DispatchQueue.main.async {
            let dialogMessage = UIAlertController(title: "Error", message: info == nil ? "An error occured while trying to verify the authenticity of the device" : info, preferredStyle: .alert)

            let ok = UIAlertAction(title: "OK", style: .default, handler: { (action) -> Void in
                self.dismiss(animated: true, completion: nil)
            })

            dialogMessage.addAction(ok)
            
            self.present(dialogMessage, animated: true, completion: nil)
        }
    }
}

