;BEGIN FRAGMENT CODE - Do not edit anything between this and the end comment
;NEXT FRAGMENT INDEX 2
Scriptname SLApp_SF_Ask2Scene_04015618 Extends Scene Hidden

;BEGIN FRAGMENT Fragment_1
Function Fragment_1()
;BEGIN CODE
SexUtil.StartSexNPC(askRef, ansRef, helperRef)
;END CODE
EndFunction
;END FRAGMENT

;END FRAGMENT CODE - Do not edit anything between this and the begin comment

ReferenceAlias Property askRef  Auto  
ReferenceAlias Property ansRef  Auto  
SLAppSexUtil Property SexUtil Auto

ReferenceAlias Property HelperRef  Auto  
