//
//  Utils.swift
//  PropertyHero
//
//  Created by KHOI LE on 8/6/23.
//

import Foundation

enum AccountStatus: Int {
    case accLocked = 200
}

enum AccountType: Int {
    case hero = 0
    case facebook = 1
    case google = 2
}

enum Constants: Int {
    case undefined = 254
}

enum TabCollection: Int {
    case favorite = 0
    case view = 1
}

enum TabSearch: Int {
    case marker = 0
    case location = 1
}

enum TabMenu: Int {
    case more = 0
    case notification = 1
    case collection = 2
    case search = 3
    case home = 4
}

enum PropertyType: Int {
    case all = 254
    case house = 0
    case apartment = 1
    case room = 2
}

enum CountryId: Int {
    case vietnam = 1
}

enum OptionChoice {
    case all
    case apartment
    case room
}

enum SectionType {
    case banner
    case findByArea
}

