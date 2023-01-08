import Foundation
import AsyncBluetooth
import CoreBluetooth
import AsyncTimeSequences

let arguments = ProcessInfo.processInfo.arguments

if arguments.count < 2 {
    print(
    """
    Usage: BluetoothCheck <Bluetooth service UUID>
    """
    )
    exit(1)
}

let service = arguments[1]

guard let serviceUUID = UUID(uuidString: service) else {
    print("No a valid service UUID: \(service)")
    exit(5)
}

let centralManager = CentralManager()

if (try? await centralManager.waitUntilReady()) == nil {
    print("Not allowed to use Bluetooth")
    exit(4)
}

let scanDataStream = try await centralManager.scanForPeripherals(withServices: [])
// CBUUID(string: service)


do {
    for try await scanData in scanDataStream.timeout(for: 10, scheduler: MainAsyncScheduler.default) {

//        break
        let found = scanData
        if let name = found.advertisementData[CBAdvertisementDataLocalNameKey] {
            print("name:", name)
            print("RSSI: ", found.rssi)
        }
    }
} catch {
    await centralManager.stopScan()
    exit(2)
}
//
//var exitCode: Int32 = 2
//if let found = await scanDataStream.timeout(for: 10, scheduler: MainAsyncScheduler.default).first() {
//    if let name = found.advertisementData[CBAdvertisementDataLocalNameKey] {
//        print("name:", name)
//    }
//    print("RSSI: ", found.rssi)
//    exitCode = 0
//}
await centralManager.stopScan()
exit(0)


extension AsyncSequence {
    func first() async -> Element? {
        try? await first(where: { _ in true })
    }
}
