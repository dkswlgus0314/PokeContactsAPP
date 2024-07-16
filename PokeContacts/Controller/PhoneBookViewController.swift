import UIKit


class PhoneBookViewController: UIViewController {
    
    var phoneBookView: PhoneBookView!
    
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
        
        //네비게이션바 설정
        title = "친구 목록"
        navigationItem.rightBarButtonItem = righButton
        
        //테이블뷰 델리게이트
        phoneBookView.tableView.delegate = self
        phoneBookView.tableView.dataSource = self
        
    }
    
    //"추가" 버튼 액션
    @objc
    private func righButtonTapped(){
        // 다음 뷰컨트롤러로 이동 
        let nextVC = UpdatePhoneBookViewCotroller()
        self.navigationController?.pushViewController(nextVC, animated: true)
    }
}


//프로토콜 채택 및 phoneBookView에서 설정한 테이블뷰 필수 델리게이트 메서드 구현
extension PhoneBookViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        5
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        // UITableViewCell 타입을 phoneBookView 타입으로 변환
        let cell = tableView.dequeueReusableCell(withIdentifier: "PhoneBookTableViewCell", for: indexPath) as! PhonBookTableViewCell
        return cell
    }
    
    
}
