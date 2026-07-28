import Foundation
import Observation
import StoreKit

public protocol Store {
  var hasAppLicense: Bool { get }
}

@MainActor
@Observable
public final class MyStore: Store {
  static let productID = "com.xp123.betwist_test123"

  public var hasAppLicense: Bool = false

  public init() {
    // Because the tasks below capture 'self' in their closures,
    // this object must be fully initialized before this point.

    Task(priority: .background) {
      // Finish any unfinished transactions -- for example, if the app was
      // terminated before finishing a transaction.
      for await verificationResult in Transaction.unfinished {
        await handle(updatedTransaction: verificationResult)
      }

      for await verificationResult in Transaction.currentEntitlements {
        await handle(updatedTransaction: verificationResult)
      }
    }
    Task(priority: .background) {
      for await verificationResult in Transaction.updates {
        await handle(updatedTransaction: verificationResult)
      }
    }
  }

  private func handle(
    updatedTransaction verificationResult: VerificationResult<Transaction>
  ) async {
    guard case .verified(let transaction) = verificationResult else { return }

    guard Self.productID == transaction.productID else {
      print("Unexpected product: \(transaction.productID).")
      return
    }

    if transaction.revocationDate != nil {
      // `Transaction.revocationReason` provides details about the revoked transaction.

      hasAppLicense = false
      print("revoked product \(Self.productID)")

      await transaction.finish()
      return
    } else {
      // Provide access to the product identified by transaction.productID.
      print(
        "transaction ID \(transaction.id), product ID \(transaction.productID)"
      )

      hasAppLicense = true

      await transaction.finish()
      return
    }
  }
}
