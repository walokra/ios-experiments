//
//  News.swift
//  NewsPages
//
//  Created by Marko Wallin on 21.6.2015.
//  Copyright (c) 2015 Rule of tech. All rights reserved.
//

import UIKit


//{
//	"responseData": {
//		"feed": {
//			"title": "HIGH.FI",
//			"link": "http://fi.high.fi/",
//			"author": "AfterDawn Oy",
//			"description": "News",
//			"type": "json",
//			"entries": [
//{
//	"title": "string",
//	"link": "url",
//	"author": "string",
//	"publishedDateJS": "2015-06-16T22:46:08.000Z",
//	"publishedDate": "June, 16 2015 22:46:08",
//	"originalPicture": "url",
//	"picture": "url",
//	"shortDescription": "",
//	"originalURL": "url",
//	"mobileLink": "",
//	"originalMobileURL": "",
//	"articleID": int,
//	"sectionID": int,
//	"sourceID": int,
//	"highlight": true
//
//},

class News: NSObject {
    let title: String
    
    init(title: String) {
        self.title = title
    }
}

class NewsEntry: NSObject {
    let title: String
    let link: String
    let author: String
    let publishedDateJS: String
    //	let picture: String?
    //	let originalPicture: String?
    var shortDescription: String?
    //	let originalURL: String
    var mobileLink: String?
    //	let originalMobileUrl: String?
    //	let articleID: Int
    var sectionID: Int
    //	let sourceID: Int
    //	let highlight: Bool
    var section: String
    
    init(title: String, link: String, author: String, publishedDateJS: String,
        shortDescription: String?, mobileLink: String?, sectionID: Int, section: String) {
            self.title = title
            self.link = link
            self.author = author
            self.publishedDateJS = publishedDateJS
            //	let picture: String?
            //	let originalPicture: String?
            self.shortDescription = shortDescription
            //	letoriginalURL: String
            self.mobileLink = mobileLink
            //	let originalMobileUrl: String?
            //	let articleID: Int
            self.sectionID = sectionID
            //	let sourceID: Int
            //	let highlight: Bool
            self.section = section
    }
    
    override var description: String {
        return "newsEntry: title=\(self.title), link=\(self.link), author=\(self.author), published=\(self.publishedDateJS), desc=\(self.shortDescription), mobileLink=\(self.mobileLink), sectionID=\(self.sectionID), section=\(section)"
    }
}
