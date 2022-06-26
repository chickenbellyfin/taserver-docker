# VM Size / Resources
**TL;DR: 1 CPU / 2GB RAM is enough for 1 full server**

A CPU in this case refers to a single core. taserver will use 15-70% CPU and 500MB-1GB RAM based on how full it is. If you would like to run multiple servers on a host, you will need more resources.

Rule of thumb:
- add 1 CPU based on how many servers can be **active** (players in them) at any given time.
- add 1GB RAM based on how many total servers you want to make available.

So for example (using common vm sizes):
- 2 active servers and 6-7 total, server should be around 2CPU/8GB
- 8 total servers, all active (like in a tournament) would probably work on 8CPU/16GB

Disk: The image is  ~10GB, and very little data gets stored, so a small disk is fine.