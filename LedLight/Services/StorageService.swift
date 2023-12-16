//
//  StorageService.swift
//  LedLight
//
//  Created by Alexandr Rodionov on 9.12.23.
//

import Foundation
import CoreBluetooth
import Combine

enum StorageKeys: String {
    case peripheralsList
    case lastPeripheral
}

final class StorageService {
    
    static let shared: StorageService = .init()
    private init() {}
    
    var savedPeripherals: CurrentValueSubject<[PeripheralData], Never> = .init([])
    
    // MARK: - public methods for saving / loading
    
    func savePeripheralToStorage(peripheral: PeripheralData, name: StorageKeys.RawValue) {
        var existingPeripherals = loadPeripheralsList(nameOfPeripheralsList: name) ?? []

        // Проверка, есть ли устройство с таким UUID уже в массиве
        if !existingPeripherals.contains(where: { $0.uuid == peripheral.uuid }) {
            // Если нет, добавляем в массив
            existingPeripherals.append(peripheral)
            save(existingPeripherals, key: name)
            savedPeripherals.send(existingPeripherals)
        } else {
            // Если уже есть, не добавляем, можем вывести сообщение или выполнить другие действия
            print("Устройство с UUID \(peripheral.uuid) уже существует в массиве.")
        }
    }

    
    func loadPeripheralsList(nameOfPeripheralsList: StorageKeys.RawValue) -> [PeripheralData]? {
        load(key: nameOfPeripheralsList)
    }
    
    func deletePeripheralsList(nameOfPeripheralsList: StorageKeys.RawValue) {
        UserDefaults.standard.removeObject(forKey: nameOfPeripheralsList)
        savedPeripherals.send([])
    }
    
    func removePeripheral(peripheral: PeripheralData, name: StorageKeys.RawValue) {
        var existingPeripherals = loadPeripheralsList(nameOfPeripheralsList: name) ?? []
        existingPeripherals.removeAll { $0.uuid == peripheral.uuid }
        save(existingPeripherals, key: name)
        savedPeripherals.send(existingPeripherals)
    }
    
    func saveLastPeripheral(peripheral: PeripheralData, name: StorageKeys.RawValue) {
        save(peripheral, key: name)
    }
    
    func loadLastPeripheral(name: StorageKeys.RawValue) -> PeripheralData? {
        load(key: name)
    }
    
    
    // MARK: - private save / load methods
    
    private func save<T: Codable>(_ object: T, key: String) {
        do {
            let data = try JSONEncoder().encode(object)
            UserDefaults.standard.set(data, forKey: key)
            UserDefaults.standard.synchronize()
        } catch {
            print("\(T.Type.self) saving failed")
        }
    }
    
    private func load<T: Codable>(key: String) -> T? {
        guard let data = UserDefaults.standard.data(forKey: key) else { return nil }
        do {
            let object = try JSONDecoder().decode(T.self, from: data)
            return object
        } catch {
            print("\(T.Type.self) loading failed")
            return nil
        }
    }
}
