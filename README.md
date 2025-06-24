# SussyScript 🚨

*"A language so sus, even your compiler vents."*

## What is SussyScript?

SussyScript is a cursed amogus themed macro include built on top of PAWN for SA-MP/open.mp. It replaces boring traditional keywords with sus amogus terminology, making your code unreadable and absolutely chaotic.

## Installation

1. Download `sussyscript.inc`
2. Place it in your `pawno/include` folder
3. Add `#include <sussyscript>` to your gamemode
4. Profit?

## Basic Syntax

### Variable Declaration
```pawn
// Traditional PAWN 👎 
new playerHealth = 100;
new Float:position[3];

// SussyScript 👍
crewmate playerHealth = 100;
crewmate Float:position[3];
```

### Conditionals
```pawn
// Traditional PAWN 👎
if (playerid == killerid) {
    // code
} else {
    // other code
}

// SussyScript 👍
suscheck (playerid == killerid) {
    // code
} not_sus {
    // other code
}
```

### Functions
```pawn
// Traditional PAWN 👎
public OnPlayerConnect(playerid) {
    printf("Player connected");
    return 1;
}

// SussyScript 👍
TASK OnCrewmateConnect(playerid) {
    emergency_meeting("Crewmate joined the ship");
    report_body 1;
}
```

### Loops
```pawn
// Traditional PAWN 👎
for (new i = 0; i < MAX_PLAYERS; i++) {
    if (IsPlayerConnected(i)) {
        // code
    }
}

// SussyScript 👍
scan_loop (crewmate i = 0; i < MAX_CREWMATES; i++) {
    suscheck (IsCrewmateConnected(i)) {
        // code
    }
}
```

## Player Functions

| SussyScript 👍 | Original PAWN 👎 |
|-------------|---------------|
| `SetCrewmatePos()` | `SetPlayerPos()` |
| `GetCrewmateHealth()` | `GetPlayerHealth()` |
| `GiveCrewmateWeapon()` | `GivePlayerWeapon()` |
| `SendMessageToCrewmate()` | `SendClientMessage()` |
| `IsCrewmateConnected()` | `IsPlayerConnected()` |
| `SpawnCrewmate()` | `SpawnPlayer()` |
| `EjectCrewmate()` | `Kick()` |

## Callbacks

| SussyScript 👍 | Original PAWN 👎 |
|-------------|---------------|
| `OnShipModeInit` | `OnGameModeInit` |
| `OnCrewmateConnect` | `OnPlayerConnect` |
| `OnCrewmateSpawn` | `OnPlayerSpawn` |
| `OnCrewmateDeath` | `OnPlayerDeath` |
| `OnCrewmateTakeDamage` | `OnPlayerTakeDamage` |

## Why Does This Exist?

Because someone had to do it. This started as a joke about creating an amogus-themed programming language and somehow became a real, working PAWN include file. It's completely functional but absolutely cursed.

## Compatibility

- ✅ Dobby's SAT code
- ✅ pushline legs
- ✅ Syther moder

## Contributing

If you want to contribute to this clusterfuck, feel free to:
1. Question your life choices
2. Read 1. again

## License

This project is licensed under the "What Have I Done" license. Use at your own risk.

---

*Remember: If your code is sus, you might be the impostor.* 🔴
