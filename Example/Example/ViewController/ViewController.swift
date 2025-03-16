//
//  ViewController.swift
//  Example
//
//  Created by William.Weng on 2025/2/11.
//

import UIKit
import WWSimpleAI_DeepSeek
import WWSimpleAI_Ollama

// MARK: - ViewController
final class ViewController: UIViewController {

    private let apiKey = "<API_KEY>"
    
    @IBOutlet weak var myTextView: UITextView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        initSetting()
    }
    
    @IBAction func chatDemo(_ sender: UIBarButtonItem) {
        chat(with: "今天日期是？", role: .user)
    }
    
    @IBAction func modelListDemo(_ sender: UIBarButtonItem) {
        modelList()
    }
    
    @IBAction func balanceDemo(_ sender: UIBarButtonItem) {
        balance()
    }
}

// MARK: - 小工具
private extension ViewController {
    
    /// 初始化數值
    func initSetting() {
        WWSimpleAI.DeepSeek.configure(apiKey: apiKey)
    }
    
    /// 取得模型列表
    func modelList() {
        
        Task {
            let result = await WWSimpleAI.DeepSeek.shared.list()
            
            switch result {
            case .failure(let error): displayText(error)
            case .success(let data): displayText(data?._jsonObject())
            }
        }
    }
    
    /// 查詢賬號餘額
    func balance() {
        
        Task {
            let result = await WWSimpleAI.DeepSeek.shared.balance()
            
            switch result {
            case .failure(let error): displayText(error)
            case .success(let data): displayText(data?._jsonObject())
            }
        }
    }
    
    /// 對話測試
    /// - Parameters:
    ///   - content: 文字
    ///   - role: 角色
    func chat(with content: String, role: WWSimpleAI.DeepSeek.Role) {
        
        Task {
            let result = await WWSimpleAI.DeepSeek.shared.chat(content: content, forRole: role)
            
            switch result {
            case .failure(let error): displayText(error)
            case .success(let data): displayText(data?._jsonObject())
            }
        }
    }
    
    /// 顯示文字
    /// - Parameter value: Any?
    @MainActor
    func displayText(_ value: Any?) {
        myTextView.text = "\(value ?? "")"
    }
}
