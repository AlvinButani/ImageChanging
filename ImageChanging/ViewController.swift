//
//  ViewController.swift
//  ImageChanging
//
//  Created by Alvin butani on 9/10/18.
//  Copyright © 2018 Alvin butani. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet weak var img:UIImageView!
    @IBOutlet weak var btn:UIButton!{
        didSet{
            btn.addTarget(self, action: #selector(didTapBtn), for: .touchUpInside)
        }
    }
    
    var imageItem = [#imageLiteral(resourceName: "1"),#imageLiteral(resourceName: "2"),#imageLiteral(resourceName: "3"),#imageLiteral(resourceName: "4"),#imageLiteral(resourceName: "5")]
    var displayImageItem = [UIImage]()
    var index = [Int]()
    var timer: Timer!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    @objc func didTapBtn(_ sender:UIButton){
        if sender.isSelected{
            timer.invalidate()
        }
        else{
            let date = Date().addingTimeInterval(0.5)
            timer = Timer(fireAt: date, interval: 1, target: self, selector: #selector(displayImage), userInfo: nil, repeats: true)
            RunLoop.main.add(timer, forMode: RunLoopMode.commonModes)
        }
        sender.isSelected = !sender.isSelected
    }
    
    
    @objc func displayImage(){
        setImage()
    }

}

extension ViewController {
    
    func getImage(){
        if imageItem.count > 0{
            let redomImage = imageItem.randomItem()
            img.image = redomImage
            imageItem.remove(at: imageItem.index(where: {$0 == redomImage})!)
            displayImageItem.append(redomImage)
            print(imageItem.count)
        }else{
            print("======================")
            self.imageItem = self.displayImageItem
            displayImageItem = []
            getImage()
        }
    }
}

extension Collection {
    private func randomNumber<T : SignedInteger>(inRange range: ClosedRange<T> = 1...6) -> T {
        let length = Int64(range.upperBound - range.lowerBound + 1)
        let value = Int64(arc4random()) % length + Int64(range.lowerBound)
        return T(value)
    }
    
    func randomItem() -> Self.Iterator.Element {
        let count = distance(from: startIndex, to: endIndex)
        let roll = randomNumber(inRange: 0...count-1)
        return self[index(startIndex, offsetBy: roll)]
    }
    
}
