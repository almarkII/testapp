//
//  ViewController.swift
//  testapp
//
//  Created by Al on 7/3/18.
//  Copyright © 2018 Al. All rights reserved.
//

import UIKit
import GameplayKit

var picarr: Array<UIImage> = []
var picidx = 0
var imgTileArr = [UIImage]()
let row = 3
let column = 3

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        picarr += [UIImage(named: "IMG_0958")!, UIImage(named: "IMG_0959")!, UIImage(named: "IMG_0961")!]
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    @IBOutlet weak var imgView: UIImageView!
    @IBOutlet weak var startBtn: UIButton!
    @IBOutlet weak var doneBtn: UIButton!
    @IBOutlet weak var nextBtn: UIButton!
    @IBOutlet weak var goBtn: UIButton!
    
    @IBAction func startBtnPressed(_ sender: Any) {
        startBtn.isHidden = true
        startBtn.isEnabled = false
        imgView.image = picarr[picidx]
        nextBtn.isHidden = false
        nextBtn.isEnabled = true
        goBtn.isHidden = false
        goBtn.isEnabled = true
        picidx += 1
    }
    
    @IBAction func nextBtnPressed(_ sender: Any) {
        if picidx >= picarr.count {
            picidx = 0
        }
        imgView.image = picarr[picidx]
        picidx += 1
    }
    
    @IBAction func goBtnPressed(_ sender: Any) {
        nextBtn.isHidden = true
        nextBtn.isEnabled = false
        goBtn.isHidden = true
        goBtn.isEnabled = false
        
        splitImage(row: row, column: column)
        createNewImage(imgArr: imgTileArr, row: row, column: column)
        doneBtn.isHidden = false
        doneBtn.isEnabled = true
    }
    
    @IBAction func doneBtnPressed(_ sender: Any) {
        if picidx >= picarr.count {
            picidx = 0
        }
        imgView.image = picarr[picidx]
        nextBtn.isHidden = false
        nextBtn.isEnabled = true
        goBtn.isHidden = false
        goBtn.isEnabled = true
        doneBtn.isHidden = true
        doneBtn.isEnabled = false
    }
    

    
    
    
    func splitImage(row: Int, column: Int) {
        let oImg = imgView.image
        let imgViewOrient = (imgView.image?.imageOrientation)!
        var height = CGFloat(row)
        var width = CGFloat(column)
        switch imgViewOrient {
        case .up:
            height = (imgView.image?.size.height)! / CGFloat(row)
            width = (imgView.image?.size.width)! / CGFloat(column)
            break
        case .right:
            height = (imgView.image?.size.width)! / CGFloat(row)
            width = (imgView.image?.size.height)! / CGFloat(column)
        case .down:
            height = (imgView.image?.size.height)! / CGFloat(row)
            width = (imgView.image?.size.width)! / CGFloat(column)
            break
        case .left:
            height = (imgView.image?.size.width)! / CGFloat(row)
            width = (imgView.image?.size.height)! / CGFloat(column)
        case .upMirrored:
            height = (imgView.image?.size.height)! / CGFloat(row)
            width = (imgView.image?.size.width)! / CGFloat(column)
            break
        case .downMirrored:
            height = (imgView.image?.size.height)! / CGFloat(row)
            width = (imgView.image?.size.width)! / CGFloat(column)
            break
        case .leftMirrored:
            height = (imgView.image?.size.width)! / CGFloat(row)
            width = (imgView.image?.size.height)! / CGFloat(column)
        case .rightMirrored:
            height = (imgView.image?.size.width)! / CGFloat(row)
            width = (imgView.image?.size.height)! / CGFloat(column)
        }
        let scale = (imgView.image?.scale)!

        var tmpimgTileArr = [UIImage]()
        
        for y in 0..<row {
    //        var yArr = [UIImage]()
            for x in 0..<column {
                UIGraphicsBeginImageContextWithOptions(CGSize(width:width, height:height), false, 0) // create bitmap -based graphic context with the specified (CGSize size, opaque(T/F), CGFloat scale)
                let i = oImg?.cgImage?.cropping(to: CGRect.init(x: CGFloat(x) * width * scale, y: CGFloat(y) * height * scale, width: width * scale , height: height * scale))
                let newImg = UIImage.init(cgImage: i!, scale: scale,  orientation:imgViewOrient)
                tmpimgTileArr.append(newImg)
                UIGraphicsEndImageContext()
            }
  //      let shuffleimgarr = GKRandomSource.sharedRandom().arrayByShufflingObjects(in: yArr)
  //          tmpimgTileArr.append(shuffleimgarr as! [UIImage])
        }
        imgTileArr = GKRandomSource.sharedRandom().arrayByShufflingObjects(in: tmpimgTileArr) as! [UIImage]
     }
     
     
    func createNewImage(imgArr: [UIImage], row: Int, column: Int) {
  //      let row = imgArr.count
  //      let column = imgArr[0].count
        let height = (imgView.frame.size.height)/CGFloat(row)
        let width = (imgView.frame.size.width)/CGFloat(column)
        var imgIdx = 0
        
        UIGraphicsBeginImageContext(CGSize.init(width: imgView.frame.size.width, height: imgView.frame.size.height))
        for y in 0..<row{
            for x in 0..<column{
                imgIdx = y * (column) + x  // smash the 2D array into 1D since we know row n column
                let newImage = imgArr[imgIdx]
                newImage.draw(in: CGRect.init(x: CGFloat(x) * width, y: CGFloat(y) * height, width: width-1, height: height-1))
         //       newImage.draw(in: CGRect.init(x: CGFloat(x) * height, y: CGFloat(y) * width, width: height-1, height: width-1))
          }
     
        }
        let origImg = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        imgView.image = origImg
     }
     
     
    
    
    
    
}




