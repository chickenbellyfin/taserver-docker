# Preparing Resources
These steps are **not required** if you just want to deploy taserver using this project. If the hosted copies become unavailable at some point in the future, this are the exact steps to re-create them.

## Tribes.zip  (Tribes Ascend)
The Tribes Ascend game files also happen to include the server, which makes self-hosting possible.

Download Tribes Ascend (from steam or another source). Extract it to `Tribes/` (sub dirs should be `Binaries`,`Engine`, `TribesGame`)
- If you are copying it from steam or your installation used for playing, make a copy.

Create the following directory: `Tribes/Binaries/Redist/directx_Jun2010_redist/`

Run `Tribes/Binaries/Redist/directx_Jun2010_redist.exe` and select `Tribes/Binaries/Redist/directx_Jun2010_redist/` as the output dir.

### Optional Step - Delete large, unused files
Delete the following files, they are not required by the server and significantly reduce the package size:
- `Tribes/TribesGame/CookedPC/Textures.tfc`
- `Tribes/TribesGame/CookedPC/CharTextures.tfc`
- `Tribes/TribesGame/CookedPC/Lighting.tfc`
- `Tribes/TribesGame/CookedPC/TribesGameContent.u`
- `Tribes/Binaries/Redist/directx_Jun2010_redist.exe` (already extracted)


### ZIP
Compress `Tribes/` into `Tribes.zip`


## dependencies.zip (Windows only)

This zip contains python, nssm, vc++ 2015, and .NET 3.5, which are all required to run taserver and Tribes Ascend. Packaging them in one zip just makes it convenient to download them in the script.


Create a directory named `dependencies`

### Python 
Python is required to run taserver, as it is written in python.

Download the [64-bit Windows embeddable package](https://www.python.org/downloads/release/python-392/) of python 3+

Extract the zip to `dependencies/python/`

Edit `dependencies/python/python39._pth` and uncomment the line which says `# import site`

Download [`get-pip.py`](https://pip.pypa.io/en/stable/installing/#installing-with-get-pip-py) to `dependencies/python/get-pip.py`

Open cmd in `dependencies/python` and run the following commands:
```
> python.exe get-pip.py
> python.exe -m pip install gevent
> del python39._pth
```

*Tested with Python 3.9.2*

### Non-Sucking Service Manager
NSSM is used by this project to create a windows service which automatically starts taserver and keeps it running.

Download the latest release of the [Non-Sucking Service Manager](https://nssm.cc/download). 

Extract the zip and copy `win64/nssm.exe` to `dependencies/nssm.exe`

*Tested with NSSM 2.24*

### Visual C++ Redistributable for Visual Studio 2015
Visual C++ x86 is required by Tribes Ascend and udpproxy.exe

Download the x86 version of vc_redist from [microsoft](https://www.microsoft.com/en-us/download/details.aspx?id=48145)

Place it in `dependencies/vc_redist.x86.exe`

### .NET 3.5 
You will need an ISO for Windows Server 2019. Mount it and copy the `sources/sxs/` directory to `dependencies/sxs/`

### ZIP
Compress `dependencies/` into `dependencies.zip`
