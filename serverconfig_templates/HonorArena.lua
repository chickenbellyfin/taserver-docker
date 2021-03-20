-- TAMods-Server configuration can be placed in this file
-- You can read about the configuration language at: https://www.tamods.org/docs/doc_srv_api_overview.html

ServerSettings.Description = "{{tribesServerName}}"
ServerSettings.Motd = "Medium honor loadout enforced by server!"
ServerSettings.GameSettingMode = ServerSettings.GameSettingModes.OOTB

{{tribesServerPassword}}
-- Basic Access Control, see https://www.tamods.org/docs/doc_srv_api_admin.html for more
{{tribesServerAdminPassword}}

-- Some other settings you might need, just uncomment those lines
-- If you need more settings, check the documentation at : https://www.tamods.org/docs/doc_srv_api_serverconfig.html

ServerSettings.TimeLimit = 25
ServerSettings.FriendlyFire = true
ServerSettings.ArenaRounds = 1
ServerSettings.ArenaLives = 35

ServerSettings.MapRotation.VotingEnabled = true
ServerSettings.MapRotation.add(Maps.Arena.AirArena)
ServerSettings.MapRotation.add(Maps.Arena.Fraytown)
ServerSettings.MapRotation.add(Maps.Arena.Hinterlands)
ServerSettings.MapRotation.add(Maps.Arena.LavaArena)
ServerSettings.MapRotation.add(Maps.Arena.Undercroft)
ServerSettings.MapRotation.add(Maps.Arena.WalledIn)
ServerSettings.MapRotation.add(Maps.Arena.Whiteout)

ServerSettings.LightCountLimit = 0
ServerSettings.MediumCountLimit = 32
ServerSettings.HeavyCountLimit = 1
ServerSettings.ForceHardcodedLoadouts = true

ServerSettings.DisabledEquipPoints.add("Medium", Loadouts.EquipPoints.Tertiary)

-- Heavy count limit doesn't work, removing all weapons instead
ServerSettings.DisabledEquipPoints.add("Heavy", Loadouts.EquipPoints.Melee)
ServerSettings.DisabledEquipPoints.add("Heavy", Loadouts.EquipPoints.Primary)
ServerSettings.DisabledEquipPoints.add("Heavy", Loadouts.EquipPoints.Secondary)
ServerSettings.DisabledEquipPoints.add("Heavy", Loadouts.EquipPoints.Tertiary)
ServerSettings.DisabledEquipPoints.add("Heavy", Loadouts.EquipPoints.Pack)
ServerSettings.DisabledEquipPoints.add("Heavy", Loadouts.EquipPoints.Belt)
ServerSettings.DisabledEquipPoints.add("Heavy", Loadouts.EquipPoints.Deployable)


Loadouts.Hardcoded.Medium.set(0, Loadouts.EquipPoints.Primary, "Spinfusor")
Loadouts.Hardcoded.Medium.set(0, Loadouts.EquipPoints.Secondary, "Honorfusor")
Loadouts.Hardcoded.Medium.set(0, Loadouts.EquipPoints.Belt, "Anti-Personnel Grenade")
Loadouts.Hardcoded.Medium.set(0, Loadouts.EquipPoints.Pack, "Utility Pack")

Loadouts.Hardcoded.Medium.set(1, Loadouts.EquipPoints.Primary, "Spinfusor")
Loadouts.Hardcoded.Medium.set(1, Loadouts.EquipPoints.Secondary, "Honorfusor")
Loadouts.Hardcoded.Medium.set(1, Loadouts.EquipPoints.Belt, "Anti-Personnel Grenade")
Loadouts.Hardcoded.Medium.set(1, Loadouts.EquipPoints.Pack, "Utility Pack")

Loadouts.Hardcoded.Medium.set(2, Loadouts.EquipPoints.Primary, "Spinfusor")
Loadouts.Hardcoded.Medium.set(2, Loadouts.EquipPoints.Secondary, "Honorfusor")
Loadouts.Hardcoded.Medium.set(2, Loadouts.EquipPoints.Belt, "Anti-Personnel Grenade")
Loadouts.Hardcoded.Medium.set(2, Loadouts.EquipPoints.Pack, "Utility Pack")

Loadouts.Hardcoded.Medium.set(3, Loadouts.EquipPoints.Primary, "Spinfusor")
Loadouts.Hardcoded.Medium.set(3, Loadouts.EquipPoints.Secondary, "Honorfusor")
Loadouts.Hardcoded.Medium.set(3, Loadouts.EquipPoints.Belt, "Anti-Personnel Grenade")
Loadouts.Hardcoded.Medium.set(3, Loadouts.EquipPoints.Pack, "Utility Pack")

Loadouts.Hardcoded.Medium.set(4, Loadouts.EquipPoints.Primary, "Spinfusor")
Loadouts.Hardcoded.Medium.set(4, Loadouts.EquipPoints.Secondary, "Honorfusor")
Loadouts.Hardcoded.Medium.set(4, Loadouts.EquipPoints.Belt, "Anti-Personnel Grenade")
Loadouts.Hardcoded.Medium.set(4, Loadouts.EquipPoints.Pack, "Utility Pack")

Loadouts.Hardcoded.Medium.set(5, Loadouts.EquipPoints.Primary, "Spinfusor")
Loadouts.Hardcoded.Medium.set(5, Loadouts.EquipPoints.Secondary, "Honorfusor")
Loadouts.Hardcoded.Medium.set(5, Loadouts.EquipPoints.Belt, "Anti-Personnel Grenade")
Loadouts.Hardcoded.Medium.set(5, Loadouts.EquipPoints.Pack, "Utility Pack")

Loadouts.Hardcoded.Medium.set(6, Loadouts.EquipPoints.Primary, "Spinfusor")
Loadouts.Hardcoded.Medium.set(6, Loadouts.EquipPoints.Secondary, "Honorfusor")
Loadouts.Hardcoded.Medium.set(6, Loadouts.EquipPoints.Belt, "Anti-Personnel Grenade")
Loadouts.Hardcoded.Medium.set(6, Loadouts.EquipPoints.Pack, "Utility Pack")

Loadouts.Hardcoded.Medium.set(7, Loadouts.EquipPoints.Primary, "Spinfusor")
Loadouts.Hardcoded.Medium.set(7, Loadouts.EquipPoints.Secondary, "Honorfusor")
Loadouts.Hardcoded.Medium.set(7, Loadouts.EquipPoints.Belt, "Anti-Personnel Grenade")
Loadouts.Hardcoded.Medium.set(7, Loadouts.EquipPoints.Pack, "Utility Pack")

Loadouts.Hardcoded.Medium.set(8, Loadouts.EquipPoints.Primary, "Spinfusor")
Loadouts.Hardcoded.Medium.set(8, Loadouts.EquipPoints.Secondary, "Honorfusor")
Loadouts.Hardcoded.Medium.set(8, Loadouts.EquipPoints.Belt, "Anti-Personnel Grenade")
Loadouts.Hardcoded.Medium.set(8, Loadouts.EquipPoints.Pack, "Utility Pack")

Loadouts.Hardcoded.Medium.set(9, Loadouts.EquipPoints.Primary, "Spinfusor")
Loadouts.Hardcoded.Medium.set(9, Loadouts.EquipPoints.Secondary, "Honorfusor")
Loadouts.Hardcoded.Medium.set(9, Loadouts.EquipPoints.Belt, "Anti-Personnel Grenade")
Loadouts.Hardcoded.Medium.set(9, Loadouts.EquipPoints.Pack, "Utility Pack")

ServerSettings.BannedItems.add("Light", "Sparrow")
ServerSettings.BannedItems.add("Light", "Phase Rifle")
ServerSettings.BannedItems.add("Light", "BXT1 Rifle")
ServerSettings.BannedItems.add("Medium", "Eagle Pistol")
ServerSettings.BannedItems.add("Heavy", "Nova Colt")
