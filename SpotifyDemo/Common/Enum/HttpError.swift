//
//  HttpError.swift
//  SpotifyDemo
//
//  Created by Ling Zhan on 2024/9/19.
//


enum HttpError: Error {
    case invalidResponse
    case invalidData
    case invalidURL
    case invalidRequest
    case invalidResponseData
    case invalidWriteDatabase
}
