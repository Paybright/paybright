PayBright iOS SDK
==============

PayBright iOS SDK is a library written in swift that allows you to add [PayBright](https://paybright.com/) as a payment option in your own app.

Installation
============

<strong> Carthage </strong>

Add the following to your Cartfile and follow the setup instructions [here](https://github.com/Carthage/Carthage#adding-frameworks-to-an-application).

```
github "Paybright/paybright"
```

Usage Overview
==============

PayBright integration consists of two steps: Configure and Checkout


## Configure

Set the API Key and token obtained from PayBright in PBConfig once (preferably in the AppDelegate's `didFinishLaunchingWithOptions`) as follows

```
PBConfig.shared.initialize(environment: .Sandbox, 
                           accountID:   "API_KEY", 
                           apiToken:    "API_TOKEN")
```

## Checkout

Checkout creation is the process in which a customer uses PayBright to pay for a purchase in your store. This process is governed by `PBInstance` object (which is set up in `PBConfig` shared object), and requires four parameters/objects:

- PBCustomer: details of the customer
- PBCustomerBilling: customer's billing address details
- PBCustomerShipping: customer's shipping address details
- PBProduct: item details


### Customer

```
let customerObj = PBCustomer.init(customerEmail:        "cs@paybright.com",
                                  customerFirstName:    "James",
                                  customerLastName:     "Testhetfield",
                                  customerPhone:        nil)
```

### Customer Billing

```
let customerBillingObj = PBCustomerBilling.init(customerBillingAddress1:    "270 Rue Olier",
                                                customerBillingAddress2:    nil,
                                                customerBillingCity:        "Chicoutimi",
                                                customerBillingCompany:     nil,
                                                customerBillingCountry:     "CA",
                                                customerBillingPhone:       "+1-613-987-6543",
                                                customerBillingState:       "QC",
                                                customerBillingZip:         "G7G 4J3")
```

### Customer Shipping

```
let customerShippingObj = PBCustomerShipping.init(customerShippingAddress1:     "270 Rue Olier",
                                                  customerShippingAddress2:     nil,
                                                  customerShippingCity:         "Chicoutimi",
                                                  customerShippingCompany:      "Shopify",
                                                  customerShippingCountry:      "CA",
                                                  customerShippingFirstName:    "James",
                                                  customerShippingLastName:     "Testhetfield",
                                                  customerShippingPhone:        "+1-613-987-6543",
                                                  customerShippingState:        "QC",
                                                  customerShippingZip:          "G7G 4J3")
```

### Product

```
let productObj = PBProduct.init(amount:         2625.0,
                                currency:       "CAD",
                                description:    "PaymentGatewayTesting - #4682855809085",
                                invoice:        "#4682855809085",
                                planID:         nil,
                                platform:       "sdk",
                                reference:      "4682855809085",
                                shopCountry:    "CA",
                                shopName:       "PaymentGatewayTesting",
                                urlCallback:    "https://checkout.shopify.com/services/ping/notify_integration/paybright/19629019",
                                urlCancel:      "https://paymentgatewaytesting.myshopify.com/19629019/checkouts/84044f7a52ff18a84dd1f2b5cd46b387?key=0c4978718a87a00e5ac1456b577b5695",
                                urlComplete:    "https://paymentgatewaytesting.myshopify.com/19629019/checkouts/84044f7a52ff18a84dd1f2b5cd46b387/offsite_gateway_callback")
```

### Instance

```
let instanceObj = PBInstance.init(customerObj:          customerObj,
                                  customerBillingObj:   customerBillingObj,
                                  customerShippingObj:  customerShippingObj,
                                  productObj:           productObj)
```

Once the `PBInstance` has been constructed, set it in `PBConfig` shared object and you may use `PBViewController`. This initiates the flow which guides the user through the PayBright checkout process. An example of how this is implemented is provided as follows

```
PBConfig.shared.instanceObj = instanceObj


let pbVC :PBViewController = PBViewController.init(nibName: "PBViewController", bundle: Bundle(for: PBViewController.self))

pbVC.delegate = self

self.navigationController?.pushViewController(pbVC, animated: true)
```

The flow ends once the user has successfully confirmed the checkout, canceled the checkout, or encountered an error in the process. In each of these cases, PayBright will send a message to the `PBWebViewDelegate` along with additional information about the result.


Requirements
=======

Xcode 10 is required to use PayBright
