#!/bin/bash

# variables
export BASEPATH="/home/quake2"

if [ "${GAMEMODE}" = "duel" ]; then
  GAMECMD="opentdm"
else
  GAMECMD="${GAMEMODE}"
fi

# functions
create_cfg() {

  if [ "${GAMEMODE:-opentdm}" = "duel" ]; then
    cp ${BASEPATH}/opentdm/duel.cfg ${BASEPATH}/opentdm/server.cfg
    sed -i "s/SERVER_HOSTNAME/${SERVERNAME:-DefaultQ2DockerServer}/g" opentdm/server.cfg
    sed -i "s/SERVER_RCON_PASSWORD/${RCON_PASSWORD:-letmein}/g" opentdm/server.cfg
    sed -i "s/SERVER_ADMIN_PASSWORD/${ADMIN_PASSWORD:-letmein}/g" opentdm/server.cfg
  elif [ "${GAMEMODE:-opentdm}" = "opentdm" ]; then
    cp ${BASEPATH}/opentdm/opentdm.cfg ${BASEPATH}/opentdm/server.cfg
    sed -i "s/SERVER_HOSTNAME/${SERVERNAME:-DefaultQ2DockerServer}/g" ${GAMEMODE:-opentdm}/server.cfg
    sed -i "s/SERVER_RCON_PASSWORD/${RCON_PASSWORD:-letmein}/g" ${GAMEMODE:-opentdm}/server.cfg
    sed -i "s/SERVER_ADMIN_PASSWORD/${ADMIN_PASSWORD:-letmein}/g" ${GAMEMODE:-opentdm}/server.cfg
  else
    sed -i "s/SERVER_HOSTNAME/${SERVERNAME:-DefaultQ2DockerServer}/g" ${GAMEMODE:-opentdm}/server.cfg
    sed -i "s/SERVER_RCON_PASSWORD/${RCON_PASSWORD:-letmein}/g" ${GAMEMODE:-opentdm}/server.cfg
    sed -i "s/SERVER_ADMIN_PASSWORD/${ADMIN_PASSWORD:-letmein}/g" ${GAMEMODE:-opentdm}/server.cfg
  fi
}


run_Server() {
  cd ${BASEPATH}
  while [ true ]; do
    ./q2proded +set deathmatch 1 +set dedicated 1 +set sv_fps 40 +set game ${GAMECMD:-opentdm} +set maxclients ${MAXCLIENTS:-22} +exec server.cfg +map q2dm1
    sleep 5
  done
}

create_cfg
run_Server
