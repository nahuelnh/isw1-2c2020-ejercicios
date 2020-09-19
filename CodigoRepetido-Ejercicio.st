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

!CustomerBookTest methodsFor: 'testing' stamp: 'NNH 9/18/2020 19:15:34'!
test01AddingCustomerShouldNotTakeMoreThan50Milliseconds

	| customerBook |
	
	customerBook := CustomerBook new.
	
	self sendingMessage: #addCustomerNamed: to: customerBook withCustomerName: 'John Lennon' takesLessThan: 50
	
! !

!CustomerBookTest methodsFor: 'testing' stamp: 'NNH 9/18/2020 21:16:00'!
test02RemovingCustomerShouldNotTakeMoreThan100Milliseconds

	| customerBook paulMcCartney |
	
	paulMcCartney := 'Paul McCartney'.
	customerBook := self newCustomerBookWithCustomerNamed: paulMcCartney.
	  
	self sendingMessage: #removeCustomerNamed: to: customerBook withCustomerName: paulMcCartney takesLessThan: 100 
	
! !

!CustomerBookTest methodsFor: 'testing' stamp: 'NNH 9/18/2020 20:33:17'!
test03CanNotAddACustomerWithEmptyName 

	| customerBook conditionsToCheck |

	customerBook := CustomerBook new.

	conditionsToCheck := [:anError | 
		self assert: anError messageText = CustomerBook customerCanNotBeEmptyErrorMessage.
		self assert: customerBook isEmpty.].
	
	self sendingMessage: #addCustomerNamed: to: customerBook withCustomerName: '' shouldSignal: Error andVerify: conditionsToCheck 
! !

!CustomerBookTest methodsFor: 'testing' stamp: 'NNH 9/18/2020 23:30:12'!
test04CanNotRemoveAnInvalidCustomer
	
	| customerBook johnLennon conditionsToCheck |
			
	johnLennon := 'John Lennon'.
	customerBook := self newCustomerBookWithCustomerNamed: johnLennon.
	conditionsToCheck := self checkCostumerBook: customerBook onlyHasCustomerNamed: johnLennon.
	
	self sendingMessage: #removeCustomerNamed: to: customerBook withCustomerName: 'Paul McCartney' shouldSignal: NotFound andVerify: conditionsToCheck
	
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

!CustomerBookTest methodsFor: 'testing' stamp: 'NNH 9/18/2020 23:31:46'!
test07CanNotSuspendAnInvalidCustomer
	
	| customerBook johnLennon conditionsToCheck |
			
	johnLennon := 'John Lennon'.
	customerBook := self newCustomerBookWithCustomerNamed: johnLennon.
	conditionsToCheck := self checkCostumerBook: customerBook onlyHasCustomerNamed: johnLennon.
	
	self sendingMessage: #suspendCustomerNamed: to: customerBook withCustomerName:  'George Harrison' shouldSignal: CantSuspend andVerify: conditionsToCheck! !

!CustomerBookTest methodsFor: 'testing' stamp: 'NNH 9/18/2020 23:32:00'!
test08CanNotSuspendAnAlreadySuspendedCustomer
	
	| customerBook johnLennon conditionsToCheck |
			
	johnLennon := 'John Lennon'.
	customerBook := self newCustomerBookWithSuspendedCustomer: johnLennon.
	conditionsToCheck := self checkCostumerBook: customerBook onlyHasCustomerNamed: johnLennon.
	
	self sendingMessage: #suspendCustomerNamed: to: customerBook withCustomerName: johnLennon shouldSignal: CantSuspend andVerify: conditionsToCheck! !


!CustomerBookTest methodsFor: 'utils-private' stamp: 'NNH 9/18/2020 21:24:28'!
checkCostumerBook: aCostumerBookToTest onlyHasCustomerNamed: aCustomerName
	
	^ [ :anError | 
		self assert: aCostumerBookToTest numberOfCustomers = 1.
		self assert: (aCostumerBookToTest includesCustomerNamed: aCustomerName) ].
		
! !

!CustomerBookTest methodsFor: 'utils-private' stamp: 'NNH 9/18/2020 20:00:07'!
customerBook: aCustomerBookToTestCustomers shouldHave: aNumberOfCustomers customersOfType: aMessageToObtainNumberOfCustomers

	self assert: aNumberOfCustomers equals: (aCustomerBookToTestCustomers perform: aMessageToObtainNumberOfCustomers).


	
! !

!CustomerBookTest methodsFor: 'utils-private' stamp: 'NNH 9/18/2020 20:18:29'!
customerBook: aCustomerBookToTestCustomers shouldHaveActive: numberOfActiveCustomers suspended: numberOfSuspendedCustomers andTotal: totalNumberOfCustomers

	|numberOfCustomersPerType typesOfCustomer |
	
	numberOfCustomersPerType := Array with: numberOfActiveCustomers with: numberOfSuspendedCustomers with: totalNumberOfCustomers.
	typesOfCustomer := Array with: #numberOfActiveCustomers with: #numberOfSuspendedCustomers with: #numberOfCustomers.
	
	1 to: 3 do: [ :anIndex | | aTypeOfCustomer numberOfCustomersOfType |
		numberOfCustomersOfType := (numberOfCustomersPerType at: anIndex).
		aTypeOfCustomer := (typesOfCustomer at: anIndex).
		self customerBook: aCustomerBookToTestCustomers shouldHave: numberOfCustomersOfType customersOfType: aTypeOfCustomer.
		].


	
! !

!CustomerBookTest methodsFor: 'utils-private' stamp: 'NNH 9/18/2020 20:30:31'!
newCustomerBookWithCustomerNamed: aCustomerName
	
	| customerBook |
	
	customerBook := CustomerBook new.
	customerBook addCustomerNamed: aCustomerName.
	^customerBook.
	! !

!CustomerBookTest methodsFor: 'utils-private' stamp: 'NNH 9/18/2020 22:01:35'!
newCustomerBookWithSuspendedAndRemovedCustomer: aCustomerName
	
	| customerBook |
	
	customerBook := self newCustomerBookWithCustomerNamed: aCustomerName.
	customerBook suspendCustomerNamed: aCustomerName.
	customerBook removeCustomerNamed: aCustomerName.
	^customerBook.
	! !

!CustomerBookTest methodsFor: 'utils-private' stamp: 'NNH 9/18/2020 20:30:20'!
newCustomerBookWithSuspendedCustomer: aCustomerName
	
	| customerBook |
	
	customerBook := self newCustomerBookWithCustomerNamed: aCustomerName.
	customerBook suspendCustomerNamed: aCustomerName.
	^customerBook.
	! !

!CustomerBookTest methodsFor: 'utils-private' stamp: 'NNH 9/18/2020 19:36:58'!
sendingMessage: aMessageToSend to: aReceivingCustomerBook withCustomerName: aCustomerAsCollaborator shouldSignal: aSignalError andVerify: conditionsToCheckOnSignal

	[ aReceivingCustomerBook perform: aMessageToSend withArguments: (Array with: aCustomerAsCollaborator).
	self fail ]
		on: aSignalError 
		do: conditionsToCheckOnSignal ! !

!CustomerBookTest methodsFor: 'utils-private' stamp: 'NNH 9/18/2020 19:13:49'!
sendingMessage: aMessageToSend to: aReceivingCustomerBook withCustomerName: customerAsCollaborator takesLessThan: maxNumberOfMilliseconds
	
	| millisecondsAfterRunning millisecondsBeforeRunning |
	
	millisecondsBeforeRunning := Time millisecondClockValue * millisecond.
	aReceivingCustomerBook perform: aMessageToSend withArguments:  (Array with: customerAsCollaborator ).
	millisecondsAfterRunning := Time millisecondClockValue * millisecond.
	
	self assert: (millisecondsAfterRunning - millisecondsBeforeRunning) < (maxNumberOfMilliseconds * millisecond)! !

!CustomerBookTest methodsFor: 'utils-private' stamp: 'NNH 9/18/2020 21:51:38'!
sendingMessage: aMessage toCostumerBook: aCostumerBook withOnlyCostumerName: aCostumerName forOtherCustomerName: otherCostumerName shouldSignal: aSignalError 
	
	| conditionToCheck |
			
	conditionToCheck := self checkCostumerBook: aCostumerBook onlyHasCustomerNamed: aCostumerName.
		
	self sendingMessage: aMessage to: aCostumerBook withCustomerName: otherCostumerName shouldSignal: aSignalError andVerify: conditionToCheck 
! !


!classDefinition: #CustomerBook category: #'CodigoRepetido-Ejercicio'!
Object subclass: #CustomerBook
	instanceVariableNames: 'suspended active'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'CodigoRepetido-Ejercicio'!

!CustomerBook methodsFor: 'testing' stamp: 'NR 4/3/2019 10:14:26'!
includesCustomerNamed: aName

	^(active includes: aName) or: [ suspended includes: aName ]! !

!CustomerBook methodsFor: 'testing' stamp: 'NR 4/3/2019 10:14:26'!
isEmpty
	
	^active isEmpty and: [ suspended isEmpty ]! !


!CustomerBook methodsFor: 'initialization' stamp: 'NR 9/17/2020 07:23:04'!
initialize

	active := OrderedCollection new.
	suspended:= OrderedCollection new.! !


!CustomerBook methodsFor: 'customer management' stamp: 'NNH 9/18/2020 23:18:25'!
addCustomerNamed: aName

	self sendSignal: #signalCustomerNameCannotBeEmpty ifCondition: (aName isEmpty).
	self sendSignal: #signalCustomerAlreadyExists ifCondition: (self includesCustomerNamed: aName). 
	
	active add: aName ! !

!CustomerBook methodsFor: 'customer management' stamp: 'NR 4/3/2019 10:14:26'!
numberOfActiveCustomers
	
	^active size! !

!CustomerBook methodsFor: 'customer management' stamp: 'NNH 9/18/2020 22:11:18'!
numberOfCustomers
	
	^self numberOfActiveCustomers + self numberOfSuspendedCustomers ! !

!CustomerBook methodsFor: 'customer management' stamp: 'NR 9/19/2018 17:36:09'!
numberOfSuspendedCustomers
	
	^suspended size! !

!CustomerBook methodsFor: 'customer management' stamp: 'NNH 9/18/2020 23:22:09'!
removeCustomerNamed: aName 
 
	| removedName | 
	
	(removedName := self removeAndRetrieveCustomerFromList: active ifNameEquals: aName) ifNotNil: [^removedName].
	(removedName := self removeAndRetrieveCustomerFromList: suspended ifNameEquals: aName) ifNotNil: [^removedName].
	
	^ NotFound signal.
! !

!CustomerBook methodsFor: 'customer management' stamp: 'HernanWilkinson 7/6/2011 17:52'!
signalCustomerAlreadyExists 

	self error: self class customerAlreadyExistsErrorMessage! !

!CustomerBook methodsFor: 'customer management' stamp: 'HernanWilkinson 7/6/2011 17:51'!
signalCustomerNameCannotBeEmpty 

	self error: self class customerCanNotBeEmptyErrorMessage ! !

!CustomerBook methodsFor: 'customer management' stamp: 'NR 4/3/2019 10:14:26'!
suspendCustomerNamed: aName 
	
	(active includes: aName) ifFalse: [^CantSuspend signal].
	
	active remove: aName.
	
	suspended add: aName
! !


!CustomerBook methodsFor: 'utils-private' stamp: 'NNH 9/18/2020 22:21:35'!
removeAndRetrieveCustomerFromList: aCustomerList ifNameEquals: aCustomerName 

	1 to: aCustomerList size do: [ :index |
		aCustomerName = (aCustomerList at: index)
			ifTrue: [
				aCustomerList removeAt: index.
				^ aCustomerName 
			] 
	].

	^ nil.
	! !

!CustomerBook methodsFor: 'utils-private' stamp: 'NNH 9/18/2020 23:16:51'!
sendSignal: aSignal ifCondition: aBooleanCondition

	aBooleanCondition ifTrue: [ self perform: aSignal ].
	
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
