# PACT

![PACT logo](assets/pact-logo-simple.png)

**Pull And Check Tools** is a compact World of Warcraft Classic raid control panel.

PACT keeps the common raid-leader controls close to your cursor without keeping the full Blizzard Raid Manager open. It adds a small draggable panel with buttons for:

- Ready Check
- Pull timer
- Role Check
- Break timer
- Optional Cancel button

It also includes options to hide Blizzard Raid Manager controls without hiding party or raid frames, lock the mini panel, show the panel while solo for positioning, choose horizontal or vertical layout, reverse button order, scale the panel, and configure pull/break times.

## CurseForge Summary

Compact Ready Check, Pull, Role Check, Break, and Cancel controls for WoW Classic raid leaders.

## Features

- Compact draggable raid control panel.
- Ready Check, Pull timer, Role Check, Break timer, and optional Cancel button.
- Break timer support using BigWigs-style `/break` behavior when available.
- Pull and Break controls wait for an active Role Check to finish.
- Horizontal or vertical layout.
- Optional reverse button order.
- Panel scale control from the addon options.
- Solo display mode for positioning the panel outside a group or raid.
- Option to hide Blizzard Raid Manager controls without hiding party or raid frames.
- Per-character saved settings.

## Compatibility

PACT is built for WoW Classic Anniversary / TBC Classic Anniversary.

Current interface version:

```text
20506
```

## Commands

```text
/pact
/pact lock
/pact unlock
/pact reset
/pact blizzard
```

The configuration panel is also available from the in-game addon options.

## Options

- Hide Blizzard Raid Manager controls without hiding party or raid frames
- Show mini panel while solo
- Lock mini panel
- Show Cancel button
- Vertical layout
- Reverse button order
- Hide handle when locked
- Pull time in seconds
- Break time in minutes
- Panel scale percent

## Installation

Download `PACT.zip` from the latest GitHub Release and extract it into:

```text
World of Warcraft/_anniversary_/Interface/AddOns/
```

After extraction, the addon folder should be:

```text
World of Warcraft/_anniversary_/Interface/AddOns/PACT/
```

Restart the game or reload the UI.

Do not use GitHub's green **Code > Download ZIP** button for installation. That downloads the source repository snapshot, not the packaged addon.

## Localization

PACT supports:

- English (`enUS`, `enGB`, default)
- Brazilian Portuguese (`ptBR`)
- German (`deDE`)
- Spanish, Spain (`esES`)
- Spanish, Mexico (`esMX`)
- French (`frFR`)
- Italian (`itIT`)
- Korean (`koKR`)
- Russian (`ruRU`)
- Simplified Chinese (`zhCN`)
- Traditional Chinese (`zhTW`)

## Changelog

See [CHANGELOG.md](CHANGELOG.md).
