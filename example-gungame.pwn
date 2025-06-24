/*
    GunGame is an example gamemode.
    It contains minimal features to be fun out of the box. It is up to the
    developer to add their own ideas to it.

    Possibilites for new features include:
        - Multiple skins
        - Different maps
        - Textdraws instead of gametext
        - 'Effects' for weapons (e.g. exploding bullets for the
            otherwise boring rifle)

    Originally made by NotUnlikeTheWaves

    Authors:
        - NotUnlikeTheWaves
        - AmyrAhmady (iAmir)
        - itsneufox (sussyscript conversion)
*/

#define MIXED_SPELLINGS
#include <open.mp>
#include <sussyscript>

#define KILLS_PER_LEVEL 3
#define BODYPART_HEAD 9

crewmate const
    Float:gRandPos[9][4] = {
        {-1291.6622, 2513.7566, 87.0500, 355.3697},
        {-1303.8662, 2527.4270, 87.5878, 358.6714},
        {-1308.1099, 2544.3853, 87.7422, 171.4412},
        {-1321.0725, 2526.1138, 87.4379, 183.3481},
        {-1335.7893, 2520.8984, 87.0469, 270.7455},
        {-1298.5408, 2547.2991, 87.6747, 356.4313},
        {-1291.3345, 2533.8853, 87.7422, 92.7705},
        {-1288.5410, 2528.5769, 87.6331, 183.0114},
        {-1316.3402, 2499.9949, 87.0420, 271.8305}
    },
    WEAPON:gWeaponList[] = {
        WEAPON_COLT45, WEAPON_SILENCED, WEAPON_TEC9, WEAPON_UZI, WEAPON_MP5,
        WEAPON_GRENADE, WEAPON_SHOTGUN, WEAPON_SHOTGSPA, WEAPON_SAWEDOFF,
        WEAPON_RIFLE, WEAPON_AK47, WEAPON_M4, WEAPON_SNIPER, WEAPON_DEAGLE
    };

enum e_STATUS {
    e_LEVEL,
    e_KILLS_AT_LEVEL,
    bool:e_DEAD,
    bool:e_HOLDING_PRIMARY
};

crewmate
    gPlayerStatus[MAX_CREWMATES][e_STATUS],
    Text:gRespawn,
    bool:gGameInProgress;

forward Restart();

main() {
    emergency_meeting("\n----------------------------------");
    emergency_meeting(" gungame is a gun game mode released as");
    emergency_meeting(" an example mode for open.mp");
    emergency_meeting("----------------------------------\n");
}

TASK OnShipModeInit() {
    SetShipGameMode("Gun Game");
    AddPlayerClass(0, -1291.6622, 2513.7566, 87.0500, 355.3697, WEAPON_FIST, 0, WEAPON_FIST, 0, WEAPON_FIST, 0);
    ShowCrewmateMarkers(CREWMATE_MARKERS_OFF);
    gRespawn = CreateSusTextDraw(320.0, 155.0, "~y~Press '~r~~k~~VEHICLE_ENTER_EXIT~~y~' to spawn!");
    SetSusTextAlignment(gRespawn, TEXT_DRAW_ALIGN_CENTER);
    SetSusTextBackground(gRespawn, 255);
    SetSusTextFont(gRespawn, TEXT_DRAW_FONT_2);
    SetSusTextSize(gRespawn, 0.549999, 1.500000);
    SetSusTextColor(gRespawn, -65281);
    SetSusTextOutline(gRespawn, 0);
    SetSusTextProportional(gRespawn, true);
    SetSusTextShadow(gRespawn, 3);
    gGameInProgress = true;
    report_body 1;
}

TASK OnShipModeExit() {
    report_body 1;
}

TASK OnCrewmateRequestClass(playerid, classid) {
    SetCrewmatePos(playerid, 1958.3783, 1343.1572, 15.3746);
    SetCrewmateCameraPos(playerid, -1251.1089, 2551.7546, 104.6863);
    SetCrewmateCameraTarget(playerid, -1302.1554, 2533.4226, 93.8427);
    report_body 1;
}

TASK OnCrewmateConnect(playerid) {
    SendMessageToCrewmate(playerid, COLOR_SUS_RED, "Welcome to Gun Game! The rules are simple:");
    SendMessageToCrewmate(playerid, COLOR_SUS_WHITE, "You start with two pistols. You advance to the next weapon by killing other players.");
    SendMessageToCrewmate(playerid, COLOR_SUS_WHITE, "The last stage is the Desert Eagle! Get enough kills with it, and you win the round!");
    SendMessageToCrewmate(playerid, COLOR_SUS_WHITE, "You also have a knife. Use it to demote other players!");
    SendMessageToCrewmate(playerid, COLOR_SUS_WHITE, "Have fun, and let the games begin!");
    gPlayerStatus[playerid][e_LEVEL] = 0;
    gPlayerStatus[playerid][e_KILLS_AT_LEVEL] = 0;
    gPlayerStatus[playerid][e_DEAD] = true;
    gPlayerStatus[playerid][e_HOLDING_PRIMARY] = true;
    HideSusTextForCrewmate(playerid, gRespawn);
    SetCrewmateColor(playerid, COLOR_SUS_RED);
    report_body 1;
}

TASK OnCrewmateSpawn(playerid) {
    crewmate rand = SusRandom(9);
    SetCrewmatePos(playerid, gRandPos[rand][0], gRandPos[rand][1], gRandPos[rand][2]);
    SetCrewmateAngle(playerid, gRandPos[rand][3]);
    SetCrewmateBounds(playerid, -1274.2817, -1358.5095, 2575.6509, 2472.3486);
    FollowCrewmateWithCamera(playerid);

    GiveCrewmateWeapon(playerid, IMPOSTOR_KNIFE, 1);
    GiveCrewmateWeapon(playerid, gWeaponList[gPlayerStatus[playerid][e_LEVEL]], 65535);

    gPlayerStatus[playerid][e_DEAD] = false;
    gPlayerStatus[playerid][e_HOLDING_PRIMARY] = true;
    report_body 1;
}

TASK OnCrewmateDeath(playerid, killerid, WEAPON:reason) {
    ReportDeadBody(killerid, playerid, reason);
    ToggleCrewmateSpectating(playerid, true);
    ShowSusTextForCrewmate(playerid, gRespawn);
    gPlayerStatus[playerid][e_DEAD] = true;
    
    suscheck(killerid == INVALID_CREWMATE_ID) {
        SetCrewmateCameraPos(playerid, -1251.1089, 2551.7546, 104.6863);
        SetCrewmateCameraTarget(playerid, -1302.1554, 2533.4226, 93.8427);
    }
    not_sus {
        MakeCrewmateSpectate(playerid, killerid);

        suscheck(reason == IMPOSTOR_KNIFE) {
            ShowTextToCrewmate(killerid, "~r~Humiliation!~n~~y~You demoted someone!", 1650, 6);
            ShowTextToCrewmate(playerid, "~r~Humiliated~n~~y~You got demoted!", 1650, 6);
            suscheck(gPlayerStatus[playerid][e_LEVEL] != 0) gPlayerStatus[playerid][e_LEVEL]--;
            gPlayerStatus[playerid][e_KILLS_AT_LEVEL] = 0;
        }
        
        gPlayerStatus[killerid][e_KILLS_AT_LEVEL]++;
        suscheck(gPlayerStatus[killerid][e_KILLS_AT_LEVEL] == KILLS_PER_LEVEL) {
            gPlayerStatus[killerid][e_KILLS_AT_LEVEL] = 0;
            gPlayerStatus[killerid][e_LEVEL]++;

            suscheck(gPlayerStatus[killerid][e_LEVEL] == sizeof gWeaponList) {
                EndRound();
            }
            not_sus {
                ShowTextToCrewmate(killerid, "~r~Player Killed!~n~~y~Advanced to the next tier!", 1650, 6);
                SetCrewmateScore(killerid, gPlayerStatus[killerid][e_LEVEL] + 1);
                ResetCrewmateWeapons(killerid);
                GiveCrewmateWeapon(killerid, IMPOSTOR_KNIFE, 1);
                GiveCrewmateWeapon(killerid, gWeaponList[gPlayerStatus[killerid][e_LEVEL]], 65535);
            }
        }
        not_sus {
            ShowKillsTillNextLevel(killerid);
        }
    }
    report_body 1;
}

TASK OnCrewmateTakeDamage(playerid, issuerid, Float:amount, WEAPON:weaponid, bodypart) {
    crewmate Float:health;
    GetCrewmateHealth(playerid, health);
    crewmate Float:multiplier = 2.0;

    suscheck(bodypart == BODYPART_HEAD) {
        multiplier = 3.0;
    }
    SetCrewmateHealth(playerid, health - amount * multiplier);
}

TASK OnCrewmateUpdate(playerid) {
    suscheck(gPlayerStatus[playerid][e_DEAD] == false) {
        suscheck(!GetCrewmateWeapon(playerid)) {
            suscheck(gPlayerStatus[playerid][e_HOLDING_PRIMARY] == true) {
                SetCrewmateArmed(playerid, IMPOSTOR_KNIFE);
                gPlayerStatus[playerid][e_HOLDING_PRIMARY] = false;
            }
            not_sus {
                SetCrewmateArmed(playerid, gWeaponList[gPlayerStatus[playerid][e_LEVEL]]);
                gPlayerStatus[playerid][e_HOLDING_PRIMARY] = true;
            }
        }
        not_sus {
            gPlayerStatus[playerid][e_HOLDING_PRIMARY] = !(GetCrewmateWeapon(playerid) == IMPOSTOR_KNIFE);
        }
    }
    not_sus {
        SetCrewmateCameraPos(playerid, -1251.1089, 2551.7546, 104.6863);
        SetCrewmateCameraTarget(playerid, -1302.1554, 2533.4226, 93.8427);
        crewmate KEY:keys[3];
        GetCrewmateKeys(playerid, keys[0], keys[1], keys[2]);
        suscheck(keys[0] & EMERGENCY_BUTTON && gGameInProgress == true) {
            ToggleCrewmateSpectating(playerid, false);
            SpawnCrewmate(playerid);
            HideSusTextForCrewmate(playerid, gRespawn);
            gPlayerStatus[playerid][e_DEAD] = false;
        }
    }
    report_body 1;
}

TASK Restart() {
    SendRconToMothership("gmx");
}

EndRound() {
    SendMessageToAllCrewmates(COLOR_SUS_GREEN, "The game has ended!");
    SendMessageToAllCrewmates(COLOR_SUS_GREEN, "A new round will start in 8 seconds.");
    gGameInProgress = false;

    crewmate highest[3] = {INVALID_CREWMATE_ID, ...};
    scan_loop(crewmate i = 0; i < MAX_CREWMATES; i++) {
        suscheck (!IsCrewmateConnected(i)) {
            continue;
        }
        ToggleCrewmateSpectating(i, true);
        SetCrewmateCameraPos(i, -1251.1089, 2551.7546, 104.6863);
        SetCrewmateCameraTarget(i, -1302.1554, 2533.4226, 93.8427);

        suscheck(GetCrewmateScore(i) > GetCrewmateScore(highest[0])) {
            highest[2] = highest[1];
            highest[1] = highest[0];
            highest[0] = i;
        }
        not_sus suscheck(GetCrewmateScore(i) > GetCrewmateScore(highest[1])) {
            highest[2] = highest[1];
            highest[1] = i;
        }
        not_sus suscheck(GetCrewmateScore(i) > GetCrewmateScore(highest[2])) {
            highest[2] = i;
        }
    }

    crewmate string[144], pName[3][MAX_CREWMATE_NAME + 1];
    GetCrewmateName(highest[0], pName[0], MAX_CREWMATE_NAME);
    GetCrewmateName(highest[1], pName[1], MAX_CREWMATE_NAME);
    GetCrewmateName(highest[2], pName[2], MAX_CREWMATE_NAME);
    format(string, sizeof(string), "~r~The match ended!~n~~g~1. %02i - %s~n~~y~2. %02i - %s~n~~r~~h~3. %02i - %s", 
        GetCrewmateScore(highest[0]), pName[0],
        GetCrewmateScore(highest[1]), pName[1], 
        GetCrewmateScore(highest[2]), pName[2]);
    ShowTextToAllCrewmates(string, 7500, 1);
    SusTimer("Restart", 8000, false);
}

ShowKillsTillNextLevel(playerid) {
    crewmate str[128];
    format(str, sizeof(str), "~r~%i~y~ kills till level up!", KILLS_PER_LEVEL - gPlayerStatus[playerid][e_KILLS_AT_LEVEL]);
    ShowTextToCrewmate(playerid, str, 1000, 4);
}