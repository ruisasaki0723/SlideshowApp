//
//  ViewController.swift
//  SlideshowApp
//
//  Created by 佐々木瑠唯 on 2020/04/24.
//  Copyright © 2020 Rui.Sasaki. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet weak var slideshow: UIImageView!
    
    @IBOutlet weak var go: UIButton!
    @IBOutlet weak var back: UIButton!
    @IBOutlet weak var startstop: UIButton!
    
    //タイマーの作成
    var timer: Timer!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        //初期画面としてimage1の画像を表示する
        let image = UIImage(named: "image1.jpg")
        slideshow.image = image
    }
    //初期画面の番号を0にする
    var displayImageNo = 0
    //配列を作る
    let imageNameArray = ["image1.jpg","image2.jpg","image3.jpg"]
    //初期画面の番号を元に画像を表示する
    func displayImage() {
        // 初期画面の番号から名前を取り出す
        let name = imageNameArray[displayImageNo]
        // 画像を読み込み
        let image = UIImage(named: name)
        // Image Viewに読み込んだ画像をセット
        slideshow.image = image
    }
    //進むボタン
    @IBAction func goButton(_ sender: Any) {
        //表示している画像番号が2じゃない場合
        if displayImageNo < imageNameArray.count - 1 {
            //画像番号に1を足す
            displayImageNo += 1
            //1足した画像を表示する
            displayImage()
            
        } else {
            //表示している画像番号が2の場合
            displayImageNo = 0
            //画像番号0の画像を表示する
            displayImage()
        }
    }
    //戻るボタン
    @IBAction func backButton(_ sender: Any) {
        //表示している画像番号が0じゃない場合
        if displayImageNo >= 1 && displayImageNo <= imageNameArray.count - 1 {
            //画像番号から1を引く
            displayImageNo -= 1
            //1引いた画像を表示する
            displayImage()
            //
        } else {
            //表示している画像が0の場合
            displayImageNo = imageNameArray.count - 1
            //画像番号2の画像を表示する
            displayImage()
        }
    }
    // スライドショーの作成(進むボタンの内容と同じ)
    @objc func updateTimer(_ timer: Timer) {
        
        if displayImageNo < imageNameArray.count - 1 {
            displayImageNo += 1
            displayImage()
        } else {
            displayImageNo = 0
            displayImage()
        }
    }
    //再生と停止ボタン
    @IBAction func startstop(_ sender: Any) {
        
        if self.timer == nil {
            // タイマーを設定
            self.timer = Timer.scheduledTimer(timeInterval: 2.0,
                                              target: self, selector:
                #selector(updateTimer(_:)), userInfo: nil, repeats: true)
            //再生・停止ボタンを押している時は進むボタンと戻るボタンを無効にする
            go.isEnabled = false
            back.isEnabled = false
            //再生ボタンの名前を停止ボタンに変える
            startstop.setTitle("停止", for: .normal)
            
        } else if self.timer != nil {
            //タイマーを止める
            self.timer.invalidate()
            
            self.timer = nil
            
            go.isEnabled = true
            back.isEnabled = true
            //停止ボタンの名前を再生ボタンに戻す
            startstop.setTitle("再生", for: .normal)
        }
    }
    //画像をタップした時の処理
    @IBAction func imageTap(_ sender: Any) {
        
        self.performSegue(withIdentifier: "toZoom", sender: nil)
        
        if self.timer == nil {
            
            go.isEnabled = true
            back.isEnabled = true
            
            startstop.setTitle("再生", for: .normal)
            
        } else if self.timer != nil {
            //タイマーを止める
            self.timer.invalidate()
            
            self.timer = nil
            
            go.isEnabled = true
            back.isEnabled = true
            
            startstop.setTitle("再生", for: .normal)
        }
    }
    // 遷移先に画像を渡す
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // segueから遷移先ののインスタンスを取得する
        let zoomViewController:ZoomViewController = segue.destination as! ZoomViewController
        
        let name = imageNameArray[displayImageNo]
        
        let image = UIImage(named: name)
        // 遷移先のselectedImgに値を代入して渡す
        zoomViewController.selectedImg = image
    }
}
