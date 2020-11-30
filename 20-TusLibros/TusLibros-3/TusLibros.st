!classDefinition: #CartTest category: 'TusLibros'!
TestCase subclass: #CartTest
	instanceVariableNames: 'testObjectsFactory'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibros'!

!CartTest methodsFor: 'tests' stamp: 'HernanWilkinson 6/17/2013 18:10'!
test01NewCartsAreCreatedEmpty

	self assert: testObjectsFactory createCart isEmpty! !

!CartTest methodsFor: 'tests' stamp: 'NNH 11/27/2020 21:03:53'!
test02CanNotAddItemsThatDoNotBelongToStore

	| cart |
	
	cart := testObjectsFactory createCart.
	
	self 
		should: [ cart add: testObjectsFactory itemNotSellByTheStore ]
		raise: Error - MessageNotUnderstood
		withExceptionDo: [ :anError |
			self assert: anError messageText = Cart invalidItemErrorMessage.
			self assert: cart isEmpty ]! !

!CartTest methodsFor: 'tests' stamp: 'HernanWilkinson 6/17/2013 18:10'!
test03AfterAddingAnItemTheCartIsNotEmptyAnymore

	| cart |
	
	cart := testObjectsFactory createCart.
	
	cart add: testObjectsFactory itemSellByTheStore.
	self deny: cart isEmpty ! !

!CartTest methodsFor: 'tests' stamp: 'NNH 11/27/2020 21:03:59'!
test04CanNotAddNonPositiveNumberOfItems

	| cart |
	
	cart := testObjectsFactory createCart.
	
	self 
		should: [cart add: 0 of: testObjectsFactory itemSellByTheStore ]
		raise: Error - MessageNotUnderstood
		withExceptionDo: [ :anError |
			self assert: anError messageText = Cart invalidQuantityErrorMessage.
			self assert: cart isEmpty ]! !

!CartTest methodsFor: 'tests' stamp: 'NNH 11/27/2020 21:04:03'!
test05CanNotAddMoreThanOneItemNotSellByTheStore

	| cart |
	
	cart := testObjectsFactory createCart.
	
	self 
		should: [cart add: 2 of: testObjectsFactory itemNotSellByTheStore  ]
		raise: Error - MessageNotUnderstood
		withExceptionDo: [ :anError |
			self assert: anError messageText = Cart invalidItemErrorMessage.
			self assert: cart isEmpty ]! !

!CartTest methodsFor: 'tests' stamp: 'HernanWilkinson 6/17/2013 18:11'!
test06CartRemembersAddedItems

	| cart |
	
	cart := testObjectsFactory createCart.
	
	cart add: testObjectsFactory itemSellByTheStore.
	self assert: (cart includes: testObjectsFactory itemSellByTheStore)! !

!CartTest methodsFor: 'tests' stamp: 'HernanWilkinson 6/17/2013 18:11'!
test07CartDoesNotHoldNotAddedItems

	| cart |
	
	cart := testObjectsFactory createCart.
	
	self deny: (cart includes: testObjectsFactory itemSellByTheStore)! !

!CartTest methodsFor: 'tests' stamp: 'HernanWilkinson 6/17/2013 18:11'!
test08CartRemembersTheNumberOfAddedItems

	| cart |
	
	cart := testObjectsFactory createCart.
	
	cart add: 2 of: testObjectsFactory itemSellByTheStore.
	self assert: (cart occurrencesOf: testObjectsFactory itemSellByTheStore) = 2! !


!CartTest methodsFor: 'setup' stamp: 'HernanWilkinson 6/17/2013 18:09'!
setUp 

	testObjectsFactory := StoreTestObjectsFactory new.! !


!classDefinition: #CashierTest category: 'TusLibros'!
TestCase subclass: #CashierTest
	instanceVariableNames: 'testObjectsFactory debitBehavior'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibros'!

!CashierTest methodsFor: 'tests' stamp: 'HernanWilkinson 6/17/2013 18:50'!
test01CanNotCheckoutAnEmptyCart

	| salesBook |
	
	salesBook := OrderedCollection new.
	self 
		should: [ Cashier 
			toCheckout: testObjectsFactory createCart 
			charging: testObjectsFactory notExpiredCreditCard 
			throught: self
			on: testObjectsFactory today
			registeringOn:  salesBook ]
		raise: Error - MessageNotUnderstood
		withExceptionDo: [ :anError |
			self assert: anError messageText = Cashier cartCanNotBeEmptyErrorMessage.
			self assert: salesBook isEmpty ]! !

!CashierTest methodsFor: 'tests' stamp: 'HernanWilkinson 6/17/2013 18:51'!
test02CalculatedTotalIsCorrect

	| cart cashier |
	
	cart := testObjectsFactory createCart.
	cart add: 2 of: testObjectsFactory itemSellByTheStore.
	
	cashier :=  Cashier
		toCheckout: cart 
		charging: testObjectsFactory notExpiredCreditCard 
		throught: self
		on: testObjectsFactory today 
		registeringOn: OrderedCollection new.
		
	self assert: cashier checkOut = (testObjectsFactory itemSellByTheStorePrice * 2)! !

!CashierTest methodsFor: 'tests' stamp: 'HernanWilkinson 6/17/2013 18:51'!
test03CanNotCheckoutWithAnExpiredCreditCart

	| cart salesBook |

	cart := testObjectsFactory createCart.
	cart add: testObjectsFactory itemSellByTheStore.
	salesBook := OrderedCollection new.
	
	self
		should: [ Cashier 
				toCheckout: cart 
				charging: testObjectsFactory expiredCreditCard 
				throught: self
				on: testObjectsFactory today
				registeringOn: salesBook ]
		raise: Error - MessageNotUnderstood
		withExceptionDo: [ :anError | 
			self assert: anError messageText = Cashier canNotChargeAnExpiredCreditCardErrorMessage.
			self assert: salesBook isEmpty ]! !

!CashierTest methodsFor: 'tests' stamp: 'HernanWilkinson 6/17/2013 19:04'!
test04CheckoutRegistersASale

	| cart cashier salesBook total |

	cart := testObjectsFactory createCart.
	cart add: testObjectsFactory itemSellByTheStore.
	salesBook := OrderedCollection new.
 
	cashier:= Cashier 
		toCheckout: cart 
		charging: testObjectsFactory notExpiredCreditCard
		throught: self
		on: testObjectsFactory today
		registeringOn: salesBook.
		
	total := cashier checkOut.
					
	self assert: salesBook size = 1.
	self assert: salesBook first total = total.! !

!CashierTest methodsFor: 'tests' stamp: 'HernanWilkinson 6/17/2013 19:00'!
test05CashierChargesCreditCardUsingMerchantProcessor

	| cart cashier salesBook total creditCard debitedAmout debitedCreditCard  |

	cart := testObjectsFactory createCart.
	cart add: testObjectsFactory itemSellByTheStore.
	creditCard := testObjectsFactory notExpiredCreditCard.
	salesBook := OrderedCollection new.
 
	cashier:= Cashier 
		toCheckout: cart 
		charging: creditCard
		throught: self
		on: testObjectsFactory today
		registeringOn: salesBook.
		
	debitBehavior := [ :anAmount :aCreditCard | 
		debitedAmout := anAmount.
		debitedCreditCard := aCreditCard ].
	total := cashier checkOut.
					
	self assert: debitedCreditCard = creditCard.
	self assert: debitedAmout = total.! !

!CashierTest methodsFor: 'tests' stamp: 'HernanWilkinson 6/17/2013 18:59'!
test06CashierDoesNotSaleWhenTheCreditCardHasNoCredit

	| cart cashier salesBook creditCard |

	cart := testObjectsFactory createCart.
	cart add: testObjectsFactory itemSellByTheStore.
	creditCard := testObjectsFactory notExpiredCreditCard.
	salesBook := OrderedCollection new.
 	debitBehavior := [ :anAmount :aCreditCard | self error: Cashier creditCardHasNoCreditErrorMessage].
	
	cashier:= Cashier 
		toCheckout: cart 
		charging: creditCard
		throught: self
		on: testObjectsFactory today
		registeringOn: salesBook.
		
	self 
		should: [cashier checkOut ]
		raise: Error - MessageNotUnderstood
		withExceptionDo: [ :anError |
			self assert: anError messageText = Cashier creditCardHasNoCreditErrorMessage.
			self assert: salesBook isEmpty ]! !


!CashierTest methodsFor: 'setup' stamp: 'HernanWilkinson 6/17/2013 19:03'!
setUp 

	testObjectsFactory := StoreTestObjectsFactory new.
	debitBehavior := [ :anAmount :aCreditCard | ]! !


!CashierTest methodsFor: 'merchant processor protocol' stamp: 'HernanWilkinson 6/17/2013 19:02'!
debit: anAmount from: aCreditCard 

	^debitBehavior value: anAmount value: aCreditCard ! !


!classDefinition: #TusLibrosInterfaceTest category: 'TusLibros'!
TestCase subclass: #TusLibrosInterfaceTest
	instanceVariableNames: 'testObjectsFactory'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibros'!

!TusLibrosInterfaceTest methodsFor: 'setUp - tearDown' stamp: 'NNH 11/27/2020 20:23:39'!
setUp

	testObjectsFactory := StoreTestObjectsFactory new .! !


!TusLibrosInterfaceTest methodsFor: 'tests - cart management' stamp: 'NNH 11/29/2020 22:57:35'!
test03NewCartShouldBeEmpty
	
	| interface aCartId |
		
	interface := testObjectsFactory tusLibrosInterface .
	
	aCartId := interface createCartForUser: testObjectsFactory validUser password: testObjectsFactory validPassword.

	self assert: ( interface listCart: aCartId ) isEmpty .
	
	
	
	! !

!TusLibrosInterfaceTest methodsFor: 'tests - cart management' stamp: 'NNH 11/29/2020 23:27:07'!
test04AddingToCartSuccessfullyAddsToOneCart
	
	| interface aCartId |
		
	interface := testObjectsFactory tusLibrosInterface .
	
	aCartId := interface createCartForUser: testObjectsFactory validUser password: testObjectsFactory validPassword.
	interface addToCart: aCartId product: testObjectsFactory itemSellByTheStore .
	interface addToCart: aCartId product: testObjectsFactory itemSellByTheStore withOcurrences: 2.


	self assert: ( ( interface listCart: aCartId ) hasEqualElements: { testObjectsFactory itemSellByTheStore. 
													 testObjectsFactory itemSellByTheStore. 
													 testObjectsFactory itemSellByTheStore}).
	
	
	
	! !

!TusLibrosInterfaceTest methodsFor: 'tests - cart management' stamp: 'NNH 11/29/2020 23:27:23'!
test05AddingToCartSuccessfullyAddsToManyCarts
	
	| interface fortCartId maradonaCartId |
	
	interface := testObjectsFactory tusLibrosInterface .
	
	maradonaCartId := interface createCartForUser: testObjectsFactory validUser password: testObjectsFactory validPassword .
	fortCartId := interface createCartForUser: testObjectsFactory anotherValidUser password: testObjectsFactory anotherValidPassword .
	interface addToCart: maradonaCartId product: testObjectsFactory itemSellByTheStore .

	self deny: ( ( interface listCart: maradonaCartId ) isEmpty ).
	self assert: ( ( interface listCart: fortCartId ) isEmpty ).

	
	
	! !

!TusLibrosInterfaceTest methodsFor: 'tests - cart management' stamp: 'NNH 11/29/2020 23:28:41'!
test06ListingCartShouldNotListOnInvalidCartId
	
	| interface |
		
	interface := testObjectsFactory tusLibrosInterface .
	
	self should: [ interface listCart: 0 ]
	raise: Error - MessageNotUnderstood 
	withMessageText: TusLibrosInterface invalidCartIdErrorDescription .

	
	
	! !

!TusLibrosInterfaceTest methodsFor: 'tests - cart management' stamp: 'NNH 11/29/2020 23:29:26'!
test07AddingToInvalidCartIdShouldRaise
	
	| interface |
		
	interface := testObjectsFactory tusLibrosInterface .
	
	self should: [ interface addToCart: 0 product: testObjectsFactory itemSellByTheStore ]
	raise: Error - MessageNotUnderstood 
	withMessageText: TusLibrosInterface invalidCartIdErrorDescription .

	
	
	! !


!TusLibrosInterfaceTest methodsFor: 'tests - checkout' stamp: 'NNH 11/29/2020 23:35:46'!
test08CheckOutSuccessfullyChecksOutOneCart
	
	| interface aCartId total |
		
	interface := testObjectsFactory tusLibrosInterface .
	
	aCartId := interface createCartForUser: testObjectsFactory validUser password: testObjectsFactory validPassword .
	interface addToCart: aCartId product: testObjectsFactory itemSellByTheStore .

	total := interface checkOut: aCartId with: testObjectsFactory notExpiredCreditCard on: testObjectsFactory today.
	
	self assert: total equals: testObjectsFactory itemSellByTheStorePrice .
	
	! !

!TusLibrosInterfaceTest methodsFor: 'tests - checkout' stamp: 'NNH 11/29/2020 23:36:52'!
test09ShouldNotCheckOutAnAlreadyCheckedOutCart
	
	| interface aCartId |
	
	interface := testObjectsFactory tusLibrosInterface .
	
	aCartId := interface createCartForUser: testObjectsFactory validUser password: testObjectsFactory validPassword .
	interface addToCart: aCartId product: testObjectsFactory itemSellByTheStore .

	interface checkOut: aCartId with: testObjectsFactory notExpiredCreditCard on: testObjectsFactory today.
	
	self should: [ interface checkOut: aCartId with: testObjectsFactory notExpiredCreditCard on: testObjectsFactory today ]
	raise: Error
	withMessageText: TusLibrosInterface invalidCartIdErrorDescription . 
	
	! !

!TusLibrosInterfaceTest methodsFor: 'tests - checkout' stamp: 'NNH 11/29/2020 23:37:58'!
test10FailedCheckOutShouldNotInvalidateFutureCheckOut
	
	| interface aCartId total |
		
	interface := testObjectsFactory tusLibrosInterface .
	
	aCartId := interface createCartForUser: testObjectsFactory validUser password: testObjectsFactory validPassword .

	interface addToCart: aCartId product: testObjectsFactory itemSellByTheStore .
	
	[ interface checkOut: aCartId with: testObjectsFactory expiredCreditCard on: testObjectsFactory today. ] on: Error do: [:anError | ].

	total := interface checkOut: aCartId with: testObjectsFactory notExpiredCreditCard on: testObjectsFactory today.
	
	self assert: total equals: testObjectsFactory itemSellByTheStorePrice .
	
	! !


!TusLibrosInterfaceTest methodsFor: 'tests - credentials' stamp: 'NNH 11/29/2020 22:59:41'!
test01UnknownUserShouldNotCreateCart
	
	| interface |
	
	interface := testObjectsFactory tusLibrosInterface .
	
	self should: [ interface createCartForUser: testObjectsFactory invalidUser password: testObjectsFactory invalidPassword ]
	raise: Error - MessageNotUnderstood
	withMessageText: AuthenticationSystemSimulator invalidUserErrorDescription.
	
	
	
	! !

!TusLibrosInterfaceTest methodsFor: 'tests - credentials' stamp: 'NNH 11/29/2020 23:12:09'!
test02WrongPasswordShouldNotCreateCart
	
	| interface |
	
	interface := testObjectsFactory tusLibrosInterface .
	
	self should: [ interface createCartForUser: testObjectsFactory validUser password: testObjectsFactory invalidPassword ]
	raise: Error - MessageNotUnderstood
	withMessageText: AuthenticationSystemSimulator invalidPasswordErrorDescription.
	
	
	
	! !

!TusLibrosInterfaceTest methodsFor: 'tests - credentials' stamp: 'NNH 11/29/2020 23:41:26'!
test15InvalidUserShouldNotListPurchases
	
	| interface |
		
	interface := testObjectsFactory tusLibrosInterface .
	
	self should: [ interface listPurchasesOf: testObjectsFactory invalidUser password: testObjectsFactory validPassword ]
	raise: Error
	withMessageText: AuthenticationSystemSimulator invalidUserErrorDescription .
		
	! !

!TusLibrosInterfaceTest methodsFor: 'tests - credentials' stamp: 'NNH 11/29/2020 23:41:39'!
test16InvalidPasswordShouldNotListPurchases
	
	| interface |
		
	interface := testObjectsFactory tusLibrosInterface .
	
	self should: [ interface listPurchasesOf: testObjectsFactory validUser password: testObjectsFactory invalidPassword ]
	raise: Error
	withMessageText: AuthenticationSystemSimulator invalidPasswordErrorDescription .
		
	! !


!TusLibrosInterfaceTest methodsFor: 'tests - list purchases' stamp: 'NNH 11/29/2020 23:39:44'!
test11ListZeroPurchasesSuccesfully
	
	| interface purchases |
		
	interface := testObjectsFactory tusLibrosInterface .
	
	purchases := interface listPurchasesOf: testObjectsFactory validUser password: testObjectsFactory validPassword .
	
	self assert: purchases total equals: 0.
	self assert: purchases products isEmpty.
	
	! !

!TusLibrosInterfaceTest methodsFor: 'tests - list purchases' stamp: 'NNH 11/29/2020 23:40:09'!
test12ListOnePurchaseSuccessfully
	
	| interface aCartId purchases |
		
	interface := testObjectsFactory tusLibrosInterface .
	
	aCartId := interface createCartForUser: testObjectsFactory validUser password: testObjectsFactory validPassword .
	interface addToCart: aCartId product: testObjectsFactory itemSellByTheStore .

	interface checkOut: aCartId with: testObjectsFactory notExpiredCreditCard on: testObjectsFactory today.
	purchases := interface listPurchasesOf: testObjectsFactory validUser password: testObjectsFactory validPassword .
	
	self assert: purchases total equals: testObjectsFactory itemSellByTheStorePrice .
	self assert: ( purchases products hasEqualElements: {testObjectsFactory itemSellByTheStore } ) .
	
	! !

!TusLibrosInterfaceTest methodsFor: 'tests - list purchases' stamp: 'NNH 11/29/2020 23:48:42'!
test13ListMoreThanOnePurchaseSuccessfully
	
	| interface aCartId purchases |
		
	interface := testObjectsFactory tusLibrosInterface .
	
	2 timesRepeat: [ 
		aCartId := interface createCartForUser: testObjectsFactory validUser password: testObjectsFactory validPassword .
		interface addToCart: aCartId product: testObjectsFactory itemSellByTheStore .
		interface checkOut: aCartId with: testObjectsFactory notExpiredCreditCard on: testObjectsFactory today 
		].
	
	purchases := interface listPurchasesOf: testObjectsFactory validUser password: testObjectsFactory validPassword .
	
	self assert: testObjectsFactory itemSellByTheStorePrice * 2 equals: purchases total.
	self assert: ( purchases products hasEqualElements: { testObjectsFactory itemSellByTheStore. testObjectsFactory itemSellByTheStore } ) .
	
	! !

!TusLibrosInterfaceTest methodsFor: 'tests - list purchases' stamp: 'NNH 11/29/2020 23:40:54'!
test14ListPurchasesFromMoreThanOneUser
	
	| interface aCartId purchases |
	
	interface := testObjectsFactory tusLibrosInterface .
	
	aCartId := interface createCartForUser: testObjectsFactory validUser password: testObjectsFactory validPassword .
	interface addToCart: aCartId product: testObjectsFactory itemSellByTheStore .
	interface checkOut: aCartId with: testObjectsFactory notExpiredCreditCard on: testObjectsFactory today.
	
	aCartId := interface createCartForUser: testObjectsFactory anotherValidUser password: testObjectsFactory anotherValidPassword .
	interface addToCart: aCartId product: testObjectsFactory itemSellByTheStore .
	interface checkOut: aCartId with: testObjectsFactory notExpiredCreditCard on: testObjectsFactory today.
	
	purchases := interface listPurchasesOf: testObjectsFactory validUser password: testObjectsFactory validPassword .
	
	self assert: testObjectsFactory itemSellByTheStorePrice equals: purchases total.
	"self assert: ( purchases products hasEqualElements: {testObjectsFactory itemSellByTheStore } ) ."
	
	! !


!classDefinition: #AuthenticationSystemSimulator category: 'TusLibros'!
Object subclass: #AuthenticationSystemSimulator
	instanceVariableNames: 'credentials'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibros'!

!AuthenticationSystemSimulator methodsFor: 'authentication' stamp: 'NNH 11/29/2020 22:38:11'!
authenticate: aUser using: aPassword
	
	( credentials includesKey: aUser ) ifFalse: [ self error: self class invalidUserErrorDescription ] .
	
	( credentials at: aUser ) = aPassword ifFalse: [ self error: self class invalidPasswordErrorDescription ] .! !


!AuthenticationSystemSimulator methodsFor: 'initialization' stamp: 'NNH 11/29/2020 22:34:56'!
initializeWithCredentials: aCollectionOfCredentials
	
	credentials := aCollectionOfCredentials .! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'AuthenticationSystemSimulator class' category: 'TusLibros'!
AuthenticationSystemSimulator class
	instanceVariableNames: ''!

!AuthenticationSystemSimulator class methodsFor: 'error descriptions' stamp: 'NNH 11/29/2020 22:39:49'!
invalidPasswordErrorDescription
	
	^ 'Invalid Password'! !

!AuthenticationSystemSimulator class methodsFor: 'error descriptions' stamp: 'NNH 11/29/2020 22:39:58'!
invalidUserErrorDescription
	
	^ 'Invalid User'! !


!AuthenticationSystemSimulator class methodsFor: 'instance creation' stamp: 'NNH 11/29/2020 22:39:01'!
withCredentials: aCollectionOfCredentials

	^ self new initializeWithCredentials: aCollectionOfCredentials .! !


!classDefinition: #Cart category: 'TusLibros'!
Object subclass: #Cart
	instanceVariableNames: 'catalog items'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibros'!


!Cart methodsFor: 'assertions' stamp: 'NNH 11/27/2020 21:03:35'!
assertIsValidItem: anItem

	(catalog includesKey: anItem) ifFalse: [ self error: self class invalidItemErrorMessage ]! !

!Cart methodsFor: 'assertions' stamp: 'NNH 11/27/2020 21:03:40'!
assertIsValidQuantity: aQuantity

	aQuantity strictlyPositive ifFalse: [ self error: self class invalidQuantityErrorMessage ]! !


!Cart methodsFor: 'initialization' stamp: 'HernanWilkinson 6/17/2013 17:48'!
initializeAcceptingItemsOf: aCatalog

	catalog := aCatalog.
	items := OrderedCollection new.! !


!Cart methodsFor: 'queries' stamp: 'HernanWilkinson 6/17/2013 17:45'!
occurrencesOf: anItem

	^items occurrencesOf: anItem  ! !


!Cart methodsFor: 'testing' stamp: 'HernanWilkinson 6/17/2013 17:44'!
includes: anItem

	^items includes: anItem ! !

!Cart methodsFor: 'testing' stamp: 'HernanWilkinson 6/17/2013 17:44'!
isEmpty
	
	^items isEmpty ! !

!Cart methodsFor: 'testing' stamp: 'NNH 11/26/2020 21:19:32'!
listCart
	
	^items copy ! !


!Cart methodsFor: 'total' stamp: 'HernanWilkinson 6/17/2013 19:09'!
total

	^ items sum: [ :anItem | catalog at: anItem ]! !


!Cart methodsFor: 'adding' stamp: 'HernanWilkinson 6/17/2013 17:44'!
add: anItem

	^ self add: 1 of: anItem ! !

!Cart methodsFor: 'adding' stamp: 'HernanWilkinson 6/17/2013 17:51'!
add: aQuantity of: anItem

	self assertIsValidQuantity: aQuantity.
	self assertIsValidItem: anItem.

	1 to: aQuantity do: [ :aNumber | items add: anItem ]! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'Cart class' category: 'TusLibros'!
Cart class
	instanceVariableNames: ''!

!Cart class methodsFor: 'instance creation' stamp: 'HernanWilkinson 6/17/2013 17:48'!
acceptingItemsOf: aCatalog

	^self new initializeAcceptingItemsOf: aCatalog ! !


!Cart class methodsFor: 'error messages' stamp: 'NNH 11/27/2020 21:02:56'!
invalidItemErrorMessage
	
	^'Item is not in catalog'! !

!Cart class methodsFor: 'error messages' stamp: 'NNH 11/27/2020 21:03:06'!
invalidQuantityErrorMessage
	
	^'Invalid number of items'! !


!classDefinition: #Cashier category: 'TusLibros'!
Object subclass: #Cashier
	instanceVariableNames: 'cart salesBook merchantProcessor creditCard total'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibros'!

!Cashier methodsFor: 'checkout - private' stamp: 'HernanWilkinson 6/17/2013 19:08'!
calculateTotal

	total := cart total.
	! !

!Cashier methodsFor: 'checkout - private' stamp: 'NNH 11/29/2020 23:43:57'!
createSale

	^ Sale of: total products: cart listCart .! !

!Cashier methodsFor: 'checkout - private' stamp: 'HernanWilkinson 6/17/2013 19:06'!
debitTotal

	merchantProcessor debit: total from: creditCard.
	! !

!Cashier methodsFor: 'checkout - private' stamp: 'HernanWilkinson 6/17/2013 19:06'!
registerSale

	salesBook add: self createSale! !


!Cashier methodsFor: 'checkout' stamp: 'HernanWilkinson 6/17/2013 19:06'!
checkOut

	self calculateTotal.
	self debitTotal.
	self registerSale.

	^ total! !


!Cashier methodsFor: 'initialization' stamp: 'HernanWilkinson 6/17/2013 18:53'!
initializeToCheckout: aCart charging: aCreditCard throught: aMerchantProcessor registeringOn: aSalesBook
	
	cart := aCart.
	creditCard := aCreditCard.
	merchantProcessor := aMerchantProcessor.
	salesBook := aSalesBook! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'Cashier class' category: 'TusLibros'!
Cashier class
	instanceVariableNames: ''!

!Cashier class methodsFor: 'assertions' stamp: 'HernanWilkinson 6/17/2013 18:22'!
assertIsNotEmpty: aCart 
	
	aCart isEmpty ifTrue: [self error: self cartCanNotBeEmptyErrorMessage ]! !

!Cashier class methodsFor: 'assertions' stamp: 'HernanWilkinson 6/17/2013 18:23'!
assertIsNotExpired: aCreditCard on: aDate
	
	(aCreditCard isExpiredOn: aDate) ifTrue: [ self error: self canNotChargeAnExpiredCreditCardErrorMessage ]! !


!Cashier class methodsFor: 'instance creation' stamp: 'HernanWilkinson 6/17/2013 18:51'!
toCheckout: aCart charging: aCreditCard throught: aMerchantProcessor on: aDate registeringOn: aSalesBook
	
	self assertIsNotEmpty: aCart.
	self assertIsNotExpired: aCreditCard on: aDate.
	
	^self new initializeToCheckout: aCart charging: aCreditCard throught: aMerchantProcessor registeringOn: aSalesBook! !


!Cashier class methodsFor: 'error messages' stamp: 'HernanWilkinson 6/17/2013 18:21'!
canNotChargeAnExpiredCreditCardErrorMessage
	
	^'Can not charge an expired credit card'! !

!Cashier class methodsFor: 'error messages' stamp: 'HernanWilkinson 6/17/2013 17:56'!
cartCanNotBeEmptyErrorMessage
	
	^'Can not check out an empty cart'! !

!Cashier class methodsFor: 'error messages' stamp: 'HernanWilkinson 6/17/2013 19:02'!
creditCardHasNoCreditErrorMessage
	
	^'Credit card has no credit'! !


!classDefinition: #CreditCard category: 'TusLibros'!
Object subclass: #CreditCard
	instanceVariableNames: 'expiration'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibros'!

!CreditCard methodsFor: 'testing' stamp: 'HernanWilkinson 6/17/2013 18:39'!
isExpiredOn: aDate 
	
	^expiration start < (Month month: aDate monthIndex year: aDate yearNumber) start ! !


!CreditCard methodsFor: 'initialization' stamp: 'HernanWilkinson 6/17/2013 18:38'!
initializeExpiringOn: aMonth 
	
	expiration := aMonth ! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'CreditCard class' category: 'TusLibros'!
CreditCard class
	instanceVariableNames: ''!

!CreditCard class methodsFor: 'instance creation' stamp: 'HernanWilkinson 6/17/2013 18:38'!
expiringOn: aMonth 
	
	^self new initializeExpiringOn: aMonth! !


!classDefinition: #Purchase category: 'TusLibros'!
Object subclass: #Purchase
	instanceVariableNames: 'total products'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibros'!

!Purchase methodsFor: 'accessing' stamp: 'NNH 11/29/2020 23:45:32'!
products

	^ products .! !

!Purchase methodsFor: 'accessing' stamp: 'NNH 11/27/2020 23:54:47'!
total
	
	^ total! !


!Purchase methodsFor: 'initialization' stamp: 'NNH 11/29/2020 23:45:15'!
initialize
		 
	total := 0.
	products := OrderedCollection new.! !


!Purchase methodsFor: 'adding' stamp: 'NNH 11/29/2020 23:46:11'!
addSale: aSale 
	
	total := aSale total + total.
	products addAllLast: aSale products .! !


!classDefinition: #Sale category: 'TusLibros'!
Object subclass: #Sale
	instanceVariableNames: 'total products'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibros'!

!Sale methodsFor: 'accessing' stamp: 'NNH 11/29/2020 23:46:57'!
products
	
	^ products! !

!Sale methodsFor: 'accessing' stamp: 'HernanWilkinson 6/17/2013 18:48'!
total
	
	^ total! !


!Sale methodsFor: 'initialization' stamp: 'NNH 11/29/2020 23:47:34'!
initializeTotal: aTotal products: aCollectionOfProducts   

	total := aTotal .
	products := aCollectionOfProducts .! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'Sale class' category: 'TusLibros'!
Sale class
	instanceVariableNames: ''!

!Sale class methodsFor: 'instance creation' stamp: 'NNH 11/28/2020 00:18:32'!
of: aTotal products: aCollectionOfProducts   

	"should assert total is not negative or 0!!"
	^self new initializeTotal: aTotal products: aCollectionOfProducts ! !


!classDefinition: #StoreTestObjectsFactory category: 'TusLibros'!
Object subclass: #StoreTestObjectsFactory
	instanceVariableNames: 'today'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibros'!

!StoreTestObjectsFactory methodsFor: 'authentication system' stamp: 'NNH 11/29/2020 22:51:55'!
anotherValidPassword
	
	^ 'Maiameee'! !

!StoreTestObjectsFactory methodsFor: 'authentication system' stamp: 'NNH 11/29/2020 22:51:38'!
anotherValidUser
	
	^ 'RickyFort'! !

!StoreTestObjectsFactory methodsFor: 'authentication system' stamp: 'NNH 11/29/2020 22:55:12'!
authenticationSystem
	
	| credentials |
	
	credentials := Dictionary new.
	credentials add: self validUser -> self validPassword.
	credentials add: self anotherValidUser -> self anotherValidPassword.
	
	^ AuthenticationSystemSimulator withCredentials: credentials.! !

!StoreTestObjectsFactory methodsFor: 'authentication system' stamp: 'NNH 11/29/2020 22:52:59'!
invalidPassword
	
	^ 'GranHermano'! !

!StoreTestObjectsFactory methodsFor: 'authentication system' stamp: 'NNH 11/29/2020 22:52:39'!
invalidUser
	
	^ 'CristianU' ! !

!StoreTestObjectsFactory methodsFor: 'authentication system' stamp: 'NNH 11/29/2020 22:51:08'!
validPassword
	
	^ 'SegurolaYHabana'! !

!StoreTestObjectsFactory methodsFor: 'authentication system' stamp: 'NNH 11/29/2020 22:50:45'!
validUser
	
	^ 'Maradona' ! !


!StoreTestObjectsFactory methodsFor: 'cart' stamp: 'HernanWilkinson 6/17/2013 18:08'!
createCart
	
	^Cart acceptingItemsOf: self defaultCatalog! !


!StoreTestObjectsFactory methodsFor: 'credit card' stamp: 'HernanWilkinson 6/17/2013 18:37'!
expiredCreditCard
	
	^CreditCard expiringOn: (Month month: today monthIndex year: today yearNumber - 1)! !

!StoreTestObjectsFactory methodsFor: 'credit card' stamp: 'HernanWilkinson 6/17/2013 18:36'!
notExpiredCreditCard
	
	^CreditCard expiringOn: (Month month: today monthIndex year: today yearNumber + 1)! !


!StoreTestObjectsFactory methodsFor: 'date' stamp: 'HernanWilkinson 6/17/2013 18:37'!
today
	
	^ today! !


!StoreTestObjectsFactory methodsFor: 'initialization' stamp: 'HernanWilkinson 6/17/2013 18:37'!
initialize

	today := DateAndTime now! !


!StoreTestObjectsFactory methodsFor: 'items' stamp: 'HernanWilkinson 6/17/2013 18:08'!
defaultCatalog
	
	^ Dictionary new
		at: self itemSellByTheStore put: self itemSellByTheStorePrice;
		yourself ! !

!StoreTestObjectsFactory methodsFor: 'items' stamp: 'HernanWilkinson 6/17/2013 18:08'!
itemNotSellByTheStore
	
	^'invalidBook'! !

!StoreTestObjectsFactory methodsFor: 'items' stamp: 'HernanWilkinson 6/17/2013 18:08'!
itemSellByTheStore
	
	^ 'validBook'! !

!StoreTestObjectsFactory methodsFor: 'items' stamp: 'HernanWilkinson 6/17/2013 18:08'!
itemSellByTheStorePrice
	
	^10! !


!StoreTestObjectsFactory methodsFor: 'tus libros interface' stamp: 'NNH 11/29/2020 22:56:49'!
tusLibrosInterface
	
	^ TusLibrosInterface with: self authenticationSystem catalog: self defaultCatalog through: self.
! !


!StoreTestObjectsFactory methodsFor: 'merchant processor' stamp: 'NNH 11/27/2020 22:36:33'!
debit: anAmount from: aCreditCard
! !


!classDefinition: #TusLibrosInterface category: 'TusLibros'!
Object subclass: #TusLibrosInterface
	instanceVariableNames: 'authenticationSystem catalog carts nextCartId merchantProcessor salesBooks clientByCart'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibros'!

!TusLibrosInterface methodsFor: 'cart management' stamp: 'NNH 11/29/2020 23:33:16'!
addToCart: aCartId product: aProduct
	
	self addToCart: aCartId product: aProduct withOcurrences: 1. ! !

!TusLibrosInterface methodsFor: 'cart management' stamp: 'NNH 11/29/2020 23:34:53'!
addToCart: aCartId product: aProduct withOcurrences: aNumberOfOccurrences 
	
	( self cartAt: aCartId ) add: aNumberOfOccurrences of: aProduct! !

!TusLibrosInterface methodsFor: 'cart management' stamp: 'NNH 11/29/2020 23:50:16'!
checkOut: aCartId with: aCreditCard on: aDate 
	
	| total |
	
	total := ( Cashier toCheckout: (self cartAt: aCartId) 
		charging: aCreditCard 
		throught: merchantProcessor 
		on: aDate 
		registeringOn: ( salesBooks at: ( self clientUsingCart: aCartId ) ) )
		checkOut .
			
	carts removeKey: aCartId .
	clientByCart removeKey: aCartId .
	
	^ total.
! !

!TusLibrosInterface methodsFor: 'cart management' stamp: 'NNH 11/29/2020 23:50:16'!
createCartForUser: anUser password: aPassword 
	
	| newCartId |
	
	authenticationSystem authenticate: anUser using: aPassword .
	
	newCartId := self newCartId.
	
	carts add: newCartId -> ( Cart acceptingItemsOf: catalog ) .
	clientByCart add: newCartId -> anUser .
	salesBooks at: anUser ifAbsentPut: OrderedCollection new.
	
	^ newCartId. ! !

!TusLibrosInterface methodsFor: 'cart management' stamp: 'NNH 11/27/2020 20:56:17'!
listCart: aCartId 
			
	^ ( self cartAt: aCartId ) listCart.! !


!TusLibrosInterface methodsFor: 'cart management - private' stamp: 'NNH 11/27/2020 20:55:35'!
cartAt: aCartId

	^ carts at: aCartId ifAbsent: [ self error: self class invalidCartIdErrorDescription ]! !

!TusLibrosInterface methodsFor: 'cart management - private' stamp: 'NNH 11/28/2020 00:21:16'!
clientUsingCart: aCartId

	^ clientByCart at: aCartId! !

!TusLibrosInterface methodsFor: 'cart management - private' stamp: 'NNH 11/27/2020 20:43:56'!
newCartId
	
	nextCartId := nextCartId + 1.
	^ nextCartId.! !


!TusLibrosInterface methodsFor: 'client history' stamp: 'NNH 11/29/2020 23:50:16'!
listPurchasesOf: aClientId password: aPassword 
	 
	| purchase |
	
	authenticationSystem authenticate: aClientId using: aPassword .
	
	purchase := Purchase new.
	
	( salesBooks at: aClientId ifAbsent: [ ^ purchase ] ) do: [ :aSale | purchase addSale: aSale ].
	
	^ purchase.
	! !


!TusLibrosInterface methodsFor: 'initialization' stamp: 'NNH 11/29/2020 23:50:16'!
initializeWith: anAuthenticationSystem catalog: aCatalog through: aMerchantProcessor 

	authenticationSystem := anAuthenticationSystem .
	catalog := aCatalog .
	carts := Dictionary new.
	nextCartId := 0.
	merchantProcessor := aMerchantProcessor .
	salesBooks := Dictionary new.
	clientByCart := Dictionary new.
! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'TusLibrosInterface class' category: 'TusLibros'!
TusLibrosInterface class
	instanceVariableNames: ''!

!TusLibrosInterface class methodsFor: 'error descriptions' stamp: 'NNH 11/27/2020 20:50:51'!
invalidCartIdErrorDescription
	
	^ 'Invalid cart id'! !


!TusLibrosInterface class methodsFor: 'instance creation' stamp: 'NNH 11/29/2020 22:46:53'!
with: anAuthenticationSystem catalog: aCatalog through: aMerchantProcessor   

	^ self new initializeWith: anAuthenticationSystem catalog: aCatalog through: aMerchantProcessor! !
