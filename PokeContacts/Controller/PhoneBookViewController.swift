import UIKit
import CoreData

class PhoneBookViewController: UIViewController {
    
    var phoneBookView: PhoneBookView!
    let coreDataManager = CoreDataManager()
    
    var phoneBookList: [PhoneBook] = []
    
    //네비게이션바 - "추가" 버튼
    lazy var righButton: UIBarButtonItem = {
        let button = UIBarButtonItem(title: "추가", style: .plain, target: self, action: #selector(righButtonTapped))
        return button
    }()
    
    
    //
    override func loadView() {
        phoneBookView = PhoneBookView(frame: UIScreen.main.bounds)
        self.view = phoneBookView
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupNaviBar()
        setupTableView()
    }
    
    //화면에 진입할 때마다 테이블뷰 리로드
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        phoneBookList = coreDataManager.readAllData() ?? [] //nil이면 빈배열
        phoneBookView.tableView.reloadData()
    }
    
    //네비게이션바 설정
    func setupNaviBar(){
        title = "친구 목록"
        navigationItem.rightBarButtonItem = righButton
    }
    
    //테이블뷰 설정
    func setupTableView(){
        //테이블뷰 델리게이트
        phoneBookView.tableView.delegate = self
        phoneBookView.tableView.dataSource = self
    }
    
    
    
    
    //MARK: -@objc 메서드
    //"추가" 버튼 액션
    @objc
    private func righButtonTapped(){
        // 다음 뷰컨트롤러로 이동
        let nextVC = UpdatePhoneBookViewCotroller()
        self.navigationController?.pushViewController(nextVC, animated: true)
    }
}


//MARK: -테이블뷰 델리게이트 메서드 구현
//프로토콜 채택 및 phoneBookView에서 설정한 테이블뷰 필수 델리게이트 메서드 구현
extension PhoneBookViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return phoneBookList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        // UITableViewCell 타입을 phoneBookView 타입으로 변환
        let cell = tableView.dequeueReusableCell(withIdentifier: "PhoneBookTableViewCell", for: indexPath) as! PhonBookTableViewCell
        
        // 셀에 모델 전달
        let phoneBook = phoneBookList[indexPath.row]
        cell.name.text = phoneBook.name
        cell.phoneNumber.text = phoneBook.phoneNumber
        cell.image.image = UIImage(data: phoneBook.image ?? Data())
        
        //셀에 모델 전달
        //        let coreData = coreDataManager.readAllData()
        //        cell.data = phoneBookList[indexPath.row] //셀에 데이터를 전달
        
        //셀이 눌렸을 때 뷰컨에서 어떤 행동을 하기위해 클로저 전달
        //        cell.  = { [weak self] (senderCell) in
        //                self?performSegue(withIdentifier: "PhoneBookTableViewCell", sender: indexPath)
        //        }
        //        cell.selectionStyle = .none
        return cell
    }
    
}

extension PhoneBookViewController: UITableViewDelegate{
    //셀을 선택했을 때 다음 화면으로 이동
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        performSegue(withIdentifier: "PhoneBookTableViewCell", sender: indexPath) //스토리보드에서 사용시
    }
}



