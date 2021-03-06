import XCTest

class StorageGeneralTests: XCTestCase {
    override func setUp() {
        super.setUp()
        
        let cacheDir = UADSSdkProperties.getCacheDirectory()
        let type = UnityAdsStorageType.init(rawValue: 1)
        
        UADSStorageManager.addStorageLocation(cacheDir + "/test.data", forStorageType: type!)
        UADSStorageManager.initStorage(type!)
        
        let storage:UADSStorage? = UADSStorageManager.getStorage(type!)
        if (storage != nil) {
            NSLog("Clearing storage")
            storage?.clearStorage()
            storage?.initStorage()
        }
        else {
            NSLog("Storage is NULL")
        }
    }

    func testSetAndGetInteger () {
        let type = UnityAdsStorageType.init(rawValue: 1)
        let storage:UADSStorage = UADSStorageManager.getStorage(type!)
        let value:NSNumber = NSNumber.init(int: 12345)
        storage.setValue(value, forKey: "tests.integer")
        storage.writeStorage()
        storage.clearData()
        storage.readStorage()
        
        let valueInStorage:NSNumber = storage.getValueForKey("tests.integer") as! NSNumber

        XCTAssertNotNil(value, "Current value should not be NULL")
        XCTAssertNotNil(valueInStorage, "Value from storage should not be NULL")
        XCTAssertEqual(valueInStorage, value, "Value not what was expected")
    }
    
    func testSetAndGetBoolean () {
        let type = UnityAdsStorageType.init(rawValue: 1)
        let storage:UADSStorage = UADSStorageManager.getStorage(type!)
        let value = true
        storage.setValue(value, forKey: "tests.boolean")
        storage.writeStorage()
        storage.clearData()
        storage.readStorage()
        
        let valueInStorage = storage.getValueForKey("tests.boolean") as! Bool

        XCTAssertNotNil(value, "Current value should not be NULL")
        XCTAssertNotNil(valueInStorage, "Value from storage should not be NULL")
        XCTAssertEqual(valueInStorage, value, "Value not what was expected")
    }
    
    func testSetAndGetLong () {
        let type = UnityAdsStorageType.init(rawValue: 1)
        let storage:UADSStorage = UADSStorageManager.getStorage(type!)
        let value:NSNumber = NSNumber.init(longLong: 123451234512345)
        storage.setValue(value, forKey: "tests.long")
        storage.writeStorage()
        storage.clearData()
        storage.readStorage()
        
        let valueInStorage:NSNumber = storage.getValueForKey("tests.long") as! NSNumber

        XCTAssertNotNil(value, "Current value should not be NULL")
        XCTAssertNotNil(valueInStorage, "Value from storage should not be NULL")
        XCTAssertEqual(valueInStorage, value, "Value not what was expected")
    }
    
    func testSetAndGetDouble () {
        let type = UnityAdsStorageType.init(rawValue: 1)
        let storage:UADSStorage = UADSStorageManager.getStorage(type!)
        let value:NSNumber = NSNumber.init(double: 12345.12345)
        storage.setValue(value, forKey: "tests.double")
        storage.writeStorage()
        storage.clearData()
        storage.readStorage()
        
        let valueInStorage:NSNumber = storage.getValueForKey("tests.double") as! NSNumber

        XCTAssertNotNil(value, "Current value should not be NULL")
        XCTAssertNotNil(valueInStorage, "Value from storage should not be NULL")
        XCTAssertEqual(valueInStorage, value, "Value not what was expected")
    }
    
    func testSetAndGetString () {
        let type = UnityAdsStorageType.init(rawValue: 1)
        let storage:UADSStorage = UADSStorageManager.getStorage(type!)
        let value:NSString = NSString.init(string: "Hello World")
        storage.setValue(value, forKey: "tests.string")
        storage.writeStorage()
        storage.clearData()
        storage.readStorage()
        
        let valueInStorage:NSString = storage.getValueForKey("tests.string") as! NSString

        XCTAssertNotNil(value, "Current value should not be NULL")
        XCTAssertNotNil(valueInStorage, "Value from storage should not be NULL")
        XCTAssertEqual(valueInStorage, value, "Value not what was expected")
    }
    
    func testSetAndGetDictionary () {
        let type = UnityAdsStorageType.init(rawValue: 1)
        let storage:UADSStorage = UADSStorageManager.getStorage(type!)
        let value:NSDictionary = NSDictionary.init(dictionary: ["testkey" : "testvalue"])
        storage.setValue(value, forKey: "tests.dictionary")
        storage.writeStorage()
        storage.clearData()
        storage.readStorage()
        
        let valueInStorage:NSDictionary = storage.getValueForKey("tests.dictionary") as! NSDictionary
        
        XCTAssertNotNil(value, "Current value should not be NULL")
        XCTAssertNotNil(valueInStorage, "Value from storage should not be NULL")
        XCTAssertEqual(valueInStorage, value, "Value not what was expected")
    }
    
    func testSetAndGetArray () {
        let type = UnityAdsStorageType.init(rawValue: 1)
        let storage:UADSStorage = UADSStorageManager.getStorage(type!)
        let value:NSArray = NSArray.init(array: [1, "test1"])
        storage.setValue(value, forKey: "tests.array")
        storage.writeStorage()
        storage.clearData()
        storage.readStorage()
        
        let valueInStorage:NSArray = storage.getValueForKey("tests.array") as! NSArray
        
        XCTAssertNotNil(value, "Current value should not be NULL")
        XCTAssertNotNil(valueInStorage, "Value from storage should not be NULL")
        XCTAssertEqual(valueInStorage, value, "Value not what was expected")
    }
    
    func testWriteAndRead () {
        let type = UnityAdsStorageType.init(rawValue: 1)
        let storage:UADSStorage = UADSStorageManager.getStorage(type!)
        let value1:NSNumber = NSNumber.init(int: 12345)
        let value2:NSString = NSString.init(string: "Testing")
        let value3:NSNumber = NSNumber.init(double: 12345.12345)
        
        XCTAssertEqual(false, storage.hasData(), "Storage should hold no data in the beginning of the test")
        XCTAssertEqual(true, storage.setValue(value1, forKey: "tests.value1"), "Should have been able to set key \"tests.value1\" with value: 12345")
        XCTAssertEqual(true, storage.setValue(value2, forKey: "tests.value2"), "Should have been able to set key \"tests.value2\" with value: Testing")
        XCTAssertEqual(true, storage.setValue(value3, forKey: "tests.value3"), "Should have been able to set key \"tests.value3\" with value: 12345.12345")
        XCTAssertEqual(true, storage.writeStorage(), "Write storage should have succeeded")
        
        storage.clearData()
        
        XCTAssertEqual(false, storage.hasData(), "Storage was reset, should hold no data")
        XCTAssertEqual(true, storage.readStorage(), "Read storage failed for some reason even though it shouldn't have")
        XCTAssertEqual(true, storage.hasData(), "Storage should contain data since some keys were written into it")
        
        XCTAssertNotNil(storage.getValueForKey("tests.value1"), "First value should not be NULL")
        XCTAssertEqual(value1, storage.getValueForKey("tests.value1") as? NSNumber, "First value was not what was expected")
        XCTAssertNotNil(storage.getValueForKey("tests.value2"), "Second value should not be NULL")
        XCTAssertEqual(value2, storage.getValueForKey("tests.value2") as? NSString, "Second value was not what was expected")
        XCTAssertNotNil(storage.getValueForKey("tests.value3"), "Third value should not be NULL")
        XCTAssertEqual(value3, storage.getValueForKey("tests.value3") as? NSNumber, "Third value was not what was expected")
    }
    
    func testMultiLevelValue () {
        let type = UnityAdsStorageType.init(rawValue: 1)
        let storage:UADSStorage = UADSStorageManager.getStorage(type!)
        let value1:NSNumber = NSNumber.init(int: 12345)
        
        XCTAssertEqual(false, storage.hasData(), "Storage should hold no data in the beginning of the test")
        XCTAssertEqual(true, storage.setValue(value1, forKey: "level1.level2.level3.level4.level5"), "Should have been able to set key \"level1.level2.level3.level4.level5\" with value: 12345")
        XCTAssertEqual(true, storage.writeStorage(), "Write storage should have succeeded")
        
        storage.clearData()
        
        XCTAssertEqual(false, storage.hasData(), "Storage was reset, should hold no data")
        XCTAssertEqual(true, storage.readStorage(), "Read storage failed for some reason even though it shouldn't have")
        XCTAssertEqual(true, storage.hasData(), "Storage should contain data since some keys were written into it")
        XCTAssertEqual(value1, storage.getValueForKey("level1.level2.level3.level4.level5") as? NSNumber, "Third value was not what was expected")
    }
    
    func testSingleLevelValue () {
        let type = UnityAdsStorageType.init(rawValue: 1)
        let storage:UADSStorage = UADSStorageManager.getStorage(type!)
        let value1:NSNumber = NSNumber.init(int: 12345)
        
        XCTAssertEqual(false, storage.hasData(), "Storage should hold no data in the beginning of the test")
        XCTAssertEqual(true, storage.setValue(value1, forKey: "level1"), "Should have been able to set key \"level1\" with value: 12345")
        XCTAssertEqual(true, storage.writeStorage(), "Write storage should have succeeded")
        
        storage.clearData()
        
        XCTAssertEqual(false, storage.hasData(), "Storage was reset, should hold no data")
        XCTAssertEqual(true, storage.readStorage(), "Read storage failed for some reason even though it shouldn't have")
        XCTAssertEqual(true, storage.hasData(), "Storage should contain data since some keys were written into it")
        XCTAssertEqual(value1, storage.getValueForKey("level1") as? NSNumber, "Third value was not what was expected")
    }
    
    func testDelete () {
        let type = UnityAdsStorageType.init(rawValue: 1)
        let storage:UADSStorage = UADSStorageManager.getStorage(type!)
        let value1:NSNumber = NSNumber.init(int: 12345)
        XCTAssertEqual(false, storage.hasData(), "Storage should hold no data in the beginning of the test: ")
        XCTAssertEqual(true, storage.setValue(value1, forKey: "tests.deletethis"), "Should have been able to set key \"tests.deletethis\" with value: 12345")
        XCTAssertEqual(true, storage.writeStorage(), "Write storage should have succeeded")
        
        storage.clearData()
        
        XCTAssertEqual(false, storage.hasData(), "Storage was reset, should hold no data")
        XCTAssertEqual(true, storage.readStorage(), "Read storage failed for some reason even though it shouldn't have")
        XCTAssertEqual(true, storage.hasData(), "Storage should contain data since some keys were written into it")
        XCTAssertEqual(value1, storage.getValueForKey("tests.deletethis") as? NSNumber, "Value was not what was expected")
        XCTAssertEqual(true, storage.deleteKey("tests.deletethis"), "Should've been able to delete key")
        XCTAssertEqual(true, storage.writeStorage(), "Write storage should have succeeded")
        
        storage.clearData()

        XCTAssertEqual(false, storage.hasData(), "Storage was reset, should hold no data")
        XCTAssertEqual(true, storage.readStorage(), "Read storage failed for some reason even though it shouldn't have")
        XCTAssertNil(storage.getValueForKey("tests.deletethis"), "Storage should be empty but wasn't")
    }
    
    func testGetKeys () {
        let type = UnityAdsStorageType.init(rawValue: 1)
        let storage:UADSStorage = UADSStorageManager.getStorage(type!)
        let value:NSNumber = NSNumber.init(int: 12345)
        let expected:NSArray = ["DB62D2FF-F4F3-4050-BC22-EE7242638F71", "EC71F5DB-D8B8-466B-B878-FEF018298493", "7D2526C4-8123-4068-B481-0EB9680BE974"];
        
        storage.setValue(value, forKey: "session.DB62D2FF-F4F3-4050-BC22-EE7242638F71.ts")
        storage.setValue(value, forKey: "session.DB62D2FF-F4F3-4050-BC22-EE7242638F71.operative.179BBFDA-D3C1-4137-8485-F8ECADE5E605.data")

        storage.writeStorage()
        storage.clearData()
        storage.readStorage()

        storage.setValue(value, forKey: "session.EC71F5DB-D8B8-466B-B878-FEF018298493.ts")
        storage.setValue(value, forKey: "session.EC71F5DB-D8B8-466B-B878-FEF018298493.operative.179BBFDA-D3C1-4137-8485-F8ECADE5E605.data")

        storage.writeStorage()
        storage.clearData()
        storage.readStorage()
        
        storage.setValue(value, forKey: "session.7D2526C4-8123-4068-B481-0EB9680BE974.ts")
        storage.setValue(value, forKey: "session.7D2526C4-8123-4068-B481-0EB9680BE974.operative.179BBFDA-D3C1-4137-8485-F8ECADE5E605.data")

        
        let keys:NSArray = storage.getKeys("session", recursive: false);
        
        XCTAssertEqual(expected.count, keys.count, "Expected an actual key amount differ")
        
        for key in keys {
            XCTAssertTrue(expected.containsObject(key), "Expected keys don't contain key")
        }
    }
    
    func testGetKeysNonRecursive () {
        let type = UnityAdsStorageType.init(rawValue: 1)
        let storage:UADSStorage = UADSStorageManager.getStorage(type!)
        let value:NSNumber = NSNumber.init(int: 12345)
        let expected:NSArray = ["DB62D2FF-F4F3-4050-BC22-EE7242638F71", "EC71F5DB-D8B8-466B-B878-FEF018298493", "7D2526C4-8123-4068-B481-0EB9680BE974"];
        
        storage.setValue(value, forKey: "session.DB62D2FF-F4F3-4050-BC22-EE7242638F71.ts")
        storage.setValue("heips", forKey: "session.DB62D2FF-F4F3-4050-BC22-EE7242638F71.operative.179BBFDA-D3C1-4137-8485-F8ECADE5E605.data")
        storage.setValue("http://moi.com", forKey: "session.DB62D2FF-F4F3-4050-BC22-EE7242638F71.operative.179BBFDA-D3C1-4137-8485-F8ECADE5E605.url")
        
        storage.writeStorage()
        storage.deleteKey("session.DB62D2FF-F4F3-4050-BC22-EE7242638F71.operative.179BBFDA-D3C1-4137-8485-F8ECADE5E605");
        storage.writeStorage()
        storage.clearData()
        
        storage.readStorage()
        
        storage.setValue(value, forKey: "session.EC71F5DB-D8B8-466B-B878-FEF018298493.ts")
        storage.setValue(value, forKey: "session.EC71F5DB-D8B8-466B-B878-FEF018298493.operative.179B2FDA-D3C1-4137-8485-F8ECADE5E605.data")
        storage.setValue("http://moi.com", forKey: "session.EC71F5DB-D8B8-466B-B878-FEF018298493.operative.179B2FDA-D3C1-4137-8485-F8ECADE5E605.url")
        
        storage.writeStorage()
        storage.deleteKey("session.EC71F5DB-D8B8-466B-B878-FEF018298493.operative.179B2FDA-D3C1-4137-8485-F8ECADE5E605");
        storage.writeStorage()
        storage.clearData()
        
        storage.readStorage()

        storage.setValue(value, forKey: "session.7D2526C4-8123-4068-B481-0EB9680BE974.ts")
        storage.setValue(value, forKey: "session.7D2526C4-8123-4068-B481-0EB9680BE974.operative.179B4FDA-D3C1-4137-8485-F8ECADE5E605.data")
        storage.setValue("http://moi.com", forKey: "session.7D2526C4-8123-4068-B481-0EB9680BE974.operative.179B4FDA-D3C1-4137-8485-F8ECADE5E605.url")
        
        storage.writeStorage()
        storage.deleteKey("session.7D2526C4-8123-4068-B481-0EB9680BE974.operative.179B4FDA-D3C1-4137-8485-F8ECADE5E605");
        storage.writeStorage()
        storage.clearData()
        
        storage.readStorage()

        let keys:NSArray = storage.getKeys("session", recursive: false);
        
        NSLog("%@", keys);
        
        XCTAssertEqual(expected.count, keys.count, "Expected an actual key amount differ")
        
        for key in keys {
            XCTAssertTrue(expected.containsObject(key), "Expected keys don't contain key")
        }
    }
    
    func testGetKeysRecursive () {
        let type = UnityAdsStorageType.init(rawValue: 1)
        let storage:UADSStorage = UADSStorageManager.getStorage(type!)
        let value:NSNumber = NSNumber.init(int: 12345)
        let expected:NSArray = [
            "DB62D2FF-F4F3-4050-BC22-EE7242638F71",
            "DB62D2FF-F4F3-4050-BC22-EE7242638F71.ts",
            "DB62D2FF-F4F3-4050-BC22-EE7242638F71.operative",
            
            "EC71F5DB-D8B8-466B-B878-FEF018298493",
            "EC71F5DB-D8B8-466B-B878-FEF018298493.ts",
            "EC71F5DB-D8B8-466B-B878-FEF018298493.operative",
            
            "7D2526C4-8123-4068-B481-0EB9680BE974",
            "7D2526C4-8123-4068-B481-0EB9680BE974.ts",
            "7D2526C4-8123-4068-B481-0EB9680BE974.operative",
        ];
        
        storage.setValue(value, forKey: "session.DB62D2FF-F4F3-4050-BC22-EE7242638F71.ts")
        storage.setValue("heips", forKey: "session.DB62D2FF-F4F3-4050-BC22-EE7242638F71.operative.179BBFDA-D3C1-4137-8485-F8ECADE5E605.data")
        storage.setValue("http://moi.com", forKey: "session.DB62D2FF-F4F3-4050-BC22-EE7242638F71.operative.179BBFDA-D3C1-4137-8485-F8ECADE5E605.url")
        
        storage.writeStorage()
        storage.deleteKey("session.DB62D2FF-F4F3-4050-BC22-EE7242638F71.operative.179BBFDA-D3C1-4137-8485-F8ECADE5E605");
        storage.writeStorage()
        storage.clearData()
        
        storage.readStorage()
        
        storage.setValue(value, forKey: "session.EC71F5DB-D8B8-466B-B878-FEF018298493.ts")
        storage.setValue(value, forKey: "session.EC71F5DB-D8B8-466B-B878-FEF018298493.operative.179B2FDA-D3C1-4137-8485-F8ECADE5E605.data")
        storage.setValue("http://moi.com", forKey: "session.EC71F5DB-D8B8-466B-B878-FEF018298493.operative.179B2FDA-D3C1-4137-8485-F8ECADE5E605.url")
        
        storage.writeStorage()
        storage.deleteKey("session.EC71F5DB-D8B8-466B-B878-FEF018298493.operative.179B2FDA-D3C1-4137-8485-F8ECADE5E605");
        storage.writeStorage()
        storage.clearData()
        
        storage.readStorage()
        
        storage.setValue(value, forKey: "session.7D2526C4-8123-4068-B481-0EB9680BE974.ts")
        storage.setValue(value, forKey: "session.7D2526C4-8123-4068-B481-0EB9680BE974.operative.179B4FDA-D3C1-4137-8485-F8ECADE5E605.data")
        storage.setValue("http://moi.com", forKey: "session.7D2526C4-8123-4068-B481-0EB9680BE974.operative.179B4FDA-D3C1-4137-8485-F8ECADE5E605.url")
        
        storage.writeStorage()
        storage.deleteKey("session.7D2526C4-8123-4068-B481-0EB9680BE974.operative.179B4FDA-D3C1-4137-8485-F8ECADE5E605");
        storage.writeStorage()
        storage.clearData()
        
        storage.readStorage()
        
        let keys:NSArray = storage.getKeys("session", recursive: true);
        
        NSLog("%@", keys);
        
        XCTAssertEqual(expected.count, keys.count, "Expected an actual key amount differ")
        
        for key in keys {
            XCTAssertTrue(expected.containsObject(key), "Expected keys don't contain key")
        }
    }
}