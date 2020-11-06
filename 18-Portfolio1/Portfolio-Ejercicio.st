!classDefinition: #PortfolioTest category: 'Portfolio-Ejercicio'!
TestCase subclass: #PortfolioTest
	instanceVariableNames: 'emptyPortfolio hundredDollarsAccount aDeposit hundredDollarsPortfolio emptyAccount zeroBalancePortfolio twoAccountsPortfolio anotherPortfolio'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Portfolio-Ejercicio'!

!PortfolioTest methodsFor: 'setUp / tearDown' stamp: 'NNH 11/6/2020 16:23:24'!
setUp
		
	emptyAccount := ReceptiveAccount new.
	hundredDollarsAccount := ReceptiveAccount new.
	
	aDeposit := Deposit register: 100 on: hundredDollarsAccount.
	
	emptyPortfolio := Portfolio new.
	hundredDollarsPortfolio := Portfolio new.
	hundredDollarsPortfolio addFinancialProduct: hundredDollarsAccount.
	zeroBalancePortfolio := Portfolio new.
	zeroBalancePortfolio addFinancialProduct: emptyAccount.
	anotherPortfolio := Portfolio new.
	twoAccountsPortfolio := Portfolio new.
	twoAccountsPortfolio addFinancialProduct: emptyAccount.	
	twoAccountsPortfolio addFinancialProduct: hundredDollarsAccount.
	
	! !


!PortfolioTest methodsFor: 'testing balance' stamp: 'NNH 11/6/2020 15:58:59'!
test01BalanceOfEmptyPortfolioIsZero
	
	self assert: 0 equals: emptyPortfolio balance.
	
	! !

!PortfolioTest methodsFor: 'testing balance' stamp: 'NNH 11/6/2020 15:59:24'!
test02BalanceOfPortfolioWithOneAccountIsBalanceOfThatAccount
	
	self assert: 100 equals: hundredDollarsPortfolio balance.
	
	! !

!PortfolioTest methodsFor: 'testing balance' stamp: 'NNH 11/6/2020 16:01:11'!
test03BalanceOfPortfolioWithMoreThanOneAccountIsSumOfBalances

	self assert: 100 equals: twoAccountsPortfolio balance.
	
	! !


!PortfolioTest methodsFor: 'testing register operations' stamp: 'NNH 11/6/2020 16:07:07'!
test04EmptyPortfolioHasRegisteredNoTransactions

	self deny: (zeroBalancePortfolio hasRegistered: aDeposit).
	
	! !

!PortfolioTest methodsFor: 'testing register operations' stamp: 'NNH 11/6/2020 16:02:06'!
test05PortfolioWithOneAccountRegistersATransactionOfThatAccount

	self assert: (hundredDollarsPortfolio hasRegistered: aDeposit ).
	
	! !

!PortfolioTest methodsFor: 'testing register operations' stamp: 'NNH 11/6/2020 16:02:27'!
test06APortfolioWithMoreThanOneAccountRegistersATransactionThatIsNotFromTheFirstAccount

	self assert: (twoAccountsPortfolio hasRegistered: aDeposit).
	
	! !


!PortfolioTest methodsFor: 'testing transactions' stamp: 'NNH 11/6/2020 16:03:03'!
test07EmptyPortfolioHasNoTransactions

	self assert: emptyPortfolio transactions isEmpty.
	
	! !

!PortfolioTest methodsFor: 'testing transactions' stamp: 'NNH 11/6/2020 16:03:27'!
test08PortfolioWithOneAccountHasTheTransactionsOfThatAccount

	self assert: 1 equals: hundredDollarsPortfolio transactions size.
	self assert: hundredDollarsPortfolio transactions includes: aDeposit.
	
	! !

!PortfolioTest methodsFor: 'testing transactions' stamp: 'NNH 11/6/2020 16:04:04'!
test09APortfolioWithMoreThanOneAccountHasTheTransactionsOfItsAccounts

	self assert: 1 equals: twoAccountsPortfolio transactions size.
	self assert: twoAccountsPortfolio transactions includes: aDeposit.
	
	! !


!PortfolioTest methodsFor: 'testing dependencies' stamp: 'NNH 11/6/2020 16:04:45'!
test10PortfolioShouldNotAddItself

	self should: [emptyPortfolio addFinancialProduct: emptyPortfolio] raise: Error.! !

!PortfolioTest methodsFor: 'testing dependencies' stamp: 'NNH 11/6/2020 16:05:42'!
test11PortfolioShouldNotAddParentPortfolio
	
	emptyPortfolio addFinancialProduct: hundredDollarsPortfolio .

	self should: [hundredDollarsPortfolio addFinancialProduct: emptyPortfolio] raise: Error.! !

!PortfolioTest methodsFor: 'testing dependencies' stamp: 'NNH 11/6/2020 16:07:41'!
test12PortfolioShouldNotAddAccountIfTheyBothBelongToAnotherPortfolio

	emptyPortfolio addFinancialProduct: zeroBalancePortfolio.
	emptyPortfolio addFinancialProduct: hundredDollarsPortfolio .

	self should: [zeroBalancePortfolio addFinancialProduct: hundredDollarsPortfolio ]
	raise: Error
	withMessageText: Portfolio canNotBelongToACommonPortfolioErrorDescription.! !

!PortfolioTest methodsFor: 'testing dependencies' stamp: 'NNH 11/6/2020 16:08:59'!
test13PortfolioShouldNotAddAnotherPortfolioWhenTheyShareAnAccount
	
	emptyPortfolio addFinancialProduct: hundredDollarsPortfolio.
	zeroBalancePortfolio addFinancialProduct: hundredDollarsPortfolio.

	self should: [emptyPortfolio addFinancialProduct: zeroBalancePortfolio]
	raise: Error
	withMessageText: Portfolio canNotHaveAnAccountInCommonErrorDescription.! !

!PortfolioTest methodsFor: 'testing dependencies' stamp: 'NNH 11/6/2020 16:23:45'!
test14PortfolioShouldNotContainAccountTwice

	emptyPortfolio addFinancialProduct: zeroBalancePortfolio .
	emptyPortfolio addFinancialProduct: hundredDollarsPortfolio .
	hundredDollarsPortfolio addFinancialProduct: anotherPortfolio .

	self should: [zeroBalancePortfolio addFinancialProduct: anotherPortfolio]
	raise: Error
	withMessageText: Portfolio canNotBelongToACommonPortfolioErrorDescription.! !

!PortfolioTest methodsFor: 'testing dependencies' stamp: 'NNH 11/6/2020 16:23:57'!
test15MoreThanOnePortfolioWithTheSameAccountsShouldNotRaise
	
	emptyPortfolio addFinancialProduct: hundredDollarsPortfolio .
	emptyPortfolio addFinancialProduct: anotherPortfolio .
	zeroBalancePortfolio addFinancialProduct: hundredDollarsPortfolio.

	self shouldnt: [zeroBalancePortfolio addFinancialProduct: anotherPortfolio] raise: Error.
! !


!classDefinition: #ReceptiveAccountTest category: 'Portfolio-Ejercicio'!
TestCase subclass: #ReceptiveAccountTest
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Portfolio-Ejercicio'!

!ReceptiveAccountTest methodsFor: 'tests' stamp: 'NR 11/2/2020 17:13:44'!
test01ReceptiveAccountHaveZeroAsBalanceWhenCreated 

	| account |
	
	account := ReceptiveAccount new.

	self assert: 0 equals: account balance.
! !

!ReceptiveAccountTest methodsFor: 'tests' stamp: 'NR 11/2/2020 17:13:48'!
test02DepositIncreasesBalanceOnTransactionValue 

	| account |
	
	account := ReceptiveAccount  new.
	Deposit register: 100 on: account.
		
	self assert: 100 equals: account balance.
! !

!ReceptiveAccountTest methodsFor: 'tests' stamp: 'NR 11/2/2020 17:13:52'!
test03WithdrawDecreasesBalanceOnTransactionValue 

	| account |
	
	account := ReceptiveAccount new.
	Deposit register: 100 on: account.
	Withdraw register: 50 on: account.
		
	self assert: 50 equals: account balance.
! !

!ReceptiveAccountTest methodsFor: 'tests' stamp: 'HAW 5/23/2019 15:20:32'!
test04WithdrawValueMustBePositive 

	| account withdrawValue |
	
	account := ReceptiveAccount new.
	withdrawValue := 50.
	
	self assert: withdrawValue equals: (Withdraw register: withdrawValue on: account) value
! !

!ReceptiveAccountTest methodsFor: 'tests' stamp: 'HAW 5/23/2019 15:20:46'!
test05ReceptiveAccountKnowsRegisteredTransactions 

	| account deposit withdraw |
	
	account := ReceptiveAccount new.
	deposit := Deposit register: 100 on: account.
	withdraw := Withdraw register: 50 on: account.
		
	self assert: (account hasRegistered: deposit).
	self assert: (account hasRegistered: withdraw).
! !

!ReceptiveAccountTest methodsFor: 'tests' stamp: 'NR 11/2/2020 17:14:15'!
test06ReceptiveAccountDoNotKnowNotRegisteredTransactions

	| deposit withdraw account |
	
	account := ReceptiveAccount new.
	deposit :=  Deposit for: 100.
	withdraw := Withdraw for: 50.
		
	self deny: (account hasRegistered: deposit).
	self deny: (account hasRegistered:withdraw).
! !

!ReceptiveAccountTest methodsFor: 'tests' stamp: 'NR 11/2/2020 17:14:01'!
test07AccountKnowsItsTransactions 

	| account1 deposit1 |
	
	account1 := ReceptiveAccount new.
	
	deposit1 := Deposit register: 50 on: account1.
		
	self assert: 1 equals: account1 transactions size.
	self assert: (account1 transactions includes: deposit1).
! !


!classDefinition: #AccountTransaction category: 'Portfolio-Ejercicio'!
Object subclass: #AccountTransaction
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Portfolio-Ejercicio'!

!AccountTransaction methodsFor: 'value' stamp: 'HernanWilkinson 9/12/2011 12:25'!
value 

	self subclassResponsibility ! !


!AccountTransaction methodsFor: 'balance operations' stamp: 'NNH 11/2/2020 20:35:23'!
addToBalance: aBalance
	self subclassResponsibility.! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'AccountTransaction class' category: 'Portfolio-Ejercicio'!
AccountTransaction class
	instanceVariableNames: ''!

!AccountTransaction class methodsFor: 'instance creation' stamp: 'NR 10/17/2019 03:22:00'!
register: aValue on: account

	| transaction |
	
	transaction := self for: aValue.
	account register: transaction.
		
	^ transaction! !


!classDefinition: #Deposit category: 'Portfolio-Ejercicio'!
AccountTransaction subclass: #Deposit
	instanceVariableNames: 'value'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Portfolio-Ejercicio'!

!Deposit methodsFor: 'initialization' stamp: 'HernanWilkinson 7/13/2011 18:45'!
initializeFor: aValue

	value := aValue ! !


!Deposit methodsFor: 'value' stamp: 'HernanWilkinson 7/13/2011 18:38'!
value

	^ value! !


!Deposit methodsFor: 'balance operations' stamp: 'NNH 11/2/2020 20:36:05'!
addToBalance: aBalance
	^ aBalance + value.! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'Deposit class' category: 'Portfolio-Ejercicio'!
Deposit class
	instanceVariableNames: ''!

!Deposit class methodsFor: 'instance creation' stamp: 'HernanWilkinson 7/13/2011 18:38'!
for: aValue

	^ self new initializeFor: aValue ! !


!classDefinition: #Withdraw category: 'Portfolio-Ejercicio'!
AccountTransaction subclass: #Withdraw
	instanceVariableNames: 'value'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Portfolio-Ejercicio'!

!Withdraw methodsFor: 'initialization' stamp: 'HernanWilkinson 7/13/2011 18:46'!
initializeFor: aValue

	value := aValue ! !


!Withdraw methodsFor: 'value' stamp: 'HernanWilkinson 7/13/2011 18:33'!
value

	^ value! !


!Withdraw methodsFor: 'balance operations' stamp: 'NNH 11/2/2020 20:36:55'!
addToBalance: aBalance 
	^ aBalance - value.! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'Withdraw class' category: 'Portfolio-Ejercicio'!
Withdraw class
	instanceVariableNames: ''!

!Withdraw class methodsFor: 'instance creation' stamp: 'HernanWilkinson 7/13/2011 18:33'!
for: aValue

	^ self new initializeFor: aValue ! !


!classDefinition: #FinancialProduct category: 'Portfolio-Ejercicio'!
Object subclass: #FinancialProduct
	instanceVariableNames: 'parents'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Portfolio-Ejercicio'!

!FinancialProduct methodsFor: 'inserting - private' stamp: 'NNH 11/5/2020 23:10:08'!
addParent: aPortfolio 
	
	parents add: aPortfolio.! !


!FinancialProduct methodsFor: 'balance' stamp: 'NNH 11/6/2020 15:39:55'!
balance

	self subclassResponsibility.! !


!FinancialProduct methodsFor: 'testing' stamp: 'NNH 11/6/2020 15:40:19'!
hasRegistered: aTransaction

	self subclassResponsibility.! !


!FinancialProduct methodsFor: 'transactions' stamp: 'NNH 11/6/2020 15:40:48'!
transactions

	self subclassResponsibility.! !


!FinancialProduct methodsFor: 'testing dependencies' stamp: 'NNH 11/6/2020 15:39:25'!
addFinancialProductTo: aCollectionOfFinancialProducts
		
	self subclassResponsibility.! !

!FinancialProduct methodsFor: 'testing dependencies' stamp: 'NNH 11/6/2020 15:39:45'!
financialProducts
	
	| accountsInPortfolio |
	
	accountsInPortfolio := OrderedCollection new.
	self addFinancialProductTo: accountsInPortfolio.
	
	^ accountsInPortfolio.! !

!FinancialProduct methodsFor: 'testing dependencies' stamp: 'NNH 11/6/2020 15:18:10'!
includesFinancialProduct: anAccountToSearch
	
	self subclassResponsibility.! !

!FinancialProduct methodsFor: 'testing dependencies' stamp: 'NNH 11/6/2020 15:40:34'!
isInAProductWith: aFinancialProduct
	
	^ (parents anySatisfy: [:aParent | aParent isInAProductWith: aFinancialProduct ]) or: [
		self includesFinancialProduct: aFinancialProduct
		].
	
	
! !


!FinancialProduct methodsFor: 'assertions' stamp: 'NNH 11/6/2020 15:40:11'!
hasProductsInCommonWith: aFinancialProduct

	^ (self financialProducts intersection: aFinancialProduct financialProducts) isEmpty not! !


!classDefinition: #Portfolio category: 'Portfolio-Ejercicio'!
FinancialProduct subclass: #Portfolio
	instanceVariableNames: 'financialProducts'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Portfolio-Ejercicio'!

!Portfolio methodsFor: 'assertions' stamp: 'NNH 11/6/2020 15:36:07'!
assertFinancialProductCanBeAdded: aFinancialProduct

	(self isInAProductWith: aFinancialProduct) ifTrue: [self signalCanNotBelongToACommonPortfolio ].
	(self hasProductsInCommonWith: aFinancialProduct)	 ifTrue: [self signalCanNotHaveAnAccountInCommon ].! !

!Portfolio methodsFor: 'assertions' stamp: 'NNH 11/6/2020 15:34:32'!
signalCanNotBelongToACommonPortfolio

	^ self error: self class canNotBelongToACommonPortfolioErrorDescription! !

!Portfolio methodsFor: 'assertions' stamp: 'NNH 11/6/2020 15:34:54'!
signalCanNotHaveAnAccountInCommon

	^ self error: self class canNotHaveAnAccountInCommonErrorDescription! !


!Portfolio methodsFor: 'balance' stamp: 'NNH 11/6/2020 15:36:21'!
balance
	^ financialProducts sum: [:aFinancialProduct | aFinancialProduct balance] ifEmpty: [0].! !


!Portfolio methodsFor: 'initializing' stamp: 'NNH 11/6/2020 15:14:38'!
initialize
	
	financialProducts := OrderedCollection new.
	parents := OrderedCollection new.! !


!Portfolio methodsFor: 'inserting' stamp: 'NNH 11/6/2020 15:35:10'!
addFinancialProduct: aFinancialProduct 
	
	self assertFinancialProductCanBeAdded: aFinancialProduct.
	
	aFinancialProduct addParent: self.	
	financialProducts add: aFinancialProduct.! !


!Portfolio methodsFor: 'testing' stamp: 'NNH 11/6/2020 15:36:35'!
hasRegistered: aTransaction
	^ financialProducts anySatisfy: [:aFinancialProduct | aFinancialProduct hasRegistered: aTransaction].! !


!Portfolio methodsFor: 'testing dependencies' stamp: 'NNH 11/6/2020 15:35:41'!
addFinancialProductTo: aCollectionOfFinancialProducts
		
	aCollectionOfFinancialProducts add: self.
	financialProducts do: [:aFinancialProduct | aFinancialProduct addFinancialProductTo: aCollectionOfFinancialProducts].
	
	
	
! !

!Portfolio methodsFor: 'testing dependencies' stamp: 'NNH 11/6/2020 15:36:58'!
includesFinancialProduct: aFinancialProductToSearch
	
	^ (aFinancialProductToSearch == self) or: [
		financialProducts anySatisfy: [:aFinancialProduct | aFinancialProduct includesFinancialProduct: aFinancialProductToSearch]
		].
	
	
! !


!Portfolio methodsFor: 'transactions' stamp: 'NNH 11/4/2020 19:09:03'!
transactions
	
	| aCollectionOfTransactions |
	
	aCollectionOfTransactions := OrderedCollection new.
	self addTransactionsTo: aCollectionOfTransactions.
	
	^aCollectionOfTransactions.! !


!Portfolio methodsFor: 'transactions - private' stamp: 'NNH 11/6/2020 15:35:57'!
addTransactionsTo: aCollectionOfTransactions
	
	financialProducts do: [ :aFinancialProduct | aFinancialProduct addTransactionsTo: aCollectionOfTransactions ].! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'Portfolio class' category: 'Portfolio-Ejercicio'!
Portfolio class
	instanceVariableNames: ''!

!Portfolio class methodsFor: 'as yet unclassified' stamp: 'NNH 11/2/2020 20:16:15'!
new
	
	^ self basicNew initialize.! !


!Portfolio class methodsFor: 'error descriptions' stamp: 'NNH 11/4/2020 23:54:30'!
canNotBelongToACommonPortfolioErrorDescription
	^ 'There is a portfolio containing both portfolios'! !

!Portfolio class methodsFor: 'error descriptions' stamp: 'NNH 11/4/2020 23:58:51'!
canNotHaveAnAccountInCommonErrorDescription
	^ 'Portfolios should not share an account'! !

!Portfolio class methodsFor: 'error descriptions' stamp: 'NNH 11/2/2020 21:15:01'!
cannotIncludeItselfErrorDescription
	^ 'A portfolio cannot include itself'.! !


!classDefinition: #ReceptiveAccount category: 'Portfolio-Ejercicio'!
FinancialProduct subclass: #ReceptiveAccount
	instanceVariableNames: 'transactions'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Portfolio-Ejercicio'!

!ReceptiveAccount methodsFor: 'balance' stamp: 'NNH 11/2/2020 20:34:42'!
balance

	^ transactions inject: 0 into: [:balance :aTransaction | aTransaction addToBalance: balance].

! !


!ReceptiveAccount methodsFor: 'initialization' stamp: 'NNH 11/4/2020 20:24:19'!
initialize

	transactions := OrderedCollection new.
	parents := OrderedCollection new.! !


!ReceptiveAccount methodsFor: 'testing' stamp: 'NR 10/17/2019 03:28:43'!
hasRegistered: aTransaction

	^ transactions includes: aTransaction 
! !


!ReceptiveAccount methodsFor: 'testing dependencies' stamp: 'NNH 11/6/2020 15:38:47'!
addFinancialProductTo: aCollectionOfFinancialProducts
		
	aCollectionOfFinancialProducts add: self.! !

!ReceptiveAccount methodsFor: 'testing dependencies' stamp: 'NNH 11/6/2020 15:39:07'!
includesFinancialProduct: aFinancialProductToSearch
	
	^ aFinancialProductToSearch == self.! !


!ReceptiveAccount methodsFor: 'transactions' stamp: 'HernanWilkinson 7/13/2011 18:37'!
register: aTransaction

	transactions add: aTransaction 
! !

!ReceptiveAccount methodsFor: 'transactions' stamp: 'HernanWilkinson 7/13/2011 18:37'!
transactions 

	^ transactions copy! !


!ReceptiveAccount methodsFor: 'transactions - private' stamp: 'NNH 11/5/2020 23:14:22'!
addTransactionsTo: aCollectionOfTransactions
	
	aCollectionOfTransactions addAllLast: self transactions.! !


!classDefinition: #Portfolio category: 'Portfolio-Ejercicio'!
FinancialProduct subclass: #Portfolio
	instanceVariableNames: 'financialProducts'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Portfolio-Ejercicio'!

!Portfolio methodsFor: 'assertions' stamp: 'NNH 11/6/2020 15:36:07'!
assertFinancialProductCanBeAdded: aFinancialProduct

	(self isInAProductWith: aFinancialProduct) ifTrue: [self signalCanNotBelongToACommonPortfolio ].
	(self hasProductsInCommonWith: aFinancialProduct)	 ifTrue: [self signalCanNotHaveAnAccountInCommon ].! !

!Portfolio methodsFor: 'assertions' stamp: 'NNH 11/6/2020 15:34:32'!
signalCanNotBelongToACommonPortfolio

	^ self error: self class canNotBelongToACommonPortfolioErrorDescription! !

!Portfolio methodsFor: 'assertions' stamp: 'NNH 11/6/2020 15:34:54'!
signalCanNotHaveAnAccountInCommon

	^ self error: self class canNotHaveAnAccountInCommonErrorDescription! !


!Portfolio methodsFor: 'balance' stamp: 'NNH 11/6/2020 15:36:21'!
balance
	^ financialProducts sum: [:aFinancialProduct | aFinancialProduct balance] ifEmpty: [0].! !


!Portfolio methodsFor: 'initializing' stamp: 'NNH 11/6/2020 15:14:38'!
initialize
	
	financialProducts := OrderedCollection new.
	parents := OrderedCollection new.! !


!Portfolio methodsFor: 'inserting' stamp: 'NNH 11/6/2020 15:35:10'!
addFinancialProduct: aFinancialProduct 
	
	self assertFinancialProductCanBeAdded: aFinancialProduct.
	
	aFinancialProduct addParent: self.	
	financialProducts add: aFinancialProduct.! !


!Portfolio methodsFor: 'testing' stamp: 'NNH 11/6/2020 15:36:35'!
hasRegistered: aTransaction
	^ financialProducts anySatisfy: [:aFinancialProduct | aFinancialProduct hasRegistered: aTransaction].! !


!Portfolio methodsFor: 'testing dependencies' stamp: 'NNH 11/6/2020 15:35:41'!
addFinancialProductTo: aCollectionOfFinancialProducts
		
	aCollectionOfFinancialProducts add: self.
	financialProducts do: [:aFinancialProduct | aFinancialProduct addFinancialProductTo: aCollectionOfFinancialProducts].
	
	
	
! !

!Portfolio methodsFor: 'testing dependencies' stamp: 'NNH 11/6/2020 15:36:58'!
includesFinancialProduct: aFinancialProductToSearch
	
	^ (aFinancialProductToSearch == self) or: [
		financialProducts anySatisfy: [:aFinancialProduct | aFinancialProduct includesFinancialProduct: aFinancialProductToSearch]
		].
	
	
! !


!Portfolio methodsFor: 'transactions' stamp: 'NNH 11/4/2020 19:09:03'!
transactions
	
	| aCollectionOfTransactions |
	
	aCollectionOfTransactions := OrderedCollection new.
	self addTransactionsTo: aCollectionOfTransactions.
	
	^aCollectionOfTransactions.! !


!Portfolio methodsFor: 'transactions - private' stamp: 'NNH 11/6/2020 15:35:57'!
addTransactionsTo: aCollectionOfTransactions
	
	financialProducts do: [ :aFinancialProduct | aFinancialProduct addTransactionsTo: aCollectionOfTransactions ].! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'Portfolio class' category: 'Portfolio-Ejercicio'!
Portfolio class
	instanceVariableNames: ''!

!Portfolio class methodsFor: 'as yet unclassified' stamp: 'NNH 11/2/2020 20:16:15'!
new
	
	^ self basicNew initialize.! !


!Portfolio class methodsFor: 'error descriptions' stamp: 'NNH 11/4/2020 23:54:30'!
canNotBelongToACommonPortfolioErrorDescription
	^ 'There is a portfolio containing both portfolios'! !

!Portfolio class methodsFor: 'error descriptions' stamp: 'NNH 11/4/2020 23:58:51'!
canNotHaveAnAccountInCommonErrorDescription
	^ 'Portfolios should not share an account'! !

!Portfolio class methodsFor: 'error descriptions' stamp: 'NNH 11/2/2020 21:15:01'!
cannotIncludeItselfErrorDescription
	^ 'A portfolio cannot include itself'.! !


!classDefinition: #ReceptiveAccount category: 'Portfolio-Ejercicio'!
FinancialProduct subclass: #ReceptiveAccount
	instanceVariableNames: 'transactions'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Portfolio-Ejercicio'!

!ReceptiveAccount methodsFor: 'balance' stamp: 'NNH 11/2/2020 20:34:42'!
balance

	^ transactions inject: 0 into: [:balance :aTransaction | aTransaction addToBalance: balance].

! !


!ReceptiveAccount methodsFor: 'initialization' stamp: 'NNH 11/4/2020 20:24:19'!
initialize

	transactions := OrderedCollection new.
	parents := OrderedCollection new.! !


!ReceptiveAccount methodsFor: 'testing' stamp: 'NR 10/17/2019 03:28:43'!
hasRegistered: aTransaction

	^ transactions includes: aTransaction 
! !


!ReceptiveAccount methodsFor: 'testing dependencies' stamp: 'NNH 11/6/2020 15:38:47'!
addFinancialProductTo: aCollectionOfFinancialProducts
		
	aCollectionOfFinancialProducts add: self.! !

!ReceptiveAccount methodsFor: 'testing dependencies' stamp: 'NNH 11/6/2020 15:39:07'!
includesFinancialProduct: aFinancialProductToSearch
	
	^ aFinancialProductToSearch == self.! !


!ReceptiveAccount methodsFor: 'transactions' stamp: 'HernanWilkinson 7/13/2011 18:37'!
register: aTransaction

	transactions add: aTransaction 
! !

!ReceptiveAccount methodsFor: 'transactions' stamp: 'HernanWilkinson 7/13/2011 18:37'!
transactions 

	^ transactions copy! !


!ReceptiveAccount methodsFor: 'transactions - private' stamp: 'NNH 11/5/2020 23:14:22'!
addTransactionsTo: aCollectionOfTransactions
	
	aCollectionOfTransactions addAllLast: self transactions.! !
