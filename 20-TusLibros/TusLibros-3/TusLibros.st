!classDefinition: #CartTest category: 'TusLibros'!
TestCase subclass: #CartTest
	instanceVariableNames: 'testObjectsFactory'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibros'!

!CartTest methodsFor: 'setup' stamp: 'HernanWilkinson 6/17/2013 18:09'!
setUp 

	testObjectsFactory := StoreTestObjectsFactory new.! !


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


!classDefinition: #CashierTest category: 'TusLibros'!
TestCase subclass: #CashierTest
	instanceVariableNames: 'testObjectsFactory debitBehavior'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibros'!

!CashierTest methodsFor: 'merchant processor protocol' stamp: 'HernanWilkinson 6/17/2013 19:02'!
debit: anAmount from: aCreditCard 

	^debitBehavior value: anAmount value: aCreditCard ! !


!CashierTest methodsFor: 'setup' stamp: 'HernanWilkinson 6/17/2013 19:03'!
setUp 

	testObjectsFactory := StoreTestObjectsFactory new.
	debitBehavior := [ :anAmount :aCreditCard | ]! !


!CashierTest methodsFor: 'tests' stamp: 'AM 11/30/2020 22:43:50'!
test01CanNotCheckoutAnEmptyCart

	| salesBook |
	
	salesBook := OrderedCollection new.
	self 
		should: [ Cashier 
			toCheckout: testObjectsFactory createCart 
			charging: testObjectsFactory notExpiredCreditCard 
			through: self
			on: testObjectsFactory today
			registeringOn:  salesBook ]
		raise: Error - MessageNotUnderstood
		withExceptionDo: [ :anError |
			self assert: anError messageText = Cashier cartCanNotBeEmptyErrorMessage.
			self assert: salesBook isEmpty ]! !

!CashierTest methodsFor: 'tests' stamp: 'AM 11/30/2020 22:43:51'!
test02CalculatedTotalIsCorrect

	| cart cashier |
	
	cart := testObjectsFactory createCart.
	cart add: 2 of: testObjectsFactory itemSellByTheStore.
	
	cashier :=  Cashier
		toCheckout: cart 
		charging: testObjectsFactory notExpiredCreditCard 
		through: self
		on: testObjectsFactory today 
		registeringOn: OrderedCollection new.
		
	self assert: cashier checkOut = (testObjectsFactory itemSellByTheStorePrice * 2)! !

!CashierTest methodsFor: 'tests' stamp: 'AM 11/30/2020 22:43:50'!
test03CanNotCheckoutWithAnExpiredCreditCart

	| cart salesBook |

	cart := testObjectsFactory createCart.
	cart add: testObjectsFactory itemSellByTheStore.
	salesBook := OrderedCollection new.
	
	self
		should: [ Cashier 
				toCheckout: cart 
				charging: testObjectsFactory expiredCreditCard 
				through: self
				on: testObjectsFactory today
				registeringOn: salesBook ]
		raise: Error - MessageNotUnderstood
		withExceptionDo: [ :anError | 
			self assert: anError messageText = Cashier canNotChargeAnExpiredCreditCardErrorMessage.
			self assert: salesBook isEmpty ]! !

!CashierTest methodsFor: 'tests' stamp: 'AM 11/30/2020 22:43:50'!
test04CheckoutRegistersASale

	| cart cashier salesBook total |

	cart := testObjectsFactory createCart.
	cart add: testObjectsFactory itemSellByTheStore.
	salesBook := OrderedCollection new.
 
	cashier:= Cashier 
		toCheckout: cart 
		charging: testObjectsFactory notExpiredCreditCard
		through: self
		on: testObjectsFactory today
		registeringOn: salesBook.
		
	total := cashier checkOut.
					
	self assert: salesBook size = 1.
	self assert: salesBook first total = total.! !

!CashierTest methodsFor: 'tests' stamp: 'AM 11/30/2020 22:43:50'!
test05CashierChargesCreditCardUsingMerchantProcessor

	| cart cashier salesBook total creditCard debitedAmout debitedCreditCard  |

	cart := testObjectsFactory createCart.
	cart add: testObjectsFactory itemSellByTheStore.
	creditCard := testObjectsFactory notExpiredCreditCard.
	salesBook := OrderedCollection new.
 
	cashier:= Cashier 
		toCheckout: cart 
		charging: creditCard
		through: self
		on: testObjectsFactory today
		registeringOn: salesBook.
		
	debitBehavior := [ :anAmount :aCreditCard | 
		debitedAmout := anAmount.
		debitedCreditCard := aCreditCard ].
	total := cashier checkOut.
					
	self assert: debitedCreditCard = creditCard.
	self assert: debitedAmout = total.! !

!CashierTest methodsFor: 'tests' stamp: 'AM 11/30/2020 22:43:50'!
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
		through: self
		on: testObjectsFactory today
		registeringOn: salesBook.
		
	self 
		should: [cashier checkOut ]
		raise: Error - MessageNotUnderstood
		withExceptionDo: [ :anError |
			self assert: anError messageText = Cashier creditCardHasNoCreditErrorMessage.
			self assert: salesBook isEmpty ]! !


!classDefinition: #CreditCardTest category: 'TusLibros'!
TestCase subclass: #CreditCardTest
	instanceVariableNames: 'testObjectsFactory'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibros'!

!CreditCardTest methodsFor: 'setUp/tearDown' stamp: 'AM 11/30/2020 20:09:04'!
setUp

	testObjectsFactory := StoreTestObjectsFactory new.
	

	! !


!CreditCardTest methodsFor: 'tests - accessing' stamp: 'AM 11/30/2020 22:45:48'!
test07ValidCardPropertiesAreCorrect
	
	| creditCard |
	
	creditCard := CreditCard withNumber: testObjectsFactory validCardId
							expiringOn:  testObjectsFactory futureExpirationDate 
							owner: testObjectsFactory validOwner.
	
	self assert: testObjectsFactory validCardId equals: creditCard number .
	self assert: testObjectsFactory futureExpirationDate equals: creditCard expirationDate .
	self assert: testObjectsFactory validOwner equals: creditCard owner..

	! !


!CreditCardTest methodsFor: 'tests - validations' stamp: 'AM 11/30/2020 22:45:09'!
test01CardNumberShouldNotHaveLessThan16Digits

	| invalidCardId |
	
	invalidCardId := 10 ^ 15 - 1.
	
	self should: [ CreditCard withNumber: invalidCardId 
						expiringOn: testObjectsFactory futureExpirationDate
						owner: testObjectsFactory validOwner ]
	raise: Error - MessageNotUnderstood
	withMessageText: CreditCard invalidCardNumberErrorDescription .
	

	! !

!CreditCardTest methodsFor: 'tests - validations' stamp: 'AM 11/30/2020 22:45:20'!
test02CardNumberShouldNotHaveMoreThan16Digits

	| invalidCardId |
	
	invalidCardId := 10 ^ 16.
	
	self should: [ CreditCard withNumber: invalidCardId 
						expiringOn: testObjectsFactory futureExpirationDate
						owner: testObjectsFactory validOwner ]
	raise: Error
	withMessageText: CreditCard invalidCardNumberErrorDescription .
	

	! !

!CreditCardTest methodsFor: 'tests - validations' stamp: 'AM 11/30/2020 22:45:24'!
test03CardNumberShouldBeAnInteger

	| invalidCardId |
	
	invalidCardId := 0.5.
	
	self should: [ CreditCard withNumber: invalidCardId 
						expiringOn: testObjectsFactory futureExpirationDate
						owner: testObjectsFactory validOwner ]
	raise: Error
	withMessageText: CreditCard invalidCardNumberErrorDescription .
	

	! !

!CreditCardTest methodsFor: 'tests - validations' stamp: 'AM 11/30/2020 22:45:30'!
test04CardExpirationDateShouldBeAMonthOfAnYear

	| aDayInAMonthOfAnYear |
	
	aDayInAMonthOfAnYear := January/01/2021.
	
	self should: [ CreditCard withNumber: testObjectsFactory validCardId
						expiringOn: aDayInAMonthOfAnYear
						owner: testObjectsFactory validOwner ]
	raise: Error
	withMessageText: CreditCard invalidExpirationDateErrorDescription .
	! !

!CreditCardTest methodsFor: 'tests - validations' stamp: 'AM 11/30/2020 22:45:33'!
test05OwnerNameShouldNotBeEmpty
	
	self should: [ CreditCard withNumber: testObjectsFactory validCardId
						expiringOn: testObjectsFactory futureExpirationDate 
						owner: '' ]
	raise: Error
	withMessageText: CreditCard invalidOwnerNameErrorDescription .
	! !

!CreditCardTest methodsFor: 'tests - validations' stamp: 'AM 11/30/2020 22:45:42'!
test06OwnerNameShouldNotBeBlank
	
	self should: [ CreditCard withNumber: testObjectsFactory validCardId
						expiringOn: testObjectsFactory futureExpirationDate 
						owner: '            ' ]
	raise: Error
	withMessageText: CreditCard invalidOwnerNameErrorDescription .
	! !


!classDefinition: #InternalRestInterfaceTest category: 'TusLibros'!
TestCase subclass: #InternalRestInterfaceTest
	instanceVariableNames: 'testObjectsFactory'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibros'!

!InternalRestInterfaceTest methodsFor: 'setUp - tearDown' stamp: 'NNH 11/27/2020 20:23:39'!
setUp

	testObjectsFactory := StoreTestObjectsFactory new .! !


!InternalRestInterfaceTest methodsFor: 'tests - cart management' stamp: 'AM 11/30/2020 23:11:05'!
test03NewCartShouldBeEmpty
	
	| interface aCartId |
		
	interface := testObjectsFactory tusLibrosInterface .
	
	aCartId := interface createCartForUser: testObjectsFactory validUser 
						password: testObjectsFactory validPassword.

	self assert: ( interface listCart: aCartId ) isEmpty .
	
	
	
	! !

!InternalRestInterfaceTest methodsFor: 'tests - cart management' stamp: 'AM 11/30/2020 23:11:30'!
test04AddingToCartSuccessfullyAddsToOneCart
	
	| interface aCartId |
		
	interface := testObjectsFactory tusLibrosInterface .
	
	aCartId := interface createCartForUser: testObjectsFactory validUser 
						password: testObjectsFactory validPassword.
	
	interface addToCart: aCartId 
			product: testObjectsFactory itemSellByTheStore .
	interface addToCart: aCartId 
			product: testObjectsFactory itemSellByTheStore 
			withOcurrences: 2.


	self assert: (interface listCart: aCartId ) equals: { testObjectsFactory itemSellByTheStore. 
												 testObjectsFactory itemSellByTheStore. 
												 testObjectsFactory itemSellByTheStore} asBag.
	
	
	
	! !

!InternalRestInterfaceTest methodsFor: 'tests - cart management' stamp: 'AM 11/30/2020 23:12:03'!
test05AddingToCartSuccessfullyAddsToManyCarts
	
	| interface fortCartId maradonaCartId |
	
	interface := testObjectsFactory tusLibrosInterface .
	
	maradonaCartId := interface createCartForUser: testObjectsFactory validUser 
							password: testObjectsFactory validPassword .
	fortCartId := interface createCartForUser: testObjectsFactory anotherValidUser 
						password: testObjectsFactory anotherValidPassword .
	
	interface addToCart: maradonaCartId 
			product: testObjectsFactory itemSellByTheStore .

	self assert: ( interface listCart: maradonaCartId ) equals: { testObjectsFactory itemSellByTheStore } asBag.
	self assert: ( ( interface listCart: fortCartId ) isEmpty ).

	
	
	! !

!InternalRestInterfaceTest methodsFor: 'tests - cart management' stamp: 'AM 11/30/2020 23:12:18'!
test06ListingCartShouldNotListOnInvalidCartId
	
	| interface |
		
	interface := testObjectsFactory tusLibrosInterface .
	
	self should: [ interface listCart: testObjectsFactory invalidCartId ]
		raise: Error - MessageNotUnderstood 
		withMessageText: InternalRestInterface invalidCartIdErrorDescription .

	
	
	! !

!InternalRestInterfaceTest methodsFor: 'tests - cart management' stamp: 'AM 11/30/2020 23:12:25'!
test07ShouldNotAddToInvalidCartId
	
	| interface |
		
	interface := testObjectsFactory tusLibrosInterface .
	
	self should: [ interface addToCart: testObjectsFactory invalidCartId product: testObjectsFactory itemSellByTheStore ]
		raise: Error - MessageNotUnderstood 
		withMessageText: InternalRestInterface invalidCartIdErrorDescription .

	
	
	! !


!InternalRestInterfaceTest methodsFor: 'tests - checkout' stamp: 'AM 11/30/2020 23:06:59'!
test08CheckOutSuccessfullyChecksOutOneCart
	
	| interface aCartId transactionId |
		
	interface := testObjectsFactory tusLibrosInterface .
	
	aCartId := interface createCartForUser: testObjectsFactory validUser password: testObjectsFactory validPassword .
	interface addToCart: aCartId product: testObjectsFactory itemSellByTheStore .

	transactionId := interface checkOut: aCartId 
							withCCN: testObjectsFactory validCardId 
							CCED: testObjectsFactory futureExpirationDate 
							CCO: testObjectsFactory validOwner 
							on: testObjectsFactory today.
	
	self assert: (interface saleFor: transactionId) total equals: testObjectsFactory itemSellByTheStorePrice .
	self assert: (interface saleFor: transactionId) products equals: { testObjectsFactory itemSellByTheStore} asBag .
	
	! !

!InternalRestInterfaceTest methodsFor: 'tests - checkout' stamp: 'AM 11/30/2020 23:09:15'!
test09ShouldNotCheckOutAnAlreadyCheckedOutCart
	
	| interface aCartId |
	
	interface := testObjectsFactory tusLibrosInterface .
	
	aCartId := interface createCartForUser: testObjectsFactory validUser password: testObjectsFactory validPassword .
	interface addToCart: aCartId product: testObjectsFactory itemSellByTheStore .

	interface checkOut: aCartId 
			withCCN: testObjectsFactory validCardId 
			CCED: testObjectsFactory futureExpirationDate 
			CCO: testObjectsFactory validOwner 
			on: testObjectsFactory today.
	
	self should: [ interface checkOut: aCartId 
						withCCN: testObjectsFactory validCardId 
						CCED: testObjectsFactory futureExpirationDate
						CCO: testObjectsFactory validOwner 
						on: testObjectsFactory today ]
		raise: Error
		withMessageText: InternalRestInterface invalidCartIdErrorDescription . 
	
	! !

!InternalRestInterfaceTest methodsFor: 'tests - checkout' stamp: 'AM 11/30/2020 23:13:04'!
test10FailedCheckOutShouldNotInvalidateFutureCheckOut
	
	| interface aCartId transactionId |
		
	interface := testObjectsFactory tusLibrosInterface .
	
	aCartId := interface createCartForUser: testObjectsFactory validUser password: testObjectsFactory validPassword .

	interface addToCart: aCartId product: testObjectsFactory itemSellByTheStore .
	
	[ interface checkOut: aCartId 
			withCCN: testObjectsFactory validCardId 
			CCED: testObjectsFactory pastExpirationDate 
			CCO: testObjectsFactory validOwner 
			on: testObjectsFactory today. ] on: Error do: [:anError | ].

	transactionId := interface checkOut: aCartId 
							withCCN: testObjectsFactory validCardId 
							CCED: testObjectsFactory futureExpirationDate 
							CCO: testObjectsFactory validOwner 
							on: testObjectsFactory today.
	
	self assert: (interface saleFor: transactionId) total equals: testObjectsFactory itemSellByTheStorePrice .
	self assert: (interface saleFor: transactionId) products equals: { testObjectsFactory itemSellByTheStore} asBag .	
	! !


!InternalRestInterfaceTest methodsFor: 'tests - cart timed out' stamp: 'AM 11/30/2020 23:13:26'!
test17ShouldNotAddWhenCartTimedOut
	
	| interface aCartId clock |
		
	clock := ClockSimulator withTime: GregorianDateTime now.
	
	interface :=  InternalRestInterface with: testObjectsFactory authenticationSystem 
								catalog: testObjectsFactory defaultCatalog 
								through: testObjectsFactory 
								clock: clock.
					
	aCartId := interface createCartForUser: testObjectsFactory validUser password: testObjectsFactory validPassword. 
	
	clock addToTime: 30*minute.
	
	self should: [ interface addToCart: aCartId product: testObjectsFactory itemSellByTheStore. ]
		raise: Error
		withExceptionDo: [ :anError | 
			self should: [ interface listCart: aCartId] 
				raise: Error 
				withMessageText: InternalRestInterface invalidCartIdErrorDescription
			]
		description: InternalRestInterface cartHasTimedOutErrorDescription.
		
	! !

!InternalRestInterfaceTest methodsFor: 'tests - cart timed out' stamp: 'AM 11/30/2020 21:35:00'!
test18ShouldNotListToTimedOutCart
	
	| interface aCartId clock |
		
	clock := ClockSimulator withTime: GregorianDateTime now.
	
	interface :=  InternalRestInterface with: testObjectsFactory authenticationSystem 
								catalog: testObjectsFactory defaultCatalog 
								through: testObjectsFactory 
								clock: clock.
					
	aCartId := interface createCartForUser: testObjectsFactory validUser password: testObjectsFactory validPassword. 
	
	clock addToTime: 30*minute.
	
	self should: [ interface listCart: aCartId  ]
		raise: Error
		withExceptionDo: [ :anError | 
			self should: [ interface listCart: aCartId] raise: Error withMessageText: InternalRestInterface invalidCartIdErrorDescription]
		description: InternalRestInterface cartHasTimedOutErrorDescription.
		
	! !

!InternalRestInterfaceTest methodsFor: 'tests - cart timed out' stamp: 'AM 11/30/2020 23:14:08'!
test19ShouldNotCheckOutATimedOutCart
	
	| interface aCartId clock |
		
	clock := ClockSimulator withTime: GregorianDateTime now.
	
	interface :=  InternalRestInterface with: testObjectsFactory authenticationSystem 
								catalog: testObjectsFactory defaultCatalog 
								through: testObjectsFactory 
								clock: clock.
					
	aCartId := interface createCartForUser: testObjectsFactory validUser password: testObjectsFactory validPassword. 
	interface addToCart: aCartId product: testObjectsFactory itemSellByTheStore .
	
	clock addToTime: 30*minute.
	
	self should: [ interface checkOut: aCartId 
						withCCN: testObjectsFactory notExpiredCreditCard 
						CCED: testObjectsFactory futureExpirationDate 
						CCO: testObjectsFactory validOwner 
						on: testObjectsFactory today ]
		raise: Error
		withExceptionDo: [ :anError | 
			self should: [ interface listCart: aCartId] 
				raise: Error 
				withMessageText: InternalRestInterface invalidCartIdErrorDescription
			]
		description: InternalRestInterface cartHasTimedOutErrorDescription.
		
	! !

!InternalRestInterfaceTest methodsFor: 'tests - cart timed out' stamp: 'AM 11/30/2020 23:15:26'!
test20TimeOutTimeIsResetAfterAnyOperation
	
	| interface aCartId clock |
		
	clock := ClockSimulator withTime: GregorianDateTime now.
	
	interface :=  InternalRestInterface with: testObjectsFactory authenticationSystem 
								catalog: testObjectsFactory defaultCatalog 
								through: testObjectsFactory 
								clock: clock.
					
	aCartId := interface createCartForUser: testObjectsFactory validUser 
						password: testObjectsFactory validPassword. 	
	
	self shouldnt: [ clock addToTime: 29*minute.
				interface listCart: aCartId .
				clock addToTime: 29*minute.
				interface addToCart: aCartId product: testObjectsFactory itemSellByTheStore .
				clock addToTime: 29*minute.
				[ interface checkOut: aCartId 
						withCCN: testObjectsFactory validCardId 
						CCED: testObjectsFactory pastExpirationDate
						CCO: testObjectsFactory validOwner 
						on: testObjectsFactory today ] 
					on: Error 
					do: [:anError | ].
				clock addToTime: 29*minute.
				interface listCart: aCartId ]
		raise: Error.
		
	! !


!InternalRestInterfaceTest methodsFor: 'tests - credentials' stamp: 'AM 11/30/2020 23:16:04'!
test01UnknownUserShouldNotCreateCart
	
	| interface |
	
	interface := testObjectsFactory tusLibrosInterface .
	
	self should: [ interface createCartForUser: testObjectsFactory invalidUser password: testObjectsFactory invalidPassword ]
		raise: Error - MessageNotUnderstood
		withMessageText: AuthenticationSystemSimulator invalidUserErrorDescription.
	
	
	
	! !

!InternalRestInterfaceTest methodsFor: 'tests - credentials' stamp: 'AM 11/30/2020 23:16:09'!
test02WrongPasswordShouldNotCreateCart
	
	| interface |
	
	interface := testObjectsFactory tusLibrosInterface .
	
	self should: [ interface createCartForUser: testObjectsFactory validUser password: testObjectsFactory invalidPassword ]
		raise: Error
		withMessageText: AuthenticationSystemSimulator invalidPasswordErrorDescription.
	
	
	
	! !

!InternalRestInterfaceTest methodsFor: 'tests - credentials' stamp: 'AM 11/30/2020 23:16:13'!
test15InvalidUserShouldNotListPurchases
	
	| interface |
		
	interface := testObjectsFactory tusLibrosInterface .
	
	self should: [ interface listPurchasesOf: testObjectsFactory invalidUser password: testObjectsFactory validPassword ]
		raise: Error
		withMessageText: AuthenticationSystemSimulator invalidUserErrorDescription .
		
	! !

!InternalRestInterfaceTest methodsFor: 'tests - credentials' stamp: 'AM 11/30/2020 23:16:17'!
test16InvalidPasswordShouldNotListPurchases
	
	| interface |
		
	interface := testObjectsFactory tusLibrosInterface .
	
	self should: [ interface listPurchasesOf: testObjectsFactory validUser password: testObjectsFactory invalidPassword ]
		raise: Error
		withMessageText: AuthenticationSystemSimulator invalidPasswordErrorDescription .
		
	! !


!InternalRestInterfaceTest methodsFor: 'tests - list purchases' stamp: 'NNH 11/29/2020 23:39:44'!
test11ListZeroPurchasesSuccesfully
	
	| interface purchases |
		
	interface := testObjectsFactory tusLibrosInterface .
	
	purchases := interface listPurchasesOf: testObjectsFactory validUser password: testObjectsFactory validPassword .
	
	self assert: purchases total equals: 0.
	self assert: purchases products isEmpty.
	
	! !

!InternalRestInterfaceTest methodsFor: 'tests - list purchases' stamp: 'AM 11/30/2020 23:16:41'!
test12ListOnePurchaseSuccessfully
	
	| interface aCartId purchases |
		
	interface := testObjectsFactory tusLibrosInterface .
	
	aCartId := interface createCartForUser: testObjectsFactory validUser password: testObjectsFactory validPassword .
	interface addToCart: aCartId product: testObjectsFactory itemSellByTheStore .

	interface checkOut: aCartId 
			withCCN: testObjectsFactory validCardId 
			CCED: testObjectsFactory futureExpirationDate 
			CCO: testObjectsFactory validOwner 
			on: testObjectsFactory today.
			
	purchases := interface listPurchasesOf: testObjectsFactory validUser password: testObjectsFactory validPassword .
	
	self assert: purchases total equals: testObjectsFactory itemSellByTheStorePrice .
	self assert: purchases products equals: {testObjectsFactory itemSellByTheStore } asBag.
	
	! !

!InternalRestInterfaceTest methodsFor: 'tests - list purchases' stamp: 'AM 11/30/2020 23:17:02'!
test13ListMoreThanOnePurchaseSuccessfully
	
	| interface aCartId purchases |
		
	interface := testObjectsFactory tusLibrosInterface .
	
	2 timesRepeat: [ 
		aCartId := interface createCartForUser: testObjectsFactory validUser password: testObjectsFactory validPassword .
		interface addToCart: aCartId product: testObjectsFactory itemSellByTheStore .
		interface checkOut: aCartId 
				withCCN: testObjectsFactory validCardId 
				CCED: testObjectsFactory futureExpirationDate 
				CCO: testObjectsFactory validOwner 
				on: testObjectsFactory today 
		].
	
	purchases := interface listPurchasesOf: testObjectsFactory validUser password: testObjectsFactory validPassword .
	
	self assert: testObjectsFactory itemSellByTheStorePrice * 2 equals: purchases total.
	self assert: purchases products equals: { testObjectsFactory itemSellByTheStore. testObjectsFactory itemSellByTheStore } asBag.
	
	! !

!InternalRestInterfaceTest methodsFor: 'tests - list purchases' stamp: 'AM 11/30/2020 23:18:52'!
test14ListPurchasesFromMoreThanOneUser
	
	| interface aCartId purchases |
	
	interface := testObjectsFactory tusLibrosInterface .
	
	aCartId := interface createCartForUser: testObjectsFactory validUser 
					password: testObjectsFactory validPassword .
	interface addToCart: aCartId 
			product: testObjectsFactory itemSellByTheStore .
	interface checkOut: aCartId 
			withCCN: testObjectsFactory validCardId 
			CCED: testObjectsFactory futureExpirationDate 
			CCO: testObjectsFactory validOwner 
			on: testObjectsFactory today.
	
	aCartId := interface createCartForUser: testObjectsFactory anotherValidUser 
					password: testObjectsFactory anotherValidPassword .
	interface addToCart: aCartId 
			product: testObjectsFactory itemSellByTheStore .
	interface checkOut: aCartId 
			withCCN: testObjectsFactory validCardId 
			CCED: testObjectsFactory futureExpirationDate 
			CCO: testObjectsFactory validOwner 
			on: testObjectsFactory today.
	
	purchases := interface listPurchasesOf: testObjectsFactory validUser 
						password: testObjectsFactory validPassword .
	
	self assert: testObjectsFactory itemSellByTheStorePrice equals: purchases total.
	self assert: purchases products equals: {testObjectsFactory itemSellByTheStore } asBag
	
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

!Cart methodsFor: 'adding' stamp: 'HernanWilkinson 6/17/2013 17:44'!
add: anItem

	^ self add: 1 of: anItem ! !

!Cart methodsFor: 'adding' stamp: 'HernanWilkinson 6/17/2013 17:51'!
add: aQuantity of: anItem

	self assertIsValidQuantity: aQuantity.
	self assertIsValidItem: anItem.

	1 to: aQuantity do: [ :aNumber | items add: anItem ]! !


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

!Cashier methodsFor: 'checkout' stamp: 'HernanWilkinson 6/17/2013 19:06'!
checkOut

	self calculateTotal.
	self debitTotal.
	self registerSale.

	^ total! !


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


!Cashier methodsFor: 'initialization' stamp: 'AM 11/30/2020 22:43:39'!
initializeToCheckout: aCart charging: aCreditCard through: aMerchantProcessor registeringOn: aSalesBook
	
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


!Cashier class methodsFor: 'instance creation' stamp: 'AM 11/30/2020 22:43:50'!
toCheckout: aCart charging: aCreditCard through: aMerchantProcessor on: aDate registeringOn: aSalesBook
	
	self assertIsNotEmpty: aCart.
	self assertIsNotExpired: aCreditCard on: aDate.
	
	^self new initializeToCheckout: aCart charging: aCreditCard through: aMerchantProcessor registeringOn: aSalesBook! !


!Cashier class methodsFor: 'error messages' stamp: 'HernanWilkinson 6/17/2013 18:21'!
canNotChargeAnExpiredCreditCardErrorMessage
	
	^'Can not charge an expired credit card'! !

!Cashier class methodsFor: 'error messages' stamp: 'HernanWilkinson 6/17/2013 17:56'!
cartCanNotBeEmptyErrorMessage
	
	^'Can not check out an empty cart'! !

!Cashier class methodsFor: 'error messages' stamp: 'HernanWilkinson 6/17/2013 19:02'!
creditCardHasNoCreditErrorMessage
	
	^'Credit card has no credit'! !


!classDefinition: #ClockSimulator category: 'TusLibros'!
Object subclass: #ClockSimulator
	instanceVariableNames: 'block time'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibros'!

!ClockSimulator methodsFor: 'initialization' stamp: 'AM 11/30/2020 18:44:34'!
initializeWithTime: aGregorianDateTime 
	
	time := aGregorianDateTime.! !


!ClockSimulator methodsFor: 'time operations' stamp: 'AM 11/30/2020 18:52:14'!
addToTime: aMeasureOfTime

	time := time next: aMeasureOfTime.
	
	! !

!ClockSimulator methodsFor: 'time operations' stamp: 'AM 11/30/2020 19:57:09'!
now

	^ time 
	
	! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'ClockSimulator class' category: 'TusLibros'!
ClockSimulator class
	instanceVariableNames: ''!

!ClockSimulator class methodsFor: 'instance creation' stamp: 'AM 11/30/2020 18:43:57'!
withTime: aGregorianDateTime 
	
	^self new initializeWithTime: aGregorianDateTime ! !


!classDefinition: #CreditCard category: 'TusLibros'!
Object subclass: #CreditCard
	instanceVariableNames: 'expiration number expirationDate owner'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibros'!

!CreditCard methodsFor: 'accessing' stamp: 'AM 11/30/2020 20:36:26'!
expirationDate
	
	^ expirationDate! !

!CreditCard methodsFor: 'accessing' stamp: 'AM 11/30/2020 20:36:11'!
number
	
	^ number! !

!CreditCard methodsFor: 'accessing' stamp: 'AM 11/30/2020 20:36:40'!
owner
	
	^ owner! !


!CreditCard methodsFor: 'initialization' stamp: 'AM 11/30/2020 22:46:49'!
initializeWithNumber: aNumber expiringOn: aMonthOfYear owner: aPerson 
	
	number := aNumber.
	expirationDate := aMonthOfYear.
	owner := aPerson.! !


!CreditCard methodsFor: 'testing' stamp: 'AM 11/30/2020 20:58:52'!
isExpiredOn: aDate 
	
	^ expirationDate <  
		(GregorianMonthOfYear yearNumber: aDate yearNumber monthNumber: aDate monthIndex).! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'CreditCard class' category: 'TusLibros'!
CreditCard class
	instanceVariableNames: ''!

!CreditCard class methodsFor: 'instance creation' stamp: 'AM 11/30/2020 22:46:50'!
withNumber: aNumber expiringOn: aMonthOfYear owner: aName  
	
	((aNumber between: 10^15 and: 10^16-1) and: [aNumber isInteger] )ifFalse: [ self error: self invalidCardNumberErrorDescription ].
	( aMonthOfYear isKindOf: GregorianMonthOfYear ) ifFalse: [ self error: self invalidExpirationDateErrorDescription ] .
	aName withoutTrailingBlanks isEmpty ifTrue: [ self error: self invalidOwnerNameErrorDescription ] .
	
	
	^ self new initializeWithNumber: aNumber expiringOn: aMonthOfYear owner: aName ! !


!CreditCard class methodsFor: 'error descriptions' stamp: 'AM 11/30/2020 20:13:51'!
invalidCardNumberErrorDescription
	
	^ 'Credit card number must have exactly 16 digits' .! !

!CreditCard class methodsFor: 'error descriptions' stamp: 'AM 11/30/2020 20:21:25'!
invalidExpirationDateErrorDescription
	
	^ 'Expiration date must be a moth of year' .! !

!CreditCard class methodsFor: 'error descriptions' stamp: 'AM 11/30/2020 20:26:30'!
invalidOwnerNameErrorDescription

	^ 'Credit card should not have an invalid owner name'! !


!classDefinition: #InterfaceCartData category: 'TusLibros'!
Object subclass: #InterfaceCartData
	instanceVariableNames: 'client cart lastTimeUsed'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibros'!

!InterfaceCartData methodsFor: 'accessing' stamp: 'AM 11/30/2020 22:50:21'!
cart
	
	^ cart! !

!InterfaceCartData methodsFor: 'accessing' stamp: 'AM 11/30/2020 21:21:03'!
client
	
	^ client! !

!InterfaceCartData methodsFor: 'accessing' stamp: 'AM 11/30/2020 21:17:16'!
lastTimeUsed
	
	^ lastTimeUsed! !


!InterfaceCartData methodsFor: 'initialization' stamp: 'AM 11/30/2020 21:22:27'!
initializeCart: aCart client: anUser lastTimeUsed: aTime 
	
	cart := aCart.
	client := anUser.
	lastTimeUsed := aTime.! !


!InterfaceCartData methodsFor: 'updating' stamp: 'AM 11/30/2020 21:17:59'!
updateLastUseTo: aTime 
	
	lastTimeUsed := aTime ! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'InterfaceCartData class' category: 'TusLibros'!
InterfaceCartData class
	instanceVariableNames: ''!

!InterfaceCartData class methodsFor: 'instance creation' stamp: 'AM 11/30/2020 21:15:51'!
cart: aCart client: anUser lastTimeUsed: aTime 
	
	^self new initializeCart: aCart client: anUser lastTimeUsed: aTime ! !


!classDefinition: #InternalRestInterface category: 'TusLibros'!
Object subclass: #InternalRestInterface
	instanceVariableNames: 'authenticationSystem catalog carts nextCartId merchantProcessor salesBooks clock sales nextTransactionId'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibros'!

!InternalRestInterface methodsFor: 'accessing' stamp: 'AM 11/30/2020 21:09:49'!
cartAt: aCartId

	^ (carts at: aCartId) cart. ! !

!InternalRestInterface methodsFor: 'accessing' stamp: 'AM 11/30/2020 21:27:27'!
clientSalesBookFor: aCartId 
	
	^ salesBooks at: (carts at: aCartId) client! !

!InternalRestInterface methodsFor: 'accessing' stamp: 'AM 11/30/2020 21:10:31'!
clientUsingCart: aCartId

	^ (carts at: aCartId) client! !

!InternalRestInterface methodsFor: 'accessing' stamp: 'AM 11/30/2020 22:57:40'!
saleFor: aTransactionId 

	^ sales at: aTransactionId! !

!InternalRestInterface methodsFor: 'accessing' stamp: 'AM 11/30/2020 23:33:36'!
salesBookFor: aClient 

	^ salesBooks at: aClient ifAbsent: [ OrderedCollection new ]! !


!InternalRestInterface methodsFor: 'assertions' stamp: 'AM 11/30/2020 21:29:21'!
assertThatCartHasNotTimedOut: aCartId

	(self hasTimedOut: aCartId) ifTrue: [ 
		carts removeKey: aCartId.
		self error: self class cartHasTimedOutErrorDescription ].! !

!InternalRestInterface methodsFor: 'assertions' stamp: 'AM 11/30/2020 19:08:29'!
assertThatCartIdIsValid: aCartId

	(carts includesKey: aCartId) ifFalse: [ self error: self class invalidCartIdErrorDescription ]! !


!InternalRestInterface methodsFor: 'cart management' stamp: 'NNH 11/29/2020 23:33:16'!
addToCart: aCartId product: aProduct
	
	self addToCart: aCartId product: aProduct withOcurrences: 1. ! !

!InternalRestInterface methodsFor: 'cart management' stamp: 'AM 11/30/2020 21:20:41'!
addToCart: aCartId product: aProduct withOcurrences: aNumberOfOccurrences 
	
	self assertThatCartIdIsValid: aCartId.
	self assertThatCartHasNotTimedOut: aCartId.
	
	self updateLastUseOf: aCartId.

	(self cartAt: aCartId)  add: aNumberOfOccurrences of: aProduct! !

!InternalRestInterface methodsFor: 'cart management' stamp: 'AM 11/30/2020 23:05:08'!
checkOut: aCartId withCCN: aCreditCardNumber CCED: anExpirationDate CCO: anOwner on: aDate 
	
	| total creditCard newTransactionId |
	
	self assertThatCartIdIsValid: aCartId.
	self assertThatCartHasNotTimedOut: aCartId.
	
	self updateLastUseOf: aCartId.
	
	creditCard := CreditCard withNumber: aCreditCardNumber
							expiringOn:  anExpirationDate
							owner: anOwner.

	total := ( Cashier toCheckout: (self cartAt: aCartId) 
		charging: creditCard 
		through: merchantProcessor 
		on: aDate 
		registeringOn: ( self clientSalesBookFor: aCartId ))
		checkOut .
	
	newTransactionId := self nextTransactionId.
	
	sales at: newTransactionId put: (self clientSalesBookFor: aCartId) last.
	carts removeKey: aCartId .
	
	^ newTransactionId
! !

!InternalRestInterface methodsFor: 'cart management' stamp: 'AM 11/30/2020 23:21:57'!
createCartForUser: anUser password: aPassword 
	
	| newCartId |
	
	authenticationSystem authenticate: anUser using: aPassword .
	
	newCartId := self nextCartId.
	
	carts at: newCartId put: (InterfaceCartData cart: (Cart acceptingItemsOf: catalog)
											client: anUser
											lastTimeUsed: clock now).
	
	salesBooks at: anUser ifAbsentPut: OrderedCollection new.
	
	^ newCartId. ! !

!InternalRestInterface methodsFor: 'cart management' stamp: 'AM 11/30/2020 21:19:25'!
listCart: aCartId 
	
	self assertThatCartIdIsValid: aCartId.
	self assertThatCartHasNotTimedOut: aCartId.
	
	self updateLastUseOf: aCartId.
	
	^ (self cartAt: aCartId) listCart asBag.! !


!InternalRestInterface methodsFor: 'cart management - private' stamp: 'AM 11/30/2020 23:21:57'!
nextCartId
	
	nextCartId := nextCartId + 1.
	^ nextCartId.! !

!InternalRestInterface methodsFor: 'cart management - private' stamp: 'AM 11/30/2020 23:03:28'!
nextTransactionId
	
	nextTransactionId := nextTransactionId + 1.
	^ nextTransactionId! !


!InternalRestInterface methodsFor: 'client purchases' stamp: 'AM 11/30/2020 23:55:18'!
listPurchasesOf: aClientId password: aPassword 
	
	authenticationSystem authenticate: aClientId using: aPassword .
	
	^ PurchaseBook withSalesBook: (self salesBookFor: aClientId).
	! !


!InternalRestInterface methodsFor: 'initialization' stamp: 'AM 11/30/2020 23:26:28'!
initializeWith: anAuthenticationSystem catalog: aCatalog through: aMerchantProcessor clock: aClockSimulator 
	
	authenticationSystem := anAuthenticationSystem.
	catalog := aCatalog.
	merchantProcessor := aMerchantProcessor.
	clock := aClockSimulator.
	
	nextCartId := 0.
	nextTransactionId := 0.
	
	carts := Dictionary new.
	
	salesBooks := Dictionary new.
	sales := Dictionary new.! !


!InternalRestInterface methodsFor: 'time out - private' stamp: 'AM 11/30/2020 19:57:09'!
hasTimedOut: aCartId
	
	^ 30*minute <= ((self lastTimeFor: aCartId) distanceTo: clock now).! !

!InternalRestInterface methodsFor: 'time out - private' stamp: 'AM 11/30/2020 21:09:16'!
lastTimeFor: aCartId

	^ (carts at: aCartId) lastTimeUsed.! !

!InternalRestInterface methodsFor: 'time out - private' stamp: 'AM 11/30/2020 21:13:29'!
updateLastUseOf: aCartId

	(carts at: aCartId) updateLastUseTo: clock now.
! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'InternalRestInterface class' category: 'TusLibros'!
InternalRestInterface class
	instanceVariableNames: ''!

!InternalRestInterface class methodsFor: 'error descriptions' stamp: 'AM 11/30/2020 18:32:23'!
cartHasTimedOutErrorDescription
	
	^ 'The cart has timed out'.! !

!InternalRestInterface class methodsFor: 'error descriptions' stamp: 'NNH 11/27/2020 20:50:51'!
invalidCartIdErrorDescription
	
	^ 'Invalid cart id'! !


!InternalRestInterface class methodsFor: 'instance creation' stamp: 'AM 11/30/2020 18:29:22'!
with: anAuthenticationSystem catalog: aCatalog through: aMerchantProcessor clock: aClockSimulator 

	^self new initializeWith: anAuthenticationSystem catalog: aCatalog through: aMerchantProcessor clock: aClockSimulator ! !


!classDefinition: #PurchaseBook category: 'TusLibros'!
Object subclass: #PurchaseBook
	instanceVariableNames: 'total products salesBook'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibros'!

!PurchaseBook methodsFor: 'accessing' stamp: 'AM 11/30/2020 22:41:07'!
products

	^ products asBag.! !

!PurchaseBook methodsFor: 'accessing' stamp: 'NNH 11/27/2020 23:54:47'!
total
	
	^ total! !


!PurchaseBook methodsFor: 'adding' stamp: 'NNH 11/29/2020 23:46:11'!
addSale: aSale 
	
	total := aSale total + total.
	products addAllLast: aSale products .! !


!PurchaseBook methodsFor: 'initialization' stamp: 'AM 11/30/2020 23:47:42'!
initializeWithSalesBook: aSalesBook 
	
	total  := aSalesBook sum: [ :aSale | aSale total ] ifEmpty: [ 0 ].
	products := (aSalesBook collect: [ :aSale | aSale products ]) flatten.! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'PurchaseBook class' category: 'TusLibros'!
PurchaseBook class
	instanceVariableNames: ''!

!PurchaseBook class methodsFor: 'instance creation' stamp: 'AM 11/30/2020 23:46:00'!
withSalesBook: aSalesBook

	^ self new initializeWithSalesBook: aSalesBook ! !


!classDefinition: #Sale category: 'TusLibros'!
Object subclass: #Sale
	instanceVariableNames: 'total products'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibros'!

!Sale methodsFor: 'accessing' stamp: 'AM 11/30/2020 23:06:26'!
products
	
	^ products asBag! !

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


!classDefinition: #SalesBook category: 'TusLibros'!
Object subclass: #SalesBook
	instanceVariableNames: 'total products sales'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibros'!

!SalesBook methodsFor: 'as yet unclassified' stamp: 'AM 11/30/2020 23:52:14'!
add: aSale

	sales add: aSale! !

!SalesBook methodsFor: 'as yet unclassified' stamp: 'AM 11/30/2020 23:52:58'!
total

	sales sum: [ :aSale | aSale total ] 
		ifEmpty: [ 0 ]! !


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


!StoreTestObjectsFactory methodsFor: 'clock' stamp: 'AM 11/30/2020 18:57:04'!
clockSimulator

	^ ClockSimulator withTime:
		 ( GregorianDateTime date: November/25/2020 timeOfDay: 12:00:00 ).! !


!StoreTestObjectsFactory methodsFor: 'credit card' stamp: 'AM 11/30/2020 22:46:02'!
expiredCreditCard
	
	^CreditCard withNumber: self validCardId 
			expiringOn:  self pastExpirationDate
			owner: self validOwner.! !

!StoreTestObjectsFactory methodsFor: 'credit card' stamp: 'AM 11/30/2020 20:32:03'!
futureExpirationDate
	
	^ GregorianMonthOfYear year: FixedGregorianDate today year next
							 month: FixedGregorianDate today month! !

!StoreTestObjectsFactory methodsFor: 'credit card' stamp: 'AM 11/30/2020 20:44:06'!
notExpiredCreditCard
	
	^CreditCard withNumber: self validCardId 
				expiringOn: self futureExpirationDate 
				owner: self validOwner! !

!StoreTestObjectsFactory methodsFor: 'credit card' stamp: 'AM 11/30/2020 20:38:38'!
pastExpirationDate
	
	^ GregorianMonthOfYear year: FixedGregorianDate today year previous
							 month: FixedGregorianDate today month! !

!StoreTestObjectsFactory methodsFor: 'credit card' stamp: 'AM 11/30/2020 20:21:54'!
validCardId
	
	^ 10^15 * 4! !

!StoreTestObjectsFactory methodsFor: 'credit card' stamp: 'AM 11/30/2020 19:45:36'!
validOwner
	
	^ 'Maradona'! !


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


!StoreTestObjectsFactory methodsFor: 'merchant processor' stamp: 'NNH 11/27/2020 22:36:33'!
debit: anAmount from: aCreditCard
! !


!StoreTestObjectsFactory methodsFor: 'tus libros interface' stamp: 'AM 11/30/2020 19:31:05'!
invalidCartId

	^ Object new.! !

!StoreTestObjectsFactory methodsFor: 'tus libros interface' stamp: 'AM 11/30/2020 19:27:46'!
tusLibrosInterface
	
	^ InternalRestInterface with: self authenticationSystem 
					catalog: self defaultCatalog 
					through: self
					clock: self clockSimulator.
! !
