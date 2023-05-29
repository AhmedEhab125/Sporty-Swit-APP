//
//  SplashScreeViewController.swift
//  Sporty
//
//  Created by ahmed on 29/05/2023.
//

import UIKit
import Lottie
class SplashScreeViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        
        let animationView = LottieAnimationView(name: "sportAnimation")
        animationView.transform = CGAffineTransform(scaleX: 0.5, y: 0.5)
        view.addSubview(animationView)
        animationView.translatesAutoresizingMaskIntoConstraints = false
        animationView.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        animationView.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
        
        
        animationView.play()
        DispatchQueue.main.asyncAfter(deadline: .now() + 3.0) {
            let mainVC = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(identifier: "MainVC")
            mainVC.modalPresentationStyle = .fullScreen
            self.present(mainVC, animated: true, completion: nil)
        }
        // Do any additional setup after loading the view.
    }
    
    
    /*
     // MARK: - Navigation
     
     // In a storyboard-based application, you will often want to do a little preparation before navigation
     override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
     // Get the new view controller using segue.destination.
     // Pass the selected object to the new view controller.
     }
     */
    
}
