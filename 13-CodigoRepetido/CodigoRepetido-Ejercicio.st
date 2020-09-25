!classDefinition: #CantSuspend category: #'CodigoRepetido-Ejercicio'!
Error subclass: #CantSuspend
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'CodigoRepetido-Ejercicio'!


!classDefinition: #NotFound category: #'CodigoRepetido-Ejercicio'!
Error subclass: #NotFound
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'CodigoRepetido-Ejercicio'!


!classDefinition: #CustomerBookTest category: #'CodigoRepetido-Ejercicio'!
TestCase subclass: #CustomerBookTest
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'CodigoRepetido-Ejercicio'!

!CustomerBookTest methodsFor: 'testing' stamp: 'AM 9/22/2020 10:39:30'!
test01AddingCustomerShouldNotTakeMoreThan50Milliseconds

	| customerBook johnLennon |
	
	johnLennon := 'John Lennon'.
	
	customerBook := CustomerBook new.
	
	self sendingMessage: #addCustomerNamed: to: customerBook withCollaborator: johnLennon shouldTakeLessThan: 50
	
! !

!CustomerBookTest methodsFor: 'testing' stamp: 'AM 9/22/2020 10:39:20'!
test02RemovingCustomerShouldNotTakeMoreThan100Milliseconds

	| customerBook paulMcCartney |
	
	paulMcCartney := 'Paul McCartney'.
	
	customerBook := self newCustomerBookWithCustomerNamed: paulMcCartney.
	  
	self sendingMessage: #removeCustomerNamed: to: customerBook withCollaborator: paulMcCartney shouldTakeLessThan: 100 
	
! !

!CustomerBookTest methodsFor: 'testing' stamp: 'AM 9/22/2020 10:36:49'!
test03CanNotAddACustomerWithEmptyName 

	| customerBook emptyNameShouldNotBeAdded emptyName |

	customerBook := CustomerBook new.
	emptyName := ''.

	emptyNameShouldNotBeAdded := [:anError | 
		self assert: anError messageText = CustomerBook customerCanNotBeEmptyErrorMessage.
		self assert: customerBook isEmpty.].
	
	self sendingMessage: #addCustomerNamed: to: customerBook withCollaborator: emptyName shouldSignal: Error andVerify: emptyNameShouldNotBeAdded 
! !

!CustomerBookTest methodsFor: 'testing' stamp: 'AM 9/22/2020 10:37:21'!
test04CanNotRemoveAnInvalidCustomer
	
	| customerBook johnLennon onlyOneCustomer paulMcCartney |
			
	johnLennon := 'John Lennon'.
	paulMcCartney := 'Paul McCartney'.
	
	customerBook := self newCustomerBookWithCustomerNamed: johnLennon.
	onlyOneCustomer := self closureToCheckIf: customerBook onlyHasCustomerNamed: johnLennon.
	
	self sendingMessage: #removeCustomerNamed: to: customerBook withCollaborator: paulMcCartney shouldSignal: NotFound andVerify: onlyOneCustomer
	
! !

!CustomerBookTest methodsFor: 'testing' stamp: 'NNH 9/18/2020 21:17:48'!
test05SuspendingACustomerShouldNotRemoveItFromCustomerBook

	| customerBook paulMcCartney |
	
	paulMcCartney := 'Paul McCartney'.
	customerBook := self newCustomerBookWithSuspendedCustomer: paulMcCartney.
	
	self customerBook: customerBook shouldHaveActive: 0 suspended: 1 andTotal: 1.
	self assert: (customerBook includesCustomerNamed: paulMcCartney).
	

	
! !

!CustomerBookTest methodsFor: 'testing' stamp: 'NNH 9/18/2020 22:04:04'!
test06RemovingASuspendedCustomerShouldRemoveItFromCustomerBook

	| customerBook paulMcCartney |
	
	paulMcCartney := 'Paul McCartney'.
	customerBook := self newCustomerBookWithSuspendedAndRemovedCustomer: paulMcCartney.
	
	self customerBook: customerBook shouldHaveActive: 0 suspended: 0 andTotal: 0. 
	self deny: (customerBook includesCustomerNamed: paulMcCartney).


	
! !

!CustomerBookTest methodsFor: 'testing' stamp: 'AM 9/22/2020 10:38:50'!
test07CanNotSuspendAnInvalidCustomer
	
	| customerBook johnLennon onlyOneCustomer georgeHarrison |
			
	johnLennon := 'John Lennon'.
	georgeHarrison := 'George Harrison'.
	
	customerBook := self newCustomerBookWithCustomerNamed: johnLennon.
	onlyOneCustomer := self closureToCheckIf: customerBook onlyHasCustomerNamed: johnLennon.
	
	self sendingMessage: #suspendCustomerNamed: to: customerBook withCollaborator:  georgeHarrison shouldSignal: CantSuspend andVerify: onlyOneCustomer! !

!CustomerBookTest methodsFor: 'testing' stamp: 'AM 9/22/2020 10:38:57'!
test08CanNotSuspendAnAlreadySuspendedCustomer
	
	| customerBook johnLennon onlyOneCustomer |
			
	johnLennon := 'John Lennon'.
	
	customerBook := self newCustomerBookWithSuspendedCustomer: johnLennon.
	onlyOneCustomer := self closureToCheckIf: customerBook onlyHasCustomerNamed: johnLennon.
	
	self sendingMessage: #suspendCustomerNamed: to: customerBook withCollaborator: johnLennon shouldSignal: CantSuspend andVerify: onlyOneCustomer! !


!CustomerBookTest methodsFor: 'testing setup - private' stamp: 'AM 9/21/2020 18:49:20'!
newCustomerBookWithCustomerNamed: aCustomerNameToAdd
	
	| customerBook |
	
	customerBook := CustomerBook new.
	customerBook addCustomerNamed: aCustomerNameToAdd.
	
	^customerBook.
	! !

!CustomerBookTest methodsFor: 'testing setup - private' stamp: 'AM 9/21/2020 19:11:58'!
newCustomerBookWithSuspendedAndRemovedCustomer: aCustomerNameToSuspendAndRemove
	
	| customerBook |
	
	customerBook := self newCustomerBookWithSuspendedCustomer: aCustomerNameToSuspendAndRemove .
	customerBook removeCustomerNamed: aCustomerNameToSuspendAndRemove.
	
	^customerBook.
	! !

!CustomerBookTest methodsFor: 'testing setup - private' stamp: 'NNH 9/21/2020 19:53:42'!
newCustomerBookWithSuspendedCustomer: aCustomerNameToSuspend
	
	| customerBook |
	
	customerBook := self newCustomerBookWithCustomerNamed: aCustomerNameToSuspend.
	customerBook suspendCustomerNamed: aCustomerNameToSuspend.
	
	^customerBook.
	! !


!CustomerBookTest methodsFor: 'testing verification - private' stamp: 'AM 9/19/2020 12:35:44'!
checkCostumerBook: aCostumerBookToTest onlyHasCustomerNamed: aCustomerNameToSearch
	
	^ [ :anError | 
		self assert: aCostumerBookToTest numberOfCustomers = 1.
		self assert: (aCostumerBookToTest includesCustomerNamed: aCustomerNameToSearch) ].
		
! !

!CustomerBookTest methodsFor: 'testing verification - private' stamp: 'AM 9/21/2020 19:36:03'!
closureToCheckIf: aCostumerBookToTest onlyHasCustomerNamed: aCustomerNameToSearch
	
	^ [self assert: aCostumerBookToTest numberOfCustomers = 1.
	    self assert: (aCostumerBookToTest includesCustomerNamed: aCustomerNameToSearch) ].
		
! !

!CustomerBookTest methodsFor: 'testing verification - private' stamp: 'NNH 9/21/2020 19:52:38'!
customerBook: aCustomerBookToTestCustomers shouldHave: aNumberOfCustomers customersOfType: aMessageToObtainNumberOfCustomersOfType

	self assert: aNumberOfCustomers equals: (aCustomerBookToTestCustomers perform: aMessageToObtainNumberOfCustomersOfType).


	
! !

!CustomerBookTest methodsFor: 'testing verification - private' stamp: 'AM 9/19/2020 15:56:17'!
customerBook: aCustomerBookToTestCustomers shouldHaveActive: numberOfActiveCustomers suspended: numberOfSuspendedCustomers andTotal: totalNumberOfCustomers

	|numberOfCustomersPerType |
	
	numberOfCustomersPerType := Dictionary new
		add: #numberOfActiveCustomers -> numberOfActiveCustomers;
		add: #numberOfSuspendedCustomers -> numberOfSuspendedCustomers; 
		add: #numberOfCustomers -> totalNumberOfCustomers; yourself.
	
	numberOfCustomersPerType keys do: [ :aTypeOfCustomer | | numberOfCustomersOfType |
		numberOfCustomersOfType := numberOfCustomersPerType at: aTypeOfCustomer.
		self customerBook: aCustomerBookToTestCustomers shouldHave: numberOfCustomersOfType customersOfType: aTypeOfCustomer
		].


	
! !

!CustomerBookTest methodsFor: 'testing verification - private' stamp: 'NNH 9/21/2020 19:50:33'!
sendingMessage: aMessageToSend to: aReceivingCustomerBook withCollaborator: aCustomerAsCollaborator shouldSignal: aSignalError andVerify: conditionsToCheckOnSignal

	[ aReceivingCustomerBook perform: aMessageToSend withArguments: (Array with: aCustomerAsCollaborator).
	self fail ]
		on: aSignalError 
		do: conditionsToCheckOnSignal ! !

!CustomerBookTest methodsFor: 'testing verification - private' stamp: 'NNH 9/21/2020 19:51:10'!
sendingMessage: aMessageToSend to: aReceivingCustomerBook withCollaborator: customerAsCollaborator shouldTakeLessThan: maxNumberOfMilliseconds
	
	| millisecondsAfterRunning millisecondsBeforeRunning |
	
	millisecondsBeforeRunning := Time millisecondClockValue * millisecond.
	aReceivingCustomerBook perform: aMessageToSend withArguments:  (Array with: customerAsCollaborator ).
	millisecondsAfterRunning := Time millisecondClockValue * millisecond.
	
	self assert: (millisecondsAfterRunning - millisecondsBeforeRunning) < (maxNumberOfMilliseconds * millisecond)! !


!classDefinition: #CustomerBook category: #'CodigoRepetido-Ejercicio'!
Object subclass: #CustomerBook
	instanceVariableNames: 'suspended active'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'CodigoRepetido-Ejercicio'!

!CustomerBook methodsFor: 'initialization' stamp: 'NR 9/17/2020 07:23:04'!
initialize

	active := OrderedCollection new.
	suspended:= OrderedCollection new.! !


!CustomerBook methodsFor: 'customer information' stamp: 'AM 9/21/2020 19:05:36'!
includesCustomerNamed: aCustomerNameToSearch

	^(self isActiveCustomerNamed: aCustomerNameToSearch) or: [ 
		self isSuspendedCustomerNamed: aCustomerNameToSearch ]! !

!CustomerBook methodsFor: 'customer information' stamp: 'AM 9/21/2020 19:06:50'!
isEmpty
	
	^self noActiveCustomers and: [ 
		self noSuspendedCustomers ]! !

!CustomerBook methodsFor: 'customer information' stamp: 'NR 4/3/2019 10:14:26'!
numberOfActiveCustomers
	
	^active size! !

!CustomerBook methodsFor: 'customer information' stamp: 'NNH 9/18/2020 22:11:18'!
numberOfCustomers
	
	^self numberOfActiveCustomers + self numberOfSuspendedCustomers ! !

!CustomerBook methodsFor: 'customer information' stamp: 'NR 9/19/2018 17:36:09'!
numberOfSuspendedCustomers
	
	^suspended size! !


!CustomerBook methodsFor: 'customer management' stamp: 'NNH 9/21/2020 19:55:13'!
addCustomerNamed: aCustomerNameToAdd

	self signalIfCustomerNameIsEmpty: aCustomerNameToAdd.
	self signalIfCustomerNameAlreadyExists: aCustomerNameToAdd. 
	
	active add: aCustomerNameToAdd ! !

!CustomerBook methodsFor: 'customer management' stamp: 'NNH 9/21/2020 19:49:08'!
removeCustomerNamed: aCustomerNameToRemove 
 	
	self removeFromList: active aCustomerNamed: aCustomerNameToRemove ifPresent: [ ^aCustomerNameToRemove ].
	self removeFromList: suspended aCustomerNamed: aCustomerNameToRemove ifPresent: [ ^aCustomerNameToRemove ].
	
	^ NotFound signal.
! !

!CustomerBook methodsFor: 'customer management' stamp: 'AM 9/22/2020 10:43:28'!
suspendCustomerNamed: aCustomerNameToSuspend 
	
	(active includes: aCustomerNameToSuspend) ifFalse: [^CantSuspend signal].
	
	active remove: aCustomerNameToSuspend.
	suspended add: aCustomerNameToSuspend
! !


!CustomerBook methodsFor: 'signal control' stamp: 'NNH 9/20/2020 10:50:33'!
sendSignal: aSignalToSend ifCondition: aConditionToSendSignal

	aConditionToSendSignal ifTrue: [ self perform: aSignalToSend ].
	
! !

!CustomerBook methodsFor: 'signal control' stamp: 'HernanWilkinson 7/6/2011 17:52'!
signalCustomerAlreadyExists 

	self error: self class customerAlreadyExistsErrorMessage! !

!CustomerBook methodsFor: 'signal control' stamp: 'HernanWilkinson 7/6/2011 17:51'!
signalCustomerNameCannotBeEmpty 

	self error: self class customerCanNotBeEmptyErrorMessage ! !


!CustomerBook methodsFor: 'customer information - private' stamp: 'AM 9/21/2020 19:03:18'!
isActiveCustomerNamed: aCustomerNameToSearch

	^ active includes: aCustomerNameToSearch! !

!CustomerBook methodsFor: 'customer information - private' stamp: 'AM 9/21/2020 19:05:08'!
isSuspendedCustomerNamed: aCustomerNameToSearch

	^ suspended includes: aCustomerNameToSearch! !

!CustomerBook methodsFor: 'customer information - private' stamp: 'AM 9/21/2020 19:06:11'!
noActiveCustomers

	^ active isEmpty! !

!CustomerBook methodsFor: 'customer information - private' stamp: 'AM 9/21/2020 19:06:38'!
noSuspendedCustomers

	^ suspended isEmpty! !

!CustomerBook methodsFor: 'customer information - private' stamp: 'NNH 9/21/2020 19:54:54'!
signalIfCustomerNameAlreadyExists: aCustomerNameToAdd

	^ self sendSignal: #signalCustomerAlreadyExists ifCondition: (self includesCustomerNamed: aCustomerNameToAdd)! !

!CustomerBook methodsFor: 'customer information - private' stamp: 'NNH 9/21/2020 19:55:13'!
signalIfCustomerNameIsEmpty: aCustomerNameToAdd

	^ self sendSignal: #signalCustomerNameCannotBeEmpty ifCondition: (aCustomerNameToAdd isEmpty)! !


!CustomerBook methodsFor: 'customer management - private' stamp: 'NNH 9/21/2020 20:09:02'!
removeFromList: aCustomerList aCustomerNamed: aCustomerNameToRemove ifPresent: aBlockClosure
 	
	(aCustomerList remove: aCustomerNameToRemove ifAbsent: [nil]) ifNotNil: aBlockClosure.
		
	
! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'CustomerBook class' category: #'CodigoRepetido-Ejercicio'!
CustomerBook class
	instanceVariableNames: ''!

!CustomerBook class methodsFor: 'error messages' stamp: 'NR 9/17/2020 06:01:49'!
customerAlreadyExistsErrorMessage

	^'customer already exists!!'! !

!CustomerBook class methodsFor: 'error messages' stamp: 'NR 9/17/2020 06:02:05'!
customerCanNotBeEmptyErrorMessage

	^'customer name cannot be empty!!'! !
