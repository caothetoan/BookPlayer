//
//  Playlist+CoreDataClass.swift
//  BookPlayer
//
//  Created by Gianni Carlo on 5/9/18.
//  Copyright © 2018 Tortuga Power. All rights reserved.
//
//

import Foundation
import CoreData

public class Playlist: LibraryItem {
    func itemIndex(with url: URL) -> Int? {
        let hash = url.deletingPathExtension().lastPathComponent

        guard let books = self.books?.array as? [Book] else {
            return nil
        }

        return books.index { (storedBook) -> Bool in
            return storedBook.identifier == hash
        }
    }

    func getBook(at index: Int) -> Book? {
        guard let books = self.books?.array as? [Book] else {
            return nil
        }

        return books[index]
    }

    func info() -> String {
        let count = self.books?.array.count ?? 0
        return "\(count) Files"
    }
    convenience init(title: String, books: [Book], context: NSManagedObjectContext) {
        let entity = NSEntityDescription.entity(forEntityName: "Playlist", in: context)!
        self.init(entity: entity, insertInto: context)
        self.identifier = title
        self.title = title
        self.desc = "\(books.count) Files"
        self.addToBooks(NSOrderedSet(array: books))
    }
}
