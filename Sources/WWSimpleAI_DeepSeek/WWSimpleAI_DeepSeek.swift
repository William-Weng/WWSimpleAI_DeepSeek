//
//  WWSimpleAI_DeepSeek.swift
//  WWSimpleAI_DeepSeek
//
//  Created by William.Weng on 2025/3/16.
//

import UIKit
import WWNetworking
import WWSimpleAI_Ollama

// MARK: - [簡單的DeepSeek功能使用](https://api-docs.deepseek.com/)
extension WWSimpleAI {
    
    open class DeepSeek {
        
        @MainActor
        public static let shared = DeepSeek()
        
        static let baseURL = "https://api.deepseek.com"
        
        static var apiKey = "<Key>"
        static var model: DeepSeek.Model = .chat
        
        private init() {}
    }
}

// MARK: - 初始值設定 (static function)
public extension WWSimpleAI.DeepSeek {
    
    /// [參數設定](https://api-docs.deepseek.com/)
    /// - Parameters:
    ///   - apiKey: String
    ///   - version: String
    ///   - model: Gemini模型
    static func configure(apiKey: String, model: WWSimpleAI.DeepSeek.Model = .chat) {
        self.apiKey = apiKey
        self.model = model
    }
}

// MARK: - 公開函式
public extension WWSimpleAI.DeepSeek {

    /// [支援模型列表](https://api-docs.deepseek.com/zh-cn/api/list-models)
    /// - Returns: Result<String?, Error>
    func list() async -> Result<Data?, Error> {
        
        let api = WWSimpleAI.DeepSeek.API.list
        let header = authorizationHeaders()
        let result = await WWNetworking.shared.request(httpMethod: .GET, urlString: api.value(), headers: header)
        
        switch result {
        case .failure(let error): return .failure(error)
        case .success(let info): return .success(info.data)
        }
    }
    
    /// [帳號餘額查詢](https://api-docs.deepseek.com/zh-cn/api/get-user-balance)
    /// - Returns: Result<Data?, Error>
    func balance() async -> Result<Data?, Error> {
        
        let api = WWSimpleAI.DeepSeek.API.balance
        let header = authorizationHeaders()
        let result = await WWNetworking.shared.request(httpMethod: .GET, urlString: api.value(), headers: header)
        
        switch result {
        case .failure(let error): return .failure(error)
        case .success(let info): return .success(info.data)
        }
    }
    
    /// [執行聊天功能](https://api-docs.deepseek.com/zh-cn/api/create-chat-completion)
    /// - Parameters:
    ///   - content: 句子文字
    ///   - role: 執行角色
    /// - Returns: Result<String?, Error>
    func chat(content: String, forRole role: Role = .user) async -> Result<Data?, Error> {
        
        let api = WWSimpleAI.DeepSeek.API.chat
        let header = authorizationHeaders()
        let json = """
        {
          "messages": [{"content": "\(content)", "role": "\(role.value())"}],
          "model": "\(WWSimpleAI.DeepSeek.model.value())"
        }
        """
        
        let result = await WWNetworking.shared.request(httpMethod: .POST, urlString: api.value(), headers: header, httpBodyType: .string(json))
        
        switch result {
        case .failure(let error): return .failure(error)
        case .success(let info): return .success(info.data)
        }
    }
}

// MARK: - 小工具
private extension WWSimpleAI.DeepSeek {

    /// [安全認證Header](https://platform.deepseek.com/api_keys)
    /// - Returns: [String: String?]
    func authorizationHeaders() -> [String: String?] {
        let headers: [String: String?] = ["Authorization": "Bearer \(WWSimpleAI.DeepSeek.apiKey)"]
        return headers
    }
}
