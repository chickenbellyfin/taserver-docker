# Creating Tribes.tar.zst

These steps are **not required** if you just want to deploy taserver using this project.
If the hosted copies become unavailable at some point in the future, these are the exact steps to re-create them.

The Tribes Ascend game files also happen to include the server, which makes self-hosting possible.

## Steps
Download Tribes Ascend (from steam or another source). Extract it to `Tribes/` (sub dirs should be `Binaries`,`Engine`, `TribesGame`)
- If you are copying it from steam or your installation used for playing, make a copy.

### Delete large, unused files
Delete the following files, they are not required by the server and significantly reduce the package size:

```
rm Tribes/TribesGame/CookedPC/Textures.tfc
rm Tribes/TribesGame/CookedPC/CharTextures.tfc
rm Tribes/TribesGame/CookedPC/Lighting.tfc
rm Tribes/TribesGame/CookedPC/TribesGameContent.u
rm Tribes/Binaries/Redist/directx_Jun2010_redist.exe
```

### Archive
The game files are compressed with `zstd` to create the smallest possible download size. The resulting file will be ~1.6GB
```
tar -c Tribes | zstd --ultra -22 -T0 -o Tribes.tar.zst
```
