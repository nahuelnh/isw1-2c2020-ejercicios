!classDefinition: #TerniLapilliTest category: 'Terni Lapilli'!
TestCase subclass: #TerniLapilliTest
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Terni Lapilli'!

!TerniLapilliTest methodsFor: 'testing no repetition' stamp: 'AM 10/29/2020 21:26:11'!
test04PlayersShouldNotPlayOnOccupiedCell
	
	| boardTerniLapilli |
	
	boardTerniLapilli := TerniLapilli new.
	boardTerniLapilli placeXAt: 1@1.
	self should: [ boardTerniLapilli placeOAt: 1@1 ]
		raise: Error
		withMessageText: boardTerniLapilli class canNotPlaceChipInOccupiedCellErrorDescription.! !


!TerniLapilliTest methodsFor: 'testing cells in bounds' stamp: 'AM 10/31/2020 00:16:54'!
test05ShouldNotPlaceAChipToTheRightOfTheBoard
	
	| boardTerniLapilli |
	
	boardTerniLapilli := TerniLapilli new.
	self should: [boardTerniLapilli placeXAt: 4@2 ]
		raise: Error
		withMessageText: boardTerniLapilli class cellIsOutOfBoundsErrorDescription.! !

!TerniLapilliTest methodsFor: 'testing cells in bounds' stamp: 'AM 10/31/2020 00:17:29'!
test07ShouldNotPlaceAChipToTheLeftOfTheBoard
	
	| boardTerniLapilli |
	
	boardTerniLapilli := TerniLapilli new.
	self should: [boardTerniLapilli placeXAt: 0@2 ]
		raise: Error
		withMessageText: boardTerniLapilli class cellIsOutOfBoundsErrorDescription.! !

!TerniLapilliTest methodsFor: 'testing cells in bounds' stamp: 'AM 10/31/2020 00:17:51'!
test09ShouldNotPlaceAChipBelowTheBoard
	
	| boardTerniLapilli |
	
	boardTerniLapilli := TerniLapilli new.
	self should: [boardTerniLapilli placeXAt: 2@0 ]
		raise: Error
		withMessageText: boardTerniLapilli class cellIsOutOfBoundsErrorDescription.! !

!TerniLapilliTest methodsFor: 'testing cells in bounds' stamp: 'AM 10/31/2020 00:18:04'!
test11ShouldNotPlaceAChipAboveTheBoard
	
	| boardTerniLapilli |
	
	boardTerniLapilli := TerniLapilli new.
	self should: [boardTerniLapilli placeXAt: 2@4 ]
		raise: Error
		withMessageText: boardTerniLapilli class cellIsOutOfBoundsErrorDescription.! !


!TerniLapilliTest methodsFor: 'testing turn alternation' stamp: 'AM 10/29/2020 18:39:46'!
test01FirstPlayerIsX
	
	| boardTerniLapilli |
	
	boardTerniLapilli := TerniLapilli new.
	self assert: boardTerniLapilli isXPlayingNext.
	self deny: boardTerniLapilli isOPlayingNext.! !

!TerniLapilliTest methodsFor: 'testing turn alternation' stamp: 'AM 10/29/2020 20:37:35'!
test02SecondPlayerIsO
	
	| boardTerniLapilli |
	
	boardTerniLapilli := TerniLapilli new.
	boardTerniLapilli placeXAt: 1@1.
	self deny: boardTerniLapilli isXPlayingNext.
	self assert: boardTerniLapilli isOPlayingNext.! !

!TerniLapilliTest methodsFor: 'testing turn alternation' stamp: 'AM 10/29/2020 20:37:41'!
test03ThirdPlayerIsX
	
	| boardTerniLapilli |
	
	boardTerniLapilli := TerniLapilli new.
	boardTerniLapilli placeXAt: 1@1.
	boardTerniLapilli placeOAt: 2@1.
	self assert: boardTerniLapilli isXPlayingNext.
	self deny: boardTerniLapilli isOPlayingNext.! !

!TerniLapilliTest methodsFor: 'testing turn alternation' stamp: 'AM 10/31/2020 00:20:06'!
test24AfterAMovingOperationOfXIsOTurn
	
	| boardTerniLapilli |
	
	boardTerniLapilli := TerniLapilli new.
	boardTerniLapilli placeXAt: 1@1.
	boardTerniLapilli placeOAt: 2@1.
	boardTerniLapilli placeXAt: 3@1.
	boardTerniLapilli placeOAt: 1@2.
	boardTerniLapilli placeXAt: 2@2.
	boardTerniLapilli placeOAt: 3@2.
	boardTerniLapilli moveAnXFrom: 2@2 to: 2@3.
	self deny: boardTerniLapilli isXPlayingNext.
	self assert: boardTerniLapilli isOPlayingNext.! !

!TerniLapilliTest methodsFor: 'testing turn alternation' stamp: 'AM 10/31/2020 00:21:42'!
test25MovingOperationDoesNotAllowPlayingOnOthersTurn
	
	| boardTerniLapilli |
	
	boardTerniLapilli := TerniLapilli new.
	boardTerniLapilli placeXAt: 1@1.
	boardTerniLapilli placeOAt: 2@1.
	boardTerniLapilli placeXAt: 3@1.
	boardTerniLapilli placeOAt: 1@2.
	boardTerniLapilli placeXAt: 2@2.
	boardTerniLapilli placeOAt: 3@2.
	self should: [boardTerniLapilli moveAnOFrom: 3@2 to: 2@3]
		raise: Error
		withMessageText: boardTerniLapilli class canNotPlayOnOtherPlayersTurnErrorDescription .! !


!TerniLapilliTest methodsFor: 'testing finish' stamp: 'AM 10/31/2020 00:21:58'!
test17InitialGameIsNotOver
	
	| boardTerniLapilli |
	
	boardTerniLapilli := TerniLapilli new.
	self deny: boardTerniLapilli isOver.! !

!TerniLapilliTest methodsFor: 'testing finish' stamp: 'AM 10/31/2020 00:22:24'!
test18FirstRowForXIsWinningGame
	
	| boardTerniLapilli |
	
	boardTerniLapilli := TerniLapilli new.
	boardTerniLapilli placeXAt: 1@1.
	boardTerniLapilli placeOAt: 1@2.
	boardTerniLapilli placeXAt: 2@1.
	boardTerniLapilli placeOAt: 1@3.
	boardTerniLapilli placeXAt: 3@1.
	self assert: boardTerniLapilli isOver.! !

!TerniLapilliTest methodsFor: 'testing finish' stamp: 'AM 10/31/2020 00:22:59'!
test19FirstColumnForOISWinningGame
	
	| boardTerniLapilli |
	
	boardTerniLapilli := TerniLapilli new.
	boardTerniLapilli placeXAt: 2@3.
	boardTerniLapilli placeOAt: 1@2.
	boardTerniLapilli placeXAt: 2@2.
	boardTerniLapilli placeOAt: 1@3.
	boardTerniLapilli placeXAt: 3@2.
	boardTerniLapilli placeOAt: 1@1.
	self assert: boardTerniLapilli isOver.! !

!TerniLapilliTest methodsFor: 'testing finish' stamp: 'AM 10/30/2020 20:41:04'!
test21
	
	| boardTerniLapilli |
	
	boardTerniLapilli := TerniLapilli new.
	boardTerniLapilli placeXAt: 1@1.
	boardTerniLapilli placeOAt: 1@2.
	boardTerniLapilli placeXAt: 2@1.
	boardTerniLapilli placeOAt: 1@3.
	boardTerniLapilli placeXAt: 3@1.
	self should: [boardTerniLapilli placeOAt: 2@2]
		raise: Error
		withMessageText: boardTerniLapilli class canNotPlayWhenGameIsAlreadyOverErrorDescription.! !

!TerniLapilliTest methodsFor: 'testing finish' stamp: 'AM 10/30/2020 20:53:01'!
test22
	
	| boardTerniLapilli |
	
	boardTerniLapilli := TerniLapilli new.
	boardTerniLapilli placeXAt: 1@1.
	boardTerniLapilli placeOAt: 1@2.
	boardTerniLapilli placeXAt: 1@3.
	boardTerniLapilli placeOAt: 2@2.
	boardTerniLapilli placeXAt: 2@3.
	boardTerniLapilli placeOAt: 3@1.
	boardTerniLapilli moveAnXFrom: 2@3 to: 3@3.
	boardTerniLapilli moveAnOFrom: 3@1 to: 3@2.
	self assert: boardTerniLapilli isOver.
		! !

!TerniLapilliTest methodsFor: 'testing finish' stamp: 'AM 10/30/2020 23:39:33'!
test23
	
	| boardTerniLapilli |
	
	boardTerniLapilli := TerniLapilli new.
	boardTerniLapilli placeXAt: 2@3.
	boardTerniLapilli placeOAt: 1@2.
	boardTerniLapilli placeXAt: 2@1.
	boardTerniLapilli placeOAt: 1@3.
	boardTerniLapilli placeXAt: 3@2.
	boardTerniLapilli placeOAt: 1@1.
	self should: [boardTerniLapilli moveAnXFrom: 3@2 to: 2@2]
		raise: Error
		withMessageText: boardTerniLapilli class canNotPlayWhenGameIsAlreadyOverErrorDescription.! !


!TerniLapilliTest methodsFor: 'testing moving' stamp: 'AM 10/29/2020 19:33:39'!
test15
	
	| boardTerniLapilli |
	
	boardTerniLapilli := TerniLapilli new.
	self should: [ boardTerniLapilli moveAnXFrom: 2@2 to: 1@2.]
		raise: Error
		withMessageText: boardTerniLapilli class canNotMoveAChipBeforePlacingTheThreeChipsErrorDescription.! !

!TerniLapilliTest methodsFor: 'testing moving' stamp: 'AM 10/30/2020 20:24:24'!
test16
	
	| boardTerniLapilli |
	
	boardTerniLapilli := TerniLapilli new.
	self should: [ boardTerniLapilli moveAnOFrom: 2@2 to: 1@2.]
		raise: Error
		withMessageText: boardTerniLapilli class canNotMoveAChipBeforePlacingTheThreeChipsErrorDescription.! !

!TerniLapilliTest methodsFor: 'testing moving' stamp: 'AM 10/30/2020 20:31:48'!
test20	
	| boardTerniLapilli |
	
	boardTerniLapilli := TerniLapilli new.
	boardTerniLapilli placeXAt: 1@1.
	boardTerniLapilli placeOAt: 2@1.
	boardTerniLapilli placeXAt: 3@1.
	boardTerniLapilli placeOAt: 1@2.
	boardTerniLapilli placeXAt: 2@2.
	boardTerniLapilli placeOAt: 3@2.
	self should: [ boardTerniLapilli moveAnXFrom: 2@2 to: 1@2.]
		raise: Error
		withMessageText: boardTerniLapilli class canNotPlaceChipInOccupiedCellErrorDescription .! !

!TerniLapilliTest methodsFor: 'testing moving' stamp: 'AM 10/31/2020 10:43:44'!
test26
	| boardTerniLapilli |
	
	boardTerniLapilli := TerniLapilli new.
	boardTerniLapilli placeXAt: 1@1.
	boardTerniLapilli placeOAt: 2@1.
	boardTerniLapilli placeXAt: 3@1.
	boardTerniLapilli placeOAt: 1@2.
	boardTerniLapilli placeXAt: 2@2.
	boardTerniLapilli placeOAt: 3@2.
	self should: [ boardTerniLapilli moveAnXFrom: 3@3 to: 2@3.]
		raise: Error
		withMessageText: boardTerniLapilli class canNotMoveFromACellThatHasNoCorrespondingChipErrorDescription .! !

!TerniLapilliTest methodsFor: 'testing moving' stamp: 'AM 10/31/2020 09:30:08'!
test27
	| boardTerniLapilli |
	
	boardTerniLapilli := TerniLapilli new.
	boardTerniLapilli placeXAt: 1@1.
	boardTerniLapilli placeOAt: 2@1.
	boardTerniLapilli placeXAt: 3@1.
	boardTerniLapilli placeOAt: 1@2.
	boardTerniLapilli placeXAt: 2@2.
	boardTerniLapilli placeOAt: 3@2.
	self should: [ boardTerniLapilli moveAnXFrom: 3@1 to: 3@3.]
		raise: Error
		withMessageText: boardTerniLapilli class canNotMoveChipToNonAdjacentCellErrorDescription.! !

!TerniLapilliTest methodsFor: 'testing moving' stamp: 'AM 10/31/2020 09:57:12'!
test28
	| boardTerniLapilli |
	
	boardTerniLapilli := TerniLapilli new.
	boardTerniLapilli placeXAt: 2@1.
	boardTerniLapilli placeOAt: 3@1.
	boardTerniLapilli placeXAt: 1@2.
	boardTerniLapilli placeOAt: 2@2.
	boardTerniLapilli placeXAt: 3@2.
	boardTerniLapilli placeOAt: 1@1.
	self should: [ boardTerniLapilli moveAnXFrom: 3@2 to: 2@3.]
		raise: Error
		withMessageText: boardTerniLapilli class canNotMoveChipToNonAdjacentCellErrorDescription.! !

!TerniLapilliTest methodsFor: 'testing moving' stamp: 'AM 10/31/2020 09:57:06'!
test29
	| boardTerniLapilli |
	
	boardTerniLapilli := TerniLapilli new.
	boardTerniLapilli placeXAt: 3@1.
	boardTerniLapilli placeOAt: 2@1.
	boardTerniLapilli placeXAt: 3@2.
	boardTerniLapilli placeOAt: 1@2.
	boardTerniLapilli placeXAt: 2@2.
	boardTerniLapilli placeOAt: 1@1.
	boardTerniLapilli moveAnXFrom: 2@2 to: 3@3.
	self assert: boardTerniLapilli isOver.! !

!TerniLapilliTest methodsFor: 'testing moving' stamp: 'AM 10/31/2020 10:31:34'!
test30
	| boardTerniLapilli |
	
	boardTerniLapilli := TerniLapilli new.
	boardTerniLapilli placeXAt: 2@1.
	boardTerniLapilli placeOAt: 3@1.
	boardTerniLapilli placeXAt: 1@2.
	boardTerniLapilli placeOAt: 2@2.
	boardTerniLapilli placeXAt: 3@2.
	boardTerniLapilli placeOAt: 1@1.
	self should: [ boardTerniLapilli placeXAt: 2@3.]
		raise: Error
		withMessageText: boardTerniLapilli class canNotPlaceAChipAfterPlacingThreeChipsErrorDescription.! !


!TerniLapilliTest methodsFor: 'testing turns' stamp: 'AM 10/29/2020 19:19:55'!
test13
	
	| boardTerniLapilli |
	
	boardTerniLapilli := TerniLapilli new.
	self should: [boardTerniLapilli placeOAt: 2@2.]
		raise: Error
		withMessageText: boardTerniLapilli class canNotPlayOnOtherPlayersTurnErrorDescription.! !


!classDefinition: #TerniLapilli category: 'Terni Lapilli'!
Object subclass: #TerniLapilli
	instanceVariableNames: 'nextPlayer cells state'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Terni Lapilli'!

!TerniLapilli methodsFor: 'assertions' stamp: 'AM 10/31/2020 10:19:47'!
canBePlacedAt: aCell by: playerWantingToPlay
	(self isWithinBoardLimits: aCell) ifFalse: [ self error: self class cellIsOutOfBoundsErrorDescription ].
	nextPlayer = playerWantingToPlay ifFalse: [ self error: self class canNotPlayOnOtherPlayersTurnErrorDescription ].
	(((cells at: #X) includes: aCell)
		or: [(cells at: #O) includes: aCell]) 
		ifTrue: [ self error: self class canNotPlaceChipInOccupiedCellErrorDescription ].! !


!TerniLapilli methodsFor: 'state update' stamp: 'AM 10/30/2020 23:52:13'!
updateState
	state := TerniLapilliState for: self with: cells playing: nextPlayer! !


!TerniLapilli methodsFor: 'testing' stamp: 'AM 10/31/2020 10:11:24'!
aPlayerHasThreeAlignedChips
"X tiene 3 => O tiene 3 MIRAR ACA ANTES DE ENTREGAR"
	^((self hasPlayedThreeChips: #X) and: [self hasThreeAlignedChips: #X]) or: [
		(self hasPlayedThreeChips: #O) and: [self hasThreeAlignedChips: #O]]! !

!TerniLapilli methodsFor: 'testing' stamp: 'AM 10/30/2020 20:16:46'!
hasAlreadyWon: aPlayer
	
	^ (((self hasPlayedThreeChips: aPlayer) and:
		[ self hasThreeAlignedChips: aPlayer ]))! !

!TerniLapilli methodsFor: 'testing' stamp: 'AM 10/31/2020 10:36:13'!
hasPlayedThreeChips: aPlayer

	^ (cells at: aPlayer) size = 3! !

!TerniLapilli methodsFor: 'testing' stamp: 'AM 10/31/2020 10:15:41'!
hasThreeAlignedChips: aPlayer
	^ ((cells at: aPlayer) allSatisfy: [:aCell | 3 * aCell ~= (cells at: aPlayer) sum ]) not! !

!TerniLapilli methodsFor: 'testing' stamp: 'AM 10/31/2020 10:18:00'!
isOPlayingNext
	^nextPlayer = #O! !

!TerniLapilli methodsFor: 'testing' stamp: 'AM 10/30/2020 21:12:37'!
isOver
	
	^ state isOver! !

!TerniLapilli methodsFor: 'testing' stamp: 'AM 10/31/2020 10:18:40'!
isWithinBoardLimits: aCell
	^((aCell x) between: 1 and: 3) and: [(aCell y) between: 1 and: 3]! !

!TerniLapilli methodsFor: 'testing' stamp: 'AM 10/31/2020 10:32:15'!
isXPlayingNext
	^nextPlayer = #X! !


!TerniLapilli methodsFor: 'board plays' stamp: 'AM 10/31/2020 10:20:07'!
moveAnOFrom: anOccupiedCell to: anAdjacentFreeCell
	state moveFrom: anOccupiedCell to: anAdjacentFreeCell actualPlayer: #O nextPlayer: #X.
	self updateState! !

!TerniLapilli methodsFor: 'board plays' stamp: 'AM 10/31/2020 10:20:22'!
moveAnXFrom: anOccupiedCell to: anAdjacentFreeCell
	state moveFrom: anOccupiedCell to: anAdjacentFreeCell actualPlayer: #X nextPlayer: #O.
	self updateState ! !

!TerniLapilli methodsFor: 'board plays' stamp: 'AM 10/31/2020 10:43:44'!
moveFrom: anOccupiedCell to: anAdjacentFreeCell actualPlayer: actualPlayer nextPlayer: followingPlayer
	self canBePlacedAt: anAdjacentFreeCell by: actualPlayer.
	((anOccupiedCell eightNeighbors includes: anAdjacentFreeCell )
	and: [  (anOccupiedCell x + anOccupiedCell y) even or: [(anAdjacentFreeCell x + anAdjacentFreeCell y) even] ]) ifFalse: [self error: self class canNotMoveChipToNonAdjacentCellErrorDescription ].
	(cells at: actualPlayer ) remove: anOccupiedCell ifAbsent: [self error: self class canNotMoveFromACellThatHasNoCorrespondingChipErrorDescription ].
	(cells at: actualPlayer) add: anAdjacentFreeCell .
	nextPlayer := followingPlayer .
! !

!TerniLapilli methodsFor: 'board plays' stamp: 'AM 10/31/2020 00:19:19'!
placeAt: aCell nextPlayer: nextMovingPlayer actualPlayer: actualPlayer
	self canBePlacedAt: aCell by: actualPlayer.
	(cells at: actualPlayer) add: aCell.
	nextPlayer := nextMovingPlayer! !

!TerniLapilli methodsFor: 'board plays' stamp: 'AM 10/30/2020 23:30:43'!
placeOAt: aCell 
	state placeAt: aCell nextPlayer: #X actualPlayer: #O.
	self updateState! !

!TerniLapilli methodsFor: 'board plays' stamp: 'AM 10/30/2020 23:30:39'!
placeXAt: aCell 
	state placeAt: aCell nextPlayer: #O actualPlayer: #X.
	self updateState
! !


!TerniLapilli methodsFor: 'initializing' stamp: 'AM 10/30/2020 21:14:49'!
initialize
	cells := Dictionary new.
	cells at: #X put: OrderedCollection new.
	cells at: #O put: OrderedCollection new.
	nextPlayer := #X.
	state := TerniLapilliStatePlacing for: self with: cells playing: nextPlayer.! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'TerniLapilli class' category: 'Terni Lapilli'!
TerniLapilli class
	instanceVariableNames: ''!

!TerniLapilli class methodsFor: 'error descriptions' stamp: 'AM 10/29/2020 19:34:22'!
canNotMoveAChipBeforePlacingTheThreeChipsErrorDescription
	^ 'Can not move a chip before placing the three chips on the board'.! !

!TerniLapilli class methodsFor: 'error descriptions' stamp: 'AM 10/31/2020 09:30:39'!
canNotMoveChipToNonAdjacentCellErrorDescription
	^'Can not move a chip to a non adjacent cell.'! !

!TerniLapilli class methodsFor: 'error descriptions' stamp: 'AM 10/31/2020 10:43:44'!
canNotMoveFromACellThatHasNoCorrespondingChipErrorDescription
	^'Can not move from a cell that does not belong to you'.! !

!TerniLapilli class methodsFor: 'error descriptions' stamp: 'AM 10/31/2020 10:31:34'!
canNotPlaceAChipAfterPlacingThreeChipsErrorDescription
	^'Can no place a chip after sixth turn.'! !

!TerniLapilli class methodsFor: 'error descriptions' stamp: 'AM 10/29/2020 18:44:59'!
canNotPlaceChipInOccupiedCellErrorDescription
	^ 'Chip can not be placed in an occupied cell.'! !

!TerniLapilli class methodsFor: 'error descriptions' stamp: 'AM 10/29/2020 19:18:09'!
canNotPlayOnOtherPlayersTurnErrorDescription
	^'Can not play when it is not your turn.'! !

!TerniLapilli class methodsFor: 'error descriptions' stamp: 'AM 10/30/2020 20:37:43'!
canNotPlayWhenGameIsAlreadyOverErrorDescription
	^'Can not play when game is already over.'! !

!TerniLapilli class methodsFor: 'error descriptions' stamp: 'AM 10/29/2020 19:00:08'!
cellIsOutOfBoundsErrorDescription
	^'Cell is out of the board'! !


!classDefinition: #TerniLapilliState category: 'Terni Lapilli'!
Object subclass: #TerniLapilliState
	instanceVariableNames: 'terniLapilli board nextPlayer'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Terni Lapilli'!

!TerniLapilliState methodsFor: 'initializing' stamp: 'AM 10/30/2020 21:19:25'!
initializeFor: aTerniLapilli with: aBoard playing: aPlayer
	terniLapilli := aTerniLapilli.
	board := aBoard.
	nextPlayer := aPlayer.! !


"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'TerniLapilliState class' category: 'Terni Lapilli'!
TerniLapilliState class
	instanceVariableNames: ''!

!TerniLapilliState class methodsFor: 'instance creation' stamp: 'AM 10/30/2020 23:00:15'!
for: aTerniLapilli with: aBoard playing: aPlayer 
	(aTerniLapilli aPlayerHasThreeAlignedChips) ifTrue: [ ^TerniLapilliStateGameOver new initializeFor: aTerniLapilli with: aBoard playing: aPlayer ].
	(aBoard at: #O) size = 3 ifTrue: [^ TerniLapilliStateMoving new initializeFor: aTerniLapilli with: aBoard playing: aPlayer ].
	^TerniLapilliStatePlacing new initializeFor: aTerniLapilli with: aBoard playing: aPlayer ! !


!classDefinition: #TerniLapilliStateGameOver category: 'Terni Lapilli'!
TerniLapilliState subclass: #TerniLapilliStateGameOver
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Terni Lapilli'!

!TerniLapilliStateGameOver methodsFor: 'as yet unclassified' stamp: 'AM 10/30/2020 21:12:55'!
isOver
	^true! !

!TerniLapilliStateGameOver methodsFor: 'as yet unclassified' stamp: 'AM 10/30/2020 23:44:43'!
moveFrom: anOccupiedCell to: anAdjacentFreeCell actualPlayer: actualPlayer nextPlayer: followingPlayer
	terniLapilli error: terniLapilli class canNotPlayWhenGameIsAlreadyOverErrorDescription 
! !

!TerniLapilliStateGameOver methodsFor: 'as yet unclassified' stamp: 'AM 10/30/2020 23:34:53'!
placeAt: aCell nextPlayer: nextMovingPlayer actualPlayer: actualPlayer
	terniLapilli error: terniLapilli class canNotPlayWhenGameIsAlreadyOverErrorDescription ! !


!classDefinition: #TerniLapilliStateMoving category: 'Terni Lapilli'!
TerniLapilliState subclass: #TerniLapilliStateMoving
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Terni Lapilli'!

!TerniLapilliStateMoving methodsFor: 'as yet unclassified' stamp: 'AM 10/30/2020 21:13:03'!
isOver
	^false! !

!TerniLapilliStateMoving methodsFor: 'as yet unclassified' stamp: 'AM 10/30/2020 23:25:54'!
moveFrom: anOccupiedCell to: anAdjacentFreeCell actualPlayer: actualPlayer nextPlayer: followingPlayer
	terniLapilli moveFrom: anOccupiedCell to: anAdjacentFreeCell actualPlayer: actualPlayer nextPlayer: followingPlayer
! !

!TerniLapilliStateMoving methodsFor: 'as yet unclassified' stamp: 'AM 10/31/2020 10:31:34'!
placeAt: aCell nextPlayer: nextMovingPlayer actualPlayer: actualPlayer
	terniLapilli error: terniLapilli class canNotPlaceAChipAfterPlacingThreeChipsErrorDescription 
! !


!classDefinition: #TerniLapilliStatePlacing category: 'Terni Lapilli'!
TerniLapilliState subclass: #TerniLapilliStatePlacing
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Terni Lapilli'!

!TerniLapilliStatePlacing methodsFor: 'as yet unclassified' stamp: 'AM 10/30/2020 21:13:12'!
isOver
	^false! !

!TerniLapilliStatePlacing methodsFor: 'as yet unclassified' stamp: 'AM 10/30/2020 21:31:03'!
moveFrom: anOccupiedCell to: anAdjacentFreeCell actualPlayer: actualPlayer nextPlayer: followingPlayer
	terniLapilli error: terniLapilli class canNotMoveAChipBeforePlacingTheThreeChipsErrorDescription 
! !

!TerniLapilliStatePlacing methodsFor: 'as yet unclassified' stamp: 'AM 10/30/2020 23:28:33'!
placeAt: aCell nextPlayer: nextMovingPlayer actualPlayer: actualPlayer
	terniLapilli placeAt: aCell nextPlayer: nextMovingPlayer actualPlayer: actualPlayer ! !
