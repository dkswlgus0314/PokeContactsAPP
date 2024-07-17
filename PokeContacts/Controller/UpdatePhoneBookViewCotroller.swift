
import UIKit

class UpdatePhoneBookViewCotroller: UIViewController {
    var updatePhoneBookView: UpdatePhoneBookView!
    
    //네비게이션바 - "적용" 버튼
    lazy var righButton: UIBarButtonItem = {
        let button = UIBarButtonItem(title: "적용", style: .plain, target: self, action: #selector(righButtonTapped))
        return button
    }()
    
    
    override func loadView() {
        updatePhoneBookView = UpdatePhoneBookView(frame: UIScreen.main.bounds)
        self.view = updatePhoneBookView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //네비게이션바 설정
        title = "연락처 추가"
        navigationItem.rightBarButtonItem = righButton
        
        updatePhoneBookView.randomImageButton.addTarget(self, action: #selector(randomImageButtonTapped), for: .touchDown)
    }
    
    
    // MARK: - 서버 데이터 불러오는 메서드
    // 비동기적으로 동작하는 함수로 리턴형이 아닌, 콜백 함수로 설계
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
    
    // MARK: - 서버에서 포켓몬 데이터를 불러오는 메서드
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
    //"추가" 버튼 액션
    @objc
    private func righButtonTapped(){
        // 다음 뷰컨트롤러로 이동
        self.navigationController?.popViewController(animated: true)
    }
    
    @objc
    func randomImageButtonTapped(){
        pokemonInfoData()
    }
}
