#!/bin/bash
xpra start -d auth --bind-tcp=0.0.0.0:6000,auth=env :100
DISPLAY=:100 /usr/bin/simutrans -easyserver 