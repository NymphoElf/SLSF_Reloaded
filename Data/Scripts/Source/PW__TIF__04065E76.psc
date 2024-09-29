;BEGIN FRAGMENT CODE - Do not edit anything between this and the end comment
;NEXT FRAGMENT INDEX 2
Scriptname PW__TIF__04065E76 Extends TopicInfo Hidden

;BEGIN FRAGMENT Fragment_1
Function Fragment_1(ObjectReference akSpeakerRef)
Actor akSpeaker = akSpeakerRef as Actor
;BEGIN CODE
int choice = PW_SQ_BanditBeerFetchMolestation.show()

if choice == 0 ; Grab bottle
  (GetOwningQuest() as PW_SQ_BanditsScript).DecreaseBanditFavor()
  Debug.MessageBox("You grab the bottle before it can fully enter you, as the drunken bandit starts to drift off.")
elseIf choice == 1 ; Accept
  (GetOwningQuest() as PW_SQ_BanditsScript).IncreaseBanditFavor()
  Debug.MessageBox("You let out a small gasp as the bottle forces its way up your ass. The bandit observes this, pushing it in and out, causing you to fall further into their grasp as your legs give out from underneath you. After toying with you for a few minutes, the bandit finally begins to fuck you.")
  (GetOwningQuest() as PW_SQ_BanditsScript).IncrementBanditsFucked()
endIf
;END CODE
EndFunction
;END FRAGMENT

;BEGIN FRAGMENT Fragment_0
Function Fragment_0(ObjectReference akSpeakerRef)
Actor akSpeaker = akSpeakerRef as Actor
;BEGIN CODE
actor player = Game.GetPlayer()

int i = 0

while i < drinks.length

  if player.GetItemCount(drinks[i])  >= 1
    player.removeItem(drinks[i], 1)
    i = drinks.length
  endIf

  i += 1
endWhile

GetOwningQuest().SetObjectiveCompleted(21)
BeerFetchBandit.clear()
;END CODE
EndFunction
;END FRAGMENT

;END FRAGMENT CODE - Do not edit anything between this and the begin comment

Potion[] Property drinks  Auto  

Message Property PW_SQ_BanditBeerFetchMolestation  Auto  

ReferenceAlias Property BeerFetchBandit  Auto  
