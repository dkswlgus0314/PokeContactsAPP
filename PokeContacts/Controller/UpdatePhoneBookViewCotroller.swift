//
//  UpdatePhoneBookViewCotroller.swift
//  PokeContacts
//
//  Created by ahnzihyeon on 7/16/24.
//

import UIKit

class UpdatePhoneBookViewCotroller: UIViewController {
    var updatePhoneBookView: UpdatePhoneBookView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "연락처 추가 " //수정할 때는 연락처 수정으로 바껴야됨.
    }
    
    
    override func loadView() {
        updatePhoneBookView = UpdatePhoneBookView(frame: UIScreen.main.bounds)
        self.view = updatePhoneBookView
    }
    
}
