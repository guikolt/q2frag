# Quake 2 PRO server
This repository is currently running with
- debian buster slim (x86_64 + lib32)
- q2proded (x86_64)
- opentdm
- openffa
- maps: single player plus q2dm[1-8]

Server configuration is hardcoded. If you want to modify, build your own image based on this repository.
Download content URL is set to http://quake.frag.com.br.

# Add more maps
You can use bind mount volumes in order to add more maps.
Just add `-v /your/map/folder:/home/quake2/baseq2/maps` to the docker run command line

# Custom settings for the server
The current supported customizations are

Environment Variable | Description | Default value
------ | ------ | ------
GAMEMODE | Supports: opentdm, duel, openffa, instagib | opentdm
SERVERNAME | Sets the server hostname | DefaultQ2DockerServer
RCON_PASSWORD | Sets the rcon_password for the server | letmein
ADMIN_PASSWORD | Sets the opentdm admin password for the server | letmein
MAXCLIENTS | Sets the server maxclients | 22

# Examples on how to run the server

### Spawns an opentdm server on port 27910 with the default settings
`docker run -d --name opentdm1 -p 27910:27910/tcp -p 27910:27910/udp guikolt/q2frag`

### Spawns an opentdm server on port 27911 with custom settings
`docker run -d --name opentdm2 -e SERVERNAME="FRAG.com.br - OpenTDM Server" -e "RCON_PASSWORD=chupeta" -e "ADMIN_PASSWORD=baleia" -p 27911:27910/tcp -p 27911:27910/udp guikolt/q2frag`

### Spawns a duel server on port 27912 with custom settings
`docker run -d --name duel -e SERVERNAME="FRAG.com.br - Duel" -e "GAMEMODE=duel" -e "RCON_PASSWORD=chupeta" -e "ADMIN_PASSWORD=baleia" -p 27912:27910/tcp -p 27912:27910/udp guikolt/q2frag`

# Monitoring server logs

You can see the server logs in realtime by doing
`docker exec -it container_name tail -f opentdm/logs/server.log`
