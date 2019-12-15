//
//  CameraViewController.swift
//  hackFuture-NGshare
//
//  Created by ATSUSHI YANO on 2019/12/14.
//  Copyright © 2019 ATSUSHI YANO. All rights reserved.
//

import UIKit
import AVFoundation


class CameraViewController: UIViewController {

    var stillImage: UIImage!

     @IBOutlet weak var previewView: UIView! //カメラのビュー
     @IBOutlet weak var shutterButton: UIButton! // シャターボタン
     
     @IBOutlet weak var cameraTypeButton: UIButton! // カメラタイプボタン(カメラの前後設定切り替えボタン)
     
     
     var isBack = true // 現在、カメラがどっちにあるかどうかのフラグ(バックの時にtrue)
     
     var session = AVCaptureSession() // セッションの作成
     
     var photoOutputObj = AVCapturePhotoOutput() // 出力先の作成
     
     override func viewDidAppear(_ animated: Bool) {
         super.viewDidAppear(animated)
         guard !session.isRunning else {
             return
         }
         
         shutterButton.isEnabled = true // シャッターボタンを有効にする
         shutterButton.setImage(UIImage.init(named: "shutterButton"), for: .normal) // シャターボタンを画像にする
         
         cameraTypeButton.isEnabled = true // カメラタイプボタンを有効にする
         cameraTypeButton.setImage(UIImage.init(named: "cameraTypeButton"), for: .normal)
         
         setupInputOutput() // 入出力の設定
         
         setPreviewLayer() // プレビューレイヤの設定
         
         session.startRunning() // セッション開始

     }
     
     
     override func viewDidLoad() {
         super.viewDidLoad()
         
         // Do any additional setup after loading the view.
     }
     
     
     /*---カメラの設定 開始---*/
     
     @IBAction func takePhoto(_ sender: Any) {      // シャッターボタンで実行する
        let captureSetting = AVCapturePhotoSettings()         // キャプチャのセッティング
        captureSetting.flashMode = .auto
        captureSetting.isAutoStillImageStabilizationEnabled = true
        captureSetting.isHighResolutionPhotoEnabled = false
         
        photoOutputObj.capturePhoto(with: captureSetting, delegate: self) // キャプチャのイメージ処理はデリゲートに任せる
    }
     
    // 映像をキャプチャする
    func photoOutput(_ output: AVCapturePhotoOutput,
                     didFinishProcessingPhoto photo: AVCapturePhoto, error: Error?) {
        
        // Dataを取り出す
        guard let photoData = photo.fileDataRepresentation() else {
            return
        }
//        // Dataから写真イメージを作る
        if let stillImage = UIImage(data: photoData) {
            let imageData = stillImage.jpegData(compressionQuality: 1); //UIImageをdataに変換
            UserDefaults.standard.set(imageData,forKey:"takenImage") //UserDefaltsに保存
            self.performSegue(withIdentifier: "toGoodsInfo", sender: nil)
        }
    }
     
     func setupInputOutput(){    // 入出力の設定
         
         session.sessionPreset = AVCaptureSession.Preset.photo   //解像度の指定
         
         do { // 入力の設定
             
             // print("\(isBack)")
             let type = isBack ? AVCaptureDevice.Position.back : AVCaptureDevice.Position.front
             
             let device = AVCaptureDevice.default( // 使用するデバイスの取得
                 AVCaptureDevice.DeviceType.builtInWideAngleCamera,
                 for: AVMediaType.video, // ビデオ入力
                 position: type // バックカメラorフロントカメラ
             )
             
             let input = try AVCaptureDeviceInput(device: device!) // 入力元
             if session.canAddInput(input){
                 session.addInput(input)
             }
             else{
                 print("セッションに入力を追加できなかった")
             }
         }catch  let error as NSError {
             print("カメラが使えない \n \(error.description)")
             return
         }
         if session.canAddOutput(photoOutputObj) {  // 出力の設定
             session.addOutput(photoOutputObj)  // 出力にデバイスが利用できるならばセッションに追加
         } else {
             print("セッションに出力を追加できなかった")
             return
         }
     }
     
     func setPreviewLayer(){    // プレビューレイヤの設定
         
         let previewLayer = AVCaptureVideoPreviewLayer(session: session) // プレビューレイヤを作る
         previewLayer.frame = view.bounds
         previewLayer.masksToBounds = true
         previewLayer.videoGravity = AVLayerVideoGravity.resizeAspect
         
         previewView.layer.addSublayer(previewLayer) // previewViewに追加する
     }
     

     @IBAction func changeType(_ sender: Any){ // カメラの前後を変更する
         isBack = isBack==true ? false : true // フラグを変更する(trueがback)
         
         session.stopRunning() // キャプチャーセッションを一旦終わらせる
         session.removeInput(session.inputs[0]) // input情報を消す
         session.removeOutput(photoOutputObj)  // output情報を消す

         session.startRunning()  // キャンプチャーセッションを再スタートさせる
         setupInputOutput()  // インプットとアウトプットの設定をやり直す
         //print("\(isBack)")
         

     }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) { // セグエによる画面遷移が行われる前に呼ばれるメソッド
        if (segue.identifier == "toGoodsInfo") {
            let nextVC: GoodsInfoViewController = (segue.destination as? GoodsInfoViewController)!
            // nextVC.imageKeyTmp = "takenImage" //多分ここ配列でKeyを送ってる
        }
    }

}
