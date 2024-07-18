import UIKit
import SnapKit

class PhoneBookView: UIView {

    let tableView: UITableView = {
        let tableView = UITableView()
        tableView.register(PhonBookTableViewCell.self, forCellReuseIdentifier: "PhoneBookTableViewCell")  //셀 등록
        tableView.rowHeight = 80
        return tableView
    }()
    
    //
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
            $0.leading.trailing.equalToSuperview().inset(10)
            $0.top.bottom.equalToSuperview()
        }
    }
    
}
