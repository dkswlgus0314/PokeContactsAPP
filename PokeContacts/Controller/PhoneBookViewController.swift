//
//  PhoneBookViewController.swift
//  PokeContacts
//
//  Created by ahnzihyeon on 7/16/24.
//

import UIKit

class PhoneBookViewController: UIViewController {

    var phoneBookView: PhoneBookView!
    
    lazy var righButton: UIBarButtonItem = {
        let button = UIBarButtonItem(title: "추가", style: .plain, target: self, action: #selector(righButtonTapped))
        return button
    }()
    
    
    
    override func loadView() {
//        phoneBookView = PhoneBookView(frame: self.view.frame) -> 안됨
        phoneBookView = PhoneBookView(frame: UIScreen.main.bounds)
        self.view = phoneBookView
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "친구 목록"
        navigationItem.rightBarButtonItem = righButton
        phoneBookView.tableView.delegate = self
        phoneBookView.tableView.dataSource = self
        
    }
    
    
    @objc
    private func righButtonTapped(){
        let nextVC = UpdatePhoneBookViewCotroller()
        self.navigationController?.pushViewController(nextVC, animated: true)
    }
}


extension PhoneBookViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        5
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "PhonBookTableViewCell", for: indexPath) as! PhonBookTableViewCell
        return cell
    }
    
    
}
