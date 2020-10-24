!classDefinition: #MarsRoverTest category: 'MarsRover'!
TestCase subclass: #MarsRoverTest
	instanceVariableNames: 'north west south east marsRoverNorth marsRoverWest marsRoverSouth marsRoverEast'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'MarsRover'!

!MarsRoverTest methodsFor: 'setUp/tearDown' stamp: 'NNH 10/24/2020 12:07:44'!
setUp

	
	north := 'North'.
	west := 'West'.
	south := 'South'.
	east := 'East'.
	
	marsRoverNorth := MarsRover at: 0@0 heading: north. 
	marsRoverWest := MarsRover at: 0@0 heading: west. 
	marsRoverSouth := MarsRover at: 0@0 heading: south . 
	marsRoverEast := MarsRover at: 0@0 heading: east. ! !


!MarsRoverTest methodsFor: 'testing direction' stamp: 'NNH 10/24/2020 12:22:41'!
should: aMarsRover executing: aListOfCommands beHeading: aCardinalDirection

	aMarsRover execute: aListOfCommands .
	self assert: aCardinalDirection equals: aMarsRover direction.


! !

!MarsRoverTest methodsFor: 'testing direction' stamp: 'NNH 10/24/2020 12:13:18'!
test04TurningLeftFromNorthShouldHeadWest

	self should: marsRoverNorth executing: 'l' beHeading: west.


! !

!MarsRoverTest methodsFor: 'testing direction' stamp: 'NNH 10/24/2020 12:13:47'!
test05TurningLeftFromWestShouldHeadSouth

	self should: marsRoverWest executing: 'l' beHeading: south.


! !

!MarsRoverTest methodsFor: 'testing direction' stamp: 'NNH 10/24/2020 12:14:06'!
test06TurningLeftFromSouthShouldHeadEast

	self should: marsRoverSouth executing: 'l' beHeading: east.


! !

!MarsRoverTest methodsFor: 'testing direction' stamp: 'NNH 10/24/2020 12:14:17'!
test07TurningLeftFromEastShouldHeadNorth

	self should: marsRoverEast executing: 'l' beHeading: north.


! !

!MarsRoverTest methodsFor: 'testing direction' stamp: 'NNH 10/24/2020 12:14:41'!
test08TurningRightFromNorthShouldHeadEast

	self should: marsRoverNorth executing: 'r' beHeading: east.


! !

!MarsRoverTest methodsFor: 'testing direction' stamp: 'NNH 10/24/2020 12:15:27'!
test09TurningRightFromEastShouldHeadSouth

	self should: marsRoverEast executing: 'r' beHeading: south.


! !

!MarsRoverTest methodsFor: 'testing direction' stamp: 'NNH 10/24/2020 12:15:38'!
test10TurningRightFromSouthShouldHeadWest

	self should: marsRoverSouth executing: 'r' beHeading: west.

! !

!MarsRoverTest methodsFor: 'testing direction' stamp: 'NNH 10/24/2020 12:15:47'!
test11TurningRightFromWestShouldHeadNorth

	self should: marsRoverWest executing: 'r' beHeading: north.

! !


!MarsRoverTest methodsFor: 'testing invalid commands' stamp: 'NNH 10/24/2020 12:59:34'!
test19MarsRoverShouldNotMoveAfterInvalidCommand

	self should: marsRoverNorth executing: 'lxl' beHeading: west.
! !

!MarsRoverTest methodsFor: 'testing invalid commands' stamp: 'NNH 10/24/2020 13:02:49'!
test20MarsRoverShouldNotMoveExecutingAnotherListOfCommandsAfterInvalidCommand

	marsRoverNorth execute: 'x'.
	marsRoverNorth execute: 'l'.
	self assert: north equals: marsRoverNorth direction.! !

!MarsRoverTest methodsFor: 'testing invalid commands' stamp: 'NNH 10/24/2020 13:05:58'!
test21AfterInvalidCommandAllDirectionsDoNothing

	self should: marsRoverNorth executing: 'xflbr' beAt: 0@0. 
! !


!MarsRoverTest methodsFor: 'testing movement' stamp: 'NNH 10/24/2020 12:22:17'!
should: aMarsRover executing: aListOfCommands beAt: aPosition

	aMarsRover execute: aListOfCommands .
	self assert: aPosition equals: aMarsRover position.


! !

!MarsRoverTest methodsFor: 'testing movement' stamp: 'NNH 10/24/2020 12:12:32'!
test02MovingForwardNorthShouldIncreaseOneYCoordinate

	self should: marsRoverNorth executing: 'f' beAt: 0@1.

! !

!MarsRoverTest methodsFor: 'testing movement' stamp: 'NNH 10/24/2020 12:12:48'!
test03MovingBackwardsNorthShouldDecreaseOneYCoordinate

	self should: marsRoverNorth executing: 'b' beAt: 0@-1.

! !

!MarsRoverTest methodsFor: 'testing movement' stamp: 'NNH 10/24/2020 12:16:32'!
test12MovingForwardWestShouldDecreaseOneXCoordinate

	self should: marsRoverWest executing: 'f' beAt: -1@0.

! !

!MarsRoverTest methodsFor: 'testing movement' stamp: 'NNH 10/24/2020 12:16:41'!
test13MovingForwardSouthShouldDecreaseOneYCoordinate

	self should: marsRoverSouth executing: 'f' beAt: 0@-1.
! !

!MarsRoverTest methodsFor: 'testing movement' stamp: 'NNH 10/24/2020 12:16:52'!
test14MovingForwardEastShouldIncreaseOneXCoordinate

	self should: marsRoverEast executing: 'f' beAt: 1@0.

! !

!MarsRoverTest methodsFor: 'testing movement' stamp: 'NNH 10/24/2020 12:17:26'!
test15MovingBackwardsWestShouldIncreaseOneXCoordinate

	self should: marsRoverWest executing: 'b' beAt: 1@0.

! !

!MarsRoverTest methodsFor: 'testing movement' stamp: 'NNH 10/24/2020 12:17:35'!
test16MovingBackwardsSouthShouldIncreaseOneYCoordinate

	self should: marsRoverSouth executing: 'b' beAt: 0@1.
! !

!MarsRoverTest methodsFor: 'testing movement' stamp: 'NNH 10/24/2020 12:17:50'!
test17MovingBackwarsdsEastShouldDecreaseOneXCoordinate

	self should: marsRoverEast executing: 'b' beAt: -1@0.
! !


!MarsRoverTest methodsFor: 'testing multiple commands' stamp: 'NNH 10/24/2020 12:57:57'!
test18ExecutingMoreThanOneCommandShouldExecuteThem

	self should: marsRoverNorth executing: 'ff' beAt: 0@2. 
! !

!MarsRoverTest methodsFor: 'testing multiple commands' stamp: 'NNH 10/24/2020 19:39:12'!
test23MarsRoverShouldMoveInMoreThanOneDirection

	self should: marsRoverNorth executing: 'ffrffrff' beAt: 2@0. 
! !


!MarsRoverTest methodsFor: 'testing no commands' stamp: 'NNH 10/24/2020 12:12:06'!
test01EmptyListOfCommandsShouldNotMoveMarsRover

	self should: marsRoverNorth executing: '' beAt: 0@0.
	self should: marsRoverNorth executing: '' 	beHeading: north. ! !


!MarsRoverTest methodsFor: 'testing signals' stamp: 'NNH 10/24/2020 19:26:54'!
test22MarsRoverShouldNotHeadToNonCardinalDirection

	self should: [MarsRover at: 0@0 heading: 'Hello'] 
	raise: Error
	withMessageText: MarsRover canNotBeHeadingToNonCardinalDirectionErrorDescription.
! !


!classDefinition: #MarsRover category: 'MarsRover'!
Object subclass: #MarsRover
	instanceVariableNames: 'location cardinalDirection status outOfOrder'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'MarsRover'!

!MarsRover methodsFor: 'initializing' stamp: 'NNH 10/24/2020 12:35:37'!
initializeAt: aLocation heading: aCardinalDirection 

	status := MarsRoverStatus at: aLocation heading: aCardinalDirection.
	outOfOrder := false.! !


!MarsRover methodsFor: 'moving operations' stamp: 'NNH 10/24/2020 19:02:29'!
execute: aListOfCommands 

	aListOfCommands do: [ :aCommandAsCharacter | self executeSingleCommand: aCommandAsCharacter.].! !

!MarsRover methodsFor: 'moving operations' stamp: 'NNH 10/24/2020 19:03:08'!
executeSingleCommand: aCommandAsCharacter

	| command | 
	
	command := MarsRoverCommand with: aCommandAsCharacter for: self. 
	command execute! !

!MarsRover methodsFor: 'moving operations' stamp: 'NNH 10/24/2020 13:28:28'!
markOutOfOrder
	status := status markOutOfOrder.! !

!MarsRover methodsFor: 'moving operations' stamp: 'NNH 10/24/2020 13:27:38'!
moveBackwards
	status moveBackwards.! !

!MarsRover methodsFor: 'moving operations' stamp: 'NNH 10/24/2020 13:27:19'!
moveForward 
	status moveForward.! !

!MarsRover methodsFor: 'moving operations' stamp: 'NNH 10/24/2020 13:28:02'!
turnLeft
	status := status turnLeft.! !

!MarsRover methodsFor: 'moving operations' stamp: 'NNH 10/24/2020 13:28:10'!
turnRight
	status := status turnRight.! !


!MarsRover methodsFor: 'testing' stamp: 'NNH 10/24/2020 10:53:54'!
direction
	^status direction.! !

!MarsRover methodsFor: 'testing' stamp: 'NNH 10/24/2020 11:28:03'!
position
	^ status location.! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'MarsRover class' category: 'MarsRover'!
MarsRover class
	instanceVariableNames: ''!

!MarsRover class methodsFor: 'instance creation' stamp: 'NNH 10/24/2020 19:23:46'!
at: aLocation heading: aCardinalDirection
	self assertACardinalDirectionIsValid: aCardinalDirection.
	^self new initializeAt: aLocation heading: aCardinalDirection.! !


!MarsRover class methodsFor: 'error descriptions' stamp: 'NNH 10/24/2020 19:19:35'!
canNotBeHeadingToNonCardinalDirectionErrorDescription
	^'Mars Rover should be heading to a cardinal direction'.! !


!MarsRover class methodsFor: 'assertions' stamp: 'NNH 10/24/2020 19:26:08'!
assertACardinalDirectionIsValid: aCardinalDirection 
	
	({'North'. 'West'. 'East'. 'South'} includes: aCardinalDirection) ifFalse: [self error: self canNotBeHeadingToNonCardinalDirectionErrorDescription.].! !


!classDefinition: #MarsRoverCommand category: 'MarsRover'!
Object subclass: #MarsRoverCommand
	instanceVariableNames: 'marsRover'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'MarsRover'!

!MarsRoverCommand methodsFor: 'initializing' stamp: 'NNH 10/24/2020 13:21:46'!
initializeFor: aMarsRover

	marsRover := aMarsRover ! !


!MarsRoverCommand methodsFor: 'executing' stamp: 'NNH 10/24/2020 13:22:58'!
execute
	self subclassResponsibility.! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'MarsRoverCommand class' category: 'MarsRover'!
MarsRoverCommand class
	instanceVariableNames: ''!

!MarsRoverCommand class methodsFor: 'as yet unclassified' stamp: 'NNH 10/24/2020 13:21:01'!
for: aMarsRover

	^self new initializeFor: aMarsRover.! !

!MarsRoverCommand class methodsFor: 'as yet unclassified' stamp: 'NNH 10/24/2020 13:20:20'!
with: aCharacterIdentifyingCommand for: aMarsRover
	aCharacterIdentifyingCommand = $f ifTrue: [^MarsRoverCommandForward for: aMarsRover.].
	aCharacterIdentifyingCommand = $b ifTrue: [^MarsRoverCommandBackward for: aMarsRover.].
	aCharacterIdentifyingCommand = $l ifTrue: [^MarsRoverCommandLeft for: aMarsRover.].
	aCharacterIdentifyingCommand = $r ifTrue: [^MarsRoverCommandRight for: aMarsRover.].
	^ MarsRoverCommandInvalidCommand for: aMarsRover.! !


!classDefinition: #MarsRoverCommandBackward category: 'MarsRover'!
MarsRoverCommand subclass: #MarsRoverCommandBackward
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'MarsRover'!

!MarsRoverCommandBackward methodsFor: 'executing' stamp: 'NNH 10/24/2020 13:24:08'!
execute
	marsRover moveBackwards.! !


!classDefinition: #MarsRoverCommandForward category: 'MarsRover'!
MarsRoverCommand subclass: #MarsRoverCommandForward
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'MarsRover'!

!MarsRoverCommandForward methodsFor: 'executing' stamp: 'NNH 10/24/2020 13:24:01'!
execute
	marsRover moveForward.! !


!classDefinition: #MarsRoverCommandInvalidCommand category: 'MarsRover'!
MarsRoverCommand subclass: #MarsRoverCommandInvalidCommand
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'MarsRover'!

!MarsRoverCommandInvalidCommand methodsFor: 'executing' stamp: 'NNH 10/24/2020 13:24:21'!
execute
	marsRover markOutOfOrder.! !


!classDefinition: #MarsRoverCommandLeft category: 'MarsRover'!
MarsRoverCommand subclass: #MarsRoverCommandLeft
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'MarsRover'!

!MarsRoverCommandLeft methodsFor: 'executing' stamp: 'NNH 10/24/2020 13:24:34'!
execute
	marsRover turnLeft.! !


!classDefinition: #MarsRoverCommandRight category: 'MarsRover'!
MarsRoverCommand subclass: #MarsRoverCommandRight
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'MarsRover'!

!MarsRoverCommandRight methodsFor: 'executing' stamp: 'NNH 10/24/2020 13:24:46'!
execute
	marsRover turnRight.! !


!classDefinition: #MarsRoverStatus category: 'MarsRover'!
Object subclass: #MarsRoverStatus
	instanceVariableNames: 'location direction'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'MarsRover'!


!MarsRoverStatus methodsFor: 'testing' stamp: 'NNH 10/24/2020 19:37:12'!
location
	^location! !


!MarsRoverStatus methodsFor: 'status operations' stamp: 'NNH 10/24/2020 12:54:08'!
markOutOfOrder
	^ MarsRoverStatusOutOfOrder at: location heading: self direction.! !


!MarsRoverStatus methodsFor: 'moving operations' stamp: 'NNH 10/24/2020 11:38:58'!
moveBackwards
	self subclassResponsibility.! !

!MarsRoverStatus methodsFor: 'moving operations' stamp: 'NNH 10/24/2020 11:42:57'!
moveForward

	self subclassResponsibility.! !

!MarsRoverStatus methodsFor: 'moving operations' stamp: 'NNH 10/24/2020 10:42:45'!
turnLeft
	self subclassResponsibility.! !

!MarsRoverStatus methodsFor: 'moving operations' stamp: 'NNH 10/24/2020 11:43:07'!
turnRight
	self subclassResponsibility.! !


!MarsRoverStatus methodsFor: 'accessing' stamp: 'NNH 10/24/2020 19:08:16'!
direction
	^direction.! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'MarsRoverStatus class' category: 'MarsRover'!
MarsRoverStatus class
	instanceVariableNames: ''!

!MarsRoverStatus class methodsFor: 'instance creation' stamp: 'NNH 10/24/2020 11:24:34'!
at: aLocation 
	^self new initializeAt: aLocation.! !

!MarsRoverStatus class methodsFor: 'instance creation' stamp: 'NNH 10/24/2020 11:21:43'!
at: aLocation heading: aCardinalDirection 
	aCardinalDirection = 'North' ifTrue: [^MarsRoverStatusHeadingNorth at: aLocation.].
	aCardinalDirection = 'West' ifTrue: [^MarsRoverStatusHeadingWest at: aLocation.].
	aCardinalDirection = 'South' ifTrue: [^MarsRoverStatusHeadingSouth at: aLocation.].
	aCardinalDirection = 'East' ifTrue: [^MarsRoverStatusHeadingEast at: aLocation.].! !


!classDefinition: #MarsRoverStatusHeadingEast category: 'MarsRover'!
MarsRoverStatus subclass: #MarsRoverStatusHeadingEast
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'MarsRover'!

!MarsRoverStatusHeadingEast methodsFor: 'moving operations' stamp: 'NNH 10/24/2020 11:42:18'!
moveBackwards
	location := -1@0 + location.! !

!MarsRoverStatusHeadingEast methodsFor: 'moving operations' stamp: 'NNH 10/24/2020 11:35:30'!
moveForward
	location := 1@0 + location.! !

!MarsRoverStatusHeadingEast methodsFor: 'moving operations' stamp: 'NNH 10/24/2020 19:14:27'!
turnLeft
	^MarsRoverStatusHeadingNorth at: location.! !

!MarsRoverStatusHeadingEast methodsFor: 'moving operations' stamp: 'NNH 10/24/2020 19:14:37'!
turnRight
	^MarsRoverStatusHeadingSouth at: location.! !


!MarsRoverStatusHeadingEast methodsFor: 'initializing' stamp: 'NNH 10/24/2020 19:09:35'!
initializeAt: aLocation 
	location := aLocation.
	direction := 'East'.! !


!classDefinition: #MarsRoverStatusHeadingNorth category: 'MarsRover'!
MarsRoverStatus subclass: #MarsRoverStatusHeadingNorth
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'MarsRover'!

!MarsRoverStatusHeadingNorth methodsFor: 'moving operations' stamp: 'NNH 10/24/2020 11:40:08'!
moveBackwards
	location := 0@-1 + location.! !

!MarsRoverStatusHeadingNorth methodsFor: 'moving operations' stamp: 'NNH 10/24/2020 11:30:05'!
moveForward
	location := 0@1 + location.! !

!MarsRoverStatusHeadingNorth methodsFor: 'moving operations' stamp: 'NNH 10/24/2020 19:15:17'!
turnLeft
	^MarsRoverStatusHeadingWest at: location.! !

!MarsRoverStatusHeadingNorth methodsFor: 'moving operations' stamp: 'NNH 10/24/2020 19:15:21'!
turnRight
	^MarsRoverStatusHeadingEast at: location.! !


!MarsRoverStatusHeadingNorth methodsFor: 'initializing' stamp: 'NNH 10/24/2020 19:10:45'!
initializeAt: aLocation 
	location := aLocation.
	direction := 'North'.! !


!classDefinition: #MarsRoverStatusHeadingSouth category: 'MarsRover'!
MarsRoverStatus subclass: #MarsRoverStatusHeadingSouth
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'MarsRover'!

!MarsRoverStatusHeadingSouth methodsFor: 'moving operations' stamp: 'NNH 10/24/2020 11:41:44'!
moveBackwards
	location := 0@1 + location.! !

!MarsRoverStatusHeadingSouth methodsFor: 'moving operations' stamp: 'NNH 10/24/2020 11:34:34'!
moveForward
	^location := 0@-1 + location! !

!MarsRoverStatusHeadingSouth methodsFor: 'moving operations' stamp: 'NNH 10/24/2020 19:15:29'!
turnLeft
	^MarsRoverStatusHeadingEast at: location.! !

!MarsRoverStatusHeadingSouth methodsFor: 'moving operations' stamp: 'NNH 10/24/2020 19:15:35'!
turnRight
	^MarsRoverStatusHeadingWest at: location.! !


!MarsRoverStatusHeadingSouth methodsFor: 'initializing' stamp: 'NNH 10/24/2020 19:10:32'!
initializeAt: aLocation 
	location := aLocation.
	direction := 'South'.! !


!classDefinition: #MarsRoverStatusHeadingWest category: 'MarsRover'!
MarsRoverStatus subclass: #MarsRoverStatusHeadingWest
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'MarsRover'!

!MarsRoverStatusHeadingWest methodsFor: 'moving operations' stamp: 'NNH 10/24/2020 11:40:43'!
moveBackwards
	location := 1@0 + location.! !

!MarsRoverStatusHeadingWest methodsFor: 'moving operations' stamp: 'NNH 10/24/2020 11:18:22'!
moveForward
	location := -1@0 + location.! !

!MarsRoverStatusHeadingWest methodsFor: 'moving operations' stamp: 'NNH 10/24/2020 19:15:47'!
turnLeft
	^MarsRoverStatusHeadingSouth at: location.! !

!MarsRoverStatusHeadingWest methodsFor: 'moving operations' stamp: 'NNH 10/24/2020 19:15:40'!
turnRight
	^MarsRoverStatusHeadingNorth at: location.! !


!MarsRoverStatusHeadingWest methodsFor: 'initializing' stamp: 'NNH 10/24/2020 19:36:36'!
initializeAt: aLocation 
	location := aLocation.
	direction := 'West'.! !


!classDefinition: #MarsRoverStatusOutOfOrder category: 'MarsRover'!
MarsRoverStatus subclass: #MarsRoverStatusOutOfOrder
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'MarsRover'!

!MarsRoverStatusOutOfOrder methodsFor: 'initializing' stamp: 'NNH 10/24/2020 19:35:43'!
initializeAt: aPosition heading: aCardinalDirection
	location := aPosition.
	direction := aCardinalDirection.! !


!MarsRoverStatusOutOfOrder methodsFor: 'moving operations' stamp: 'NNH 10/24/2020 12:56:46'!
moveBackwards
	^self.! !

!MarsRoverStatusOutOfOrder methodsFor: 'moving operations' stamp: 'NNH 10/24/2020 12:57:03'!
moveForward
	^self.! !

!MarsRoverStatusOutOfOrder methodsFor: 'moving operations' stamp: 'NNH 10/24/2020 12:49:37'!
turnLeft
	^self.! !

!MarsRoverStatusOutOfOrder methodsFor: 'moving operations' stamp: 'NNH 10/24/2020 12:56:18'!
turnRight
	^self.! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'MarsRoverStatusOutOfOrder class' category: 'MarsRover'!
MarsRoverStatusOutOfOrder class
	instanceVariableNames: ''!

!MarsRoverStatusOutOfOrder class methodsFor: 'instance creation' stamp: 'NNH 10/24/2020 12:50:32'!
at: aPosition heading: aCardinalDirection

	^self new initializeAt: aPosition heading: aCardinalDirection.! !
