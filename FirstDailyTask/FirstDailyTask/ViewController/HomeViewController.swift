//
//  HomeViewController.swift
//  FirstDailyTask
//
//  Created by 박성훈 on 7/2/25.
//

import UIKit

//TODO: - 이미지뷰 따로 만들기 - 혹은 오토레이아웃으로 짜야함.
//TODO: - top10 뱃지 / 새로운 에피소드 / 새로운 시리즈 랜덤으로 ㄱㄱ
class HomeViewController: UIViewController {
    
    private var movieImages: [UIImage] = [._1, ._2, ._3, ._4, ._5, .극한직업, .노량, .더퍼스트슬램덩크, .도둑들, .명량, .밀수, .범죄도시3, .베테랑, .부산행, .서울의봄, .스즈메의문단속, .신과함께인과연, .신과함께죄와벌, .아바타, .아바타물의길, .알라딘, .암살, .어벤져스엔드게임, .오펜하이머, .왕의남자, .육사오, .콘크리트유토피아, .태극기휘날리며, .택시운전사, .해운대]
    
    @IBOutlet var moviePosterImageViews: [UIImageView]!
    @IBOutlet var moviePosterOuterView: [UIView]!
    @IBOutlet var randomViews: [UIView]!
    @IBOutlet var playButton: UIButton!
    @IBOutlet var savedContentsButton: UIButton!
    @IBOutlet var playButtonView: UIView!
    @IBOutlet var playButtonImageView: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setUI()
    }
    
    private func setUI() {
        self.view.backgroundColor = .black
        designImageView()
        designButton()
        setRandomView()
    }
    
    private func setRandomView() {
        randomViews.forEach {
            $0.isHidden = true
            
            if !($0 is UIImageView) {
                $0.layer.cornerRadius = 4
                $0.clipsToBounds = true
            }
        }
        
        showRandomView()
    }
    
    private func showRandomView() {
        for view in randomViews {
            view.isHidden = Bool.random()
        }
    }
    
    private func designImageView() {
        for imageView in moviePosterImageViews {
            designImageView(imageView)
        }
    }
    
    private func designImageView(_ imageView: UIImageView, cornerRaius: CGFloat = 12) {
        imageView.layer.cornerRadius = cornerRaius
        imageView.clipsToBounds = true
        imageView.layer.borderColor = UIColor.gray.cgColor
        imageView.layer.borderWidth = 1
        
        playButtonImageView.image = .playNormal
        playButtonImageView.contentMode = .scaleAspectFit
        
        moviePosterOuterView.forEach {
            $0.layer.cornerRadius = cornerRaius
            $0.clipsToBounds = true
        }
    }
    
    private func designButton() {
        designButton(playButton)
        designButton(savedContentsButton)
    }
    
    private func designButton(_ button: UIButton, cornerRadius: CGFloat = 8) {
        button.layer.cornerRadius = cornerRadius
        button.layer.masksToBounds = true
        
        playButtonView.layer.cornerRadius = cornerRadius
        playButtonView.clipsToBounds = true
    }
    
    @IBAction func playButtonTapped(_ sender: UIButton) {
        print(#function)
        playButtonImageView.image = .playNormal
        
        moviePosterImageViews.forEach {  $0.image = movieImages.randomElement() }
        showRandomView()
    }
    
    // 버튼이 눌렸을 때
    @IBAction func playButtonTouchDown(_ sender: UIButton) {
        print(#function)
        playButtonImageView.image = .playHighlighted
    }
}
