import Foundation
import UIKit
import Capacitor

/// Druckt die aktuelle Seite (Bestellvordruck) über AirPrint.
/// Im Druckdialog kann über „Teilen“ auch ein PDF gesichert oder gemailt werden.
@objc(AufmassNativePlugin)
public class AufmassNativePlugin: CAPPlugin, CAPBridgedPlugin {
    public let identifier = "AufmassNativePlugin"
    public let jsName = "AufmassNative"
    public let pluginMethods: [CAPPluginMethod] = [
        CAPPluginMethod(name: "printPage", returnType: CAPPluginReturnPromise)
    ]

    @objc func printPage(_ call: CAPPluginCall) {
        let jobName = call.getString("name") ?? "Aufmass"
        DispatchQueue.main.async {
            guard let webView = self.bridge?.webView else {
                call.reject("WebView nicht verfügbar")
                return
            }
            let info = UIPrintInfo(dictionary: nil)
            info.outputType = .general
            info.jobName = jobName
            info.orientation = .landscape

            let controller = UIPrintInteractionController.shared
            controller.printInfo = info
            controller.printFormatter = webView.viewPrintFormatter()

            let done: UIPrintInteractionController.CompletionHandler = { _, completed, error in
                if let error = error {
                    call.reject(error.localizedDescription)
                } else {
                    call.resolve(["completed": completed])
                }
            }

            if UIDevice.current.userInterfaceIdiom == .pad, let view = self.bridge?.viewController?.view {
                let anchor = CGRect(x: view.bounds.midX, y: 80, width: 1, height: 1)
                controller.present(from: anchor, in: view, animated: true, completionHandler: done)
            } else {
                controller.present(animated: true, completionHandler: done)
            }
        }
    }
}
