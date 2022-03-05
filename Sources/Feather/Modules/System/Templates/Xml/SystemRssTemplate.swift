//
//  File.swift
//  
//
//  Created by Tibor Bodecs on 2021. 12. 23..
//

import Vapor
import SwiftRss

final class SystemRssTemplate: AbstractTemplate<SystemRssContext> {
    
    private static let formatter: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateFormat = "EEE, dd MMM y HH:mm:ss Z"
        return formatter
    }()
    
    override func render(_ req: Request) -> Tag {
        Rss {
            SwiftRss.Channel {
                Title(req.variable("webSiteTitle") ?? "")
                Description(req.variable("webSiteExcerpt") ?? "")
                Link(req.feather.baseUrl)
                Language("en_US")
                LastBuildDate(Self.formatter.string(from: .init()))
                PubDate(Self.formatter.string(from: .init()))
                Ttl(250)
                
                for item in context.items {
                    Item {
                        Guid(req.feather.baseUrl + item.slug.safePath())
                            .isPermalink()
                        Title(item.title ?? "")
                        Description(item.excerpt ?? "")
                        PubDate(Self.formatter.string(from: .init()))
                        
                    }
                }
            }
        }
    }
}
