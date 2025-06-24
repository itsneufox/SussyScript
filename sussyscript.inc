/*
    SussyScript
*/

#if defined _sussyscript_included
    #endinput
#endif
#define _sussyscript_included

#define crewmate new
#define impostor static
#define suscheck if
#define not_sus else
#define vent_loop while
#define scan_loop for
#define emergency_meeting printf
#define report_body return
#define TASK public

#define OnShipModeInit OnGameModeInit
#define OnShipModeExit OnGameModeExit
#define OnCrewmateConnect OnPlayerConnect
#define OnCrewmateDisconnect OnPlayerDisconnect
#define OnCrewmateSpawn OnPlayerSpawn
#define OnCrewmateDeath OnPlayerDeath
#define OnCrewmateRequestClass OnPlayerRequestClass
#define OnCrewmateTakeDamage OnPlayerTakeDamage
#define OnCrewmateUpdate OnPlayerUpdate
#define OnCrewmateCommandText OnPlayerCommandText
#define OnCrewmateText OnPlayerText
#define OnCrewmateKeyStateChange OnPlayerKeyStateChange
#define OnCrewmateEnterVehicle OnPlayerEnterVehicle
#define OnCrewmateExitVehicle OnPlayerExitVehicle
#define OnCrewmateStateChange OnPlayerStateChange
#define OnCrewmatePickUpPickup OnPlayerPickUpPickup
#define OnCrewmateClickPlayer OnPlayerClickPlayer
#define OnCrewmateClickTextDraw OnPlayerClickTextDraw

// function-like macros
#define SetCrewmatePos(%0,%1,%2,%3) SetPlayerPos(%0, %1, %2, %3)
#define GetCrewmateHealth(%0,%1) GetPlayerHealth(%0, %1)
#define SetCrewmateHealth(%0,%1) SetPlayerHealth(%0, %1)
#define SetCrewmateAngle(%0,%1) SetPlayerFacingAngle(%0, %1)
#define SetCrewmateBounds(%0,%1,%2,%3,%4) SetPlayerWorldBounds(%0, %1, %2, %3, %4)
#define FollowCrewmateWithCamera(%0) SetCameraBehindPlayer(%0)
#define SetCrewmateCameraPos(%0,%1,%2,%3) SetPlayerCameraPos(%0, %1, %2, %3)
#define SetCrewmateCameraTarget(%0,%1,%2,%3) SetPlayerCameraLookAt(%0, %1, %2, %3)
#define MakeCrewmateSpectate(%0,%1) PlayerSpectatePlayer(%0, %1)
#define ToggleCrewmateSpectating(%0,%1) TogglePlayerSpectating(%0, %1)
#define GiveCrewmateWeapon(%0,%1,%2) GivePlayerWeapon(%0, %1, %2)
#define ResetCrewmateWeapons(%0) ResetPlayerWeapons(%0)
#define GetCrewmateWeapon(%0) GetPlayerWeapon(%0)
#define SetCrewmateArmed(%0,%1) SetPlayerArmedWeapon(%0, %1)
#define GetCrewmateKeys(%0,%1,%2,%3) GetPlayerKeys(%0, %1, %2, %3)
#define GetCrewmateScore(%0) GetPlayerScore(%0)
#define SetCrewmateScore(%0,%1) SetPlayerScore(%0, %1)
#define SetCrewmateColor(%0,%1) SetPlayerColor(%0, %1)
#define IsCrewmateConnected(%0) IsPlayerConnected(%0)
#define SpawnCrewmate(%0) SpawnPlayer(%0)
#define GetCrewmateName(%0,%1,%2) GetPlayerName(%0, %1, %2)

// Communication macros
#define SendMessageToCrewmate(%0,%1,%2) SendClientMessage(%0, %1, %2)
#define SendMessageToAllCrewmates(%0,%1) SendClientMessageToAll(%0, %1)
#define ShowTextToCrewmate(%0,%1,%2,%3) GameTextForPlayer(%0, %1, %2, %3)
#define ShowTextToAllCrewmates(%0,%1,%2) GameTextForAll(%0, %1, %2)
#define ReportDeadBody(%0,%1,%2) SendDeathMessage(%0, %1, %2)

// TextDraw macros
#define CreateSusTextDraw(%0,%1,%2) TextDrawCreate(%0, %1, %2)
#define ShowSusTextForCrewmate(%0,%1) TextDrawShowForPlayer(%0, %1)
#define HideSusTextForCrewmate(%0,%1) TextDrawHideForPlayer(%0, %1)
#define SetSusTextAlignment(%0,%1) TextDrawAlignment(%0, %1)
#define SetSusTextBackground(%0,%1) TextDrawBackgroundColor(%0, %1)
#define SetSusTextFont(%0,%1) TextDrawFont(%0, %1)
#define SetSusTextSize(%0,%1,%2) TextDrawLetterSize(%0, %1, %2)
#define SetSusTextColor(%0,%1) TextDrawColor(%0, %1)
#define SetSusTextOutline(%0,%1) TextDrawSetOutline(%0, %1)
#define SetSusTextProportional(%0,%1) TextDrawSetProportional(%0, %1)
#define SetSusTextShadow(%0,%1) TextDrawSetShadow(%0, %1)

// Game setup macros
#define SetShipGameMode(%0) SetGameModeText(%0)
#define ShowCrewmateMarkers(%0) ShowPlayerMarkers(%0)
#define SendRconToMothership(%0) SendRconCommand(%0)

// Utility macros
#define SusRandom(%0) random(%0)
#define SusTimer(%0,%1,%2) SetTimer(%0, %1, %2)

// Constants
#define MAX_CREWMATES MAX_PLAYERS
#define MAX_CREWMATE_NAME MAX_PLAYER_NAME
#define INVALID_CREWMATE_ID INVALID_PLAYER_ID
#define CREWMATE_MARKERS_OFF PLAYER_MARKERS_MODE_OFF
#define EMERGENCY_BUTTON KEY_SECONDARY_ATTACK
#define IMPOSTOR_KNIFE WEAPON_KNIFE
#define COLOR_SUS_RED 0xFF0000FF
#define COLOR_SUS_GREEN 0x008000FF
#define COLOR_SUS_WHITE 0xFFFFFFFF