//
//  ContentView.swift
//  circular_progress_ring
//
//  Created by Jeanyou on 2021/1/19.
//
import UIKit
import SwiftUI
struct DrawView: UIViewRepresentable {
    func makeUIView(context: Context) -> UIView {
        let aDegree = CGFloat.pi / 180
        let lineWidth1: CGFloat = 2  //內圈粗細
        let lineWidth2: CGFloat = 15 //外圈粗細
        let radius: CGFloat = 50 //想要的半徑大小
        let startDegree: CGFloat = 90 //開始的角度在正下方，設定90度
        let circlePath = UIBezierPath(ovalIn: CGRect(x: lineWidth1+10, y: lineWidth1, width: radius*2, height: radius*2)) //畫出內圈
        let circleLayer = CAShapeLayer()
        circleLayer.path = circlePath.cgPath
        circleLayer.strokeColor = UIColor.gray.cgColor
        circleLayer.lineWidth = lineWidth1
        circleLayer.fillColor = UIColor.clear.cgColor
        let percentage: CGFloat = 60
        let percentagePath = UIBezierPath(arcCenter: CGPoint(x: lineWidth1 + radius+10, y: lineWidth1 + radius), radius: radius, startAngle: aDegree * startDegree, endAngle: aDegree * (startDegree + 360 * percentage / 100), clockwise: true) //畫出外圈
        //雙圈畫出來發現沒辦法重疊，要調整XY數值直到重疊
        let percentageLayer = CAShapeLayer()
        percentageLayer.path = percentagePath.cgPath
        percentageLayer.strokeColor  = UIColor(red: 0, green: 225/255, blue: 100/255, alpha: 1).cgColor
        //設定外圈顏色
        percentageLayer.lineWidth = lineWidth2
        percentageLayer.fillColor = UIColor.clear.cgColor
        percentageLayer.lineCap = .round
        
        let label = UILabel(frame: CGRect(x: 0+10, y: 0, width: 2*(radius+lineWidth1), height: 2*(radius+lineWidth1))) //設定百分比標籤大小及位置
        label.textAlignment = .center
        label.font = UIFont(name: "Helvetica-Light", size: 25) //設定百分比標籤的字型及字體大小
        label.textColor =  UIColor(red:0, green:0, blue:0, alpha:0.7)
        let percentageInt: Int = Int(round(percentage))
        //原本設定為Float的百分比會有小數點，取整數比較簡潔好看
        label.text = "\(percentageInt)%"
        let view = UIView(frame: label.frame)
        view.layer.addSublayer(circleLayer)
        view.layer.addSublayer(percentageLayer)
        view.addSubview(label)
        return view
    }
    
    func updateUIView(_ uiView: UIView, context: Context) {
    }
    
}
struct ContentView: View {
    var body: some View {
        DrawView()
    }
}
struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
