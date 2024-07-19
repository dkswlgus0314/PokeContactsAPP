
import UIKit
import CoreData

class UpdatePhoneBookViewCotroller: UIViewController {
    var updatePhoneBookView: UpdatePhoneBookView!
    var phoneBookViewController: PhoneBookViewController? //변수가 nil일 수 있음
    var phoneBook: PhoneBook? // 수정할 데이터
    let coreDataManager = CoreDataManager()
    
    //네비게이션바 - "적용" 버튼
    lazy var saveButton: UIBarButtonItem = {
        let button = UIBarButtonItem(title: "적용", style: .plain, target: self, action: #selector(saveButtonTapped))
        return button
    }()
    
    
    override func loadView() {
        // UpdatePhoneBookView를 기본 뷰로 설정
        updatePhoneBookView = UpdatePhoneBookView(frame: UIScreen.main.bounds)
        self.view = updatePhoneBookView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //네비게이션바 설정
        navigationItem.rightBarButtonItem = saveButton
        
        updatePhoneBookView.randomImageButton.addTarget(self, action: #selector(randomImageButtonTapped), for: .touchDown)
      
        if let phoneBook = phoneBook {
            // 전달받은 데이터를 뷰에 표시
            title = "\(phoneBook.name!)"
            updatePhoneBookView.inputName.text = phoneBook.name
            updatePhoneBookView.inputPhoneNumber.text = phoneBook.phoneNumber
            if let imageData = phoneBook.image {
                updatePhoneBookView.profileImage.image = UIImage(data: imageData)
            }
        }
    }
    
    
    // MARK: - 서버 데이터 불러오는 메서드
    // 서버 데이터 가져오기 - 비동기적으로 동작하는 함수로 리턴형이 아닌, 콜백 함수로 설계
    private func fetchData<T: Decodable>(url: URL, completion: @escaping (T?) -> Void) {
        print(#function)
        let session = URLSession(configuration: .default)
        
        session.dataTask(with: URLRequest(url: url)) { data, response, error in
            guard let data = data, error == nil else {
                print("데이터 로드 실패")
                completion(nil)
                return
            }
            let successRange = 200..<300
            if let response = response as? HTTPURLResponse, successRange.contains(response.statusCode) {
                guard let decodeData = try? JSONDecoder().decode(T.self, from: data) else {
                    print("데이터가 없음")
                    completion(nil)
                    return
                }
                completion(decodeData)
            } else {
                print("응답 오류")
                completion(nil)
            }
        }.resume()
    }
    
    // MARK: - 서버에서 랜덤 포켓몬 데이터를 불러오는 메서드
    private func pokemonInfoData() {
        let urlComponents = URLComponents(string: "https://pokeapi.co/api/v2/pokemon/\(Int.random(in: 1...1000))")
        
        guard let url = urlComponents?.url else {
            print("잘못된 URL")
            return
        }
        // 데이터를 가지고 오는 메서드 추출
        fetchData(url: url) { [weak self] (pokemon: Pokemon?) in
            // guard let 을 통해 self를 다시 강한참조를 하여 안전하게 사용
            guard let self, let pokemon else { return }
            // 메인 스레드로 설정을 해주지 않으면 백그라운드 스레드에서 돌아가서 안좋음
            guard let imageUrl = URL(string: pokemon.sprites.frontDefault) else { return }
            // image 를 로드하는 작업은 백그라운드 쓰레드 작업 : Data(contensOf:)
            if let data = try? Data(contentsOf: imageUrl) {
                if let image = UIImage(data: data) {
                    // 이미지뷰에 이미지를 그리는 작업은 UI 작업이기 때문에 다시 메인 쓰레드에서 작업.
                    DispatchQueue.main.async {
                        self.updatePhoneBookView.profileImage.image = image
                    }
                }
            }
        }
    }
    
    
    //MARK: - @objc 메서드
    //"랜덤 이미지 생성" 버튼 액션
    @objc
    func randomImageButtonTapped(){
        pokemonInfoData()
    }
    
    //"적용" 버튼 액션
    @objc
    func saveButtonTapped(){
        if let name = updatePhoneBookView.inputName.text,
           let phoneNumber = updatePhoneBookView.inputPhoneNumber.text,
           let image = updatePhoneBookView.profileImage.image {
            
            if let phoneBook = phoneBook {
                // 기존 데이터를 업데이트
                coreDataManager.updateData(currentPhoneNumer: phoneBook.phoneNumber!, newName: name, newPhoneNumber: phoneNumber, newImage: image)
            } else {
                // 새로운 데이터를 생성
                coreDataManager.createData(name: name, phoneNumber: phoneNumber, image: image)
            }
            
            // 업데이트된 데이터가 올바르게 반영되도록 데이터 새로고침 -> nil 작동 안하는 중
//            phoneBookViewController?.phoneBookList = coreDataManager.readAllData() ?? []
//            phoneBookViewController?.phoneBookView.tableView.reloadData()
//            print(phoneBookViewController)
            
            self.navigationController?.popViewController(animated: true)
        }
    }
}
