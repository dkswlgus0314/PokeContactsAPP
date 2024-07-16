//
//  PhoneBookView .swift
//  PokeContacts
//
//  Created by ahnzihyeon on 7/16/24.
//

import UIKit
import SnapKit

class PhoneBookView: UIView {

    let tableView: UITableView = {
        let tableView = UITableView()
        tableView.register(PhonBookTableViewCell.self, forCellReuseIdentifier: "PhonBookTableViewCell")  //셀 등록
        return tableView
    }()
    
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        configureUI()
    }
    
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    

    private func configureUI() {
        self.backgroundColor = .white
        
        self.addSubview(tableView)

        tableView.snp.makeConstraints {
            $0.centerX.equalToSuperview()
            $0.leading.trailing.equalToSuperview().inset(10)
        }
    }
    
}


