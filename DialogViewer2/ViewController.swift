//
//  ViewController.swift
//  DialogViewer2
//
//  Created by wanghuiyong on 26/01/2017.
//  Copyright © 2017 Personal Organization. All rights reserved.
//

import UIKit

class ViewController: UICollectionViewController, UICollectionViewDelegateFlowLayout {
    private var sections: [[String: String]]!

    override func viewDidLoad() {
        super.viewDidLoad()
        
        sections = [
            ["header": "First Witch",  "content": "Hey, when will the three of us meet up later?" ],
            ["header": "Second Witch", "content": "When everything's straightened out." ],
            ["header": "Third Witch",  "content": "That'll be just before sunset." ],
            ["header": "First Witch",  "content": "Where?" ],	
            ["header": "Second Witch", "content": "The dirt patch." ],
            ["header": "Third Witch",  "content": "I guess we'll see Mac there." ],
        ];
        
        collectionView?.register(ContentCell.self, forCellWithReuseIdentifier: "CONTENT")
        
        var contentInsert = collectionView?.contentInset
        contentInsert?.top = 20
        collectionView?.contentInset = contentInsert!
        
        let layout = collectionView?.collectionViewLayout	// UICollectionViewLayout 类型
        let flow = layout as! UICollectionViewFlowLayout		// 强制转换为子类
        flow.sectionInset = UIEdgeInsetsMake(10, 20, 30, 20)
        
        collectionView?.register(HeaderCell.self, forSupplementaryViewOfKind: UICollectionElementKindSectionHeader, withReuseIdentifier: "HEADER")
        
        flow.headerReferenceSize = CGSize.init(width: 100, height: 25)

    }
    
    // MARK: - Collection View Data Source
    
    override func numberOfSections(in collectionView: UICollectionView) -> Int {
        return sections.count
    }
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        let words = wordsInSecton(section: section)
        return words.count
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let words = wordsInSecton(section: indexPath.section)
        // 创建并初始化内容 cell
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "CONTENT", for: indexPath) as! ContentCell
        cell.maxWidth = collectionView.bounds.size.width
        cell.text = words[indexPath.row]
        return cell
    }
    
    override func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        if (kind == UICollectionElementKindSectionHeader) {
            // 创建并初始化标题 cell
            let cell = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: "HEADER", for: indexPath) as! HeaderCell
            cell.maxWidth = collectionView.bounds.size.width
            cell.text = sections[indexPath.section]["header"]
            return cell
        }
        abort()
    }

    // MARK: - Collection View Delegate Flow Layout
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let words = wordsInSecton(section: indexPath.section)
        let size = ContentCell.sizeForContentString(str: words[indexPath.row], forMaxWidth: collectionView.bounds.size.width)
        
        return size
    }
    
    // MARK: - My Own Functons
    
    func wordsInSecton(section: Int) -> [String] {
        let content = sections[section]["content"]
        let spaces = NSCharacterSet.whitespacesAndNewlines
        let words = content?.components(separatedBy: spaces)
        return words!
    }
}

