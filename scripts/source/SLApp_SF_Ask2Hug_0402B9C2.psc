;BEGIN FRAGMENT CODE - Do not edit anything between this and the end comment
;NEXT FRAGMENT INDEX 1
Scriptname SLApp_SF_Ask2Hug_0402B9C2 Extends Scene Hidden

;BEGIN FRAGMENT Fragment_0
Function Fragment_0()
;BEGIN CODE
SexUtil.PlayHug(askRef.GetActorRef(), ansRef.GetActorRef())
;END CODE
EndFunction
;END FRAGMENT

;END FRAGMENT CODE - Do not edit anything between this and the begin comment

SLAppSexUtil Property SexUtil  Auto  

ReferenceAlias Property ansRef  Auto  

ReferenceAlias Property askRef  Auto  
