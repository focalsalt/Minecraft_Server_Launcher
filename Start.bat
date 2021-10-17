@echo off
call "src/serversetting.bat"
title %TITLE%
goto searching


:searching
echo Searching File...
echo ====================
java -version
echo ====================
if %SERVERTYPE% == 0 (
    goto search_complete
)
if %SERVERTYPE% == 1 (
    if %PLUGINTYPE% == 0 (
        set JARFILE=minecraft_bukkit_server.%MCVER%.%PLUGINVER%.jar
        set FILEURL=https://getbukkit.org/download/craftbukkit
    )
    if %PLUGINTYPE% == 1 (
        set JARFILE=minecraft_spigot_server.%MCVER%.%PLUGINVER%.jar
        set FILEURL=https://getbukkit.org/download/spigot
    )
    if %PLUGINTYPE% == 2 (
        set JARFILE=minecraft_paper_server.%MCVER%.%PLUGINVER%.jar
        set FILEURL=https://papermc.io/downloads
    )
    goto search_complete
)
if %SERVERTYPE% == 2 (
    if %MODSTYPE% == 0 (
        set JARFILE=minecraft_forge_server.%MCVER%.%MODSVER%.jar
        set FILEURL=https://files.minecraftforge.net/net/minecraftforge/forge/
    )
    if %MODSTYPE% == 1 (
        set JARFILE=minecraft_fabric_server.%MCVER%.%MODSVER%.jar
        set FILEURL=https://fabricmc.net/use/
    )
    goto search_complete
)


:search_complete
if NOT EXIST %JARFILE% (
    echo File not found!!
    goto install
)
echo File found!!
goto setting


:install
echo Jump to the download page in five seconds...
timeout 5
start "" %FILEURL%
pause
goto searching


:setting
if NOT EXIST server.properties (
    start "" "src/server.properties.html"
    pause
)
echo Open the server in five seconds...
timeout 5


:startserver
echo Starting Minecraft Server...
echo ====================
java -server -Xmx%MAX_RAM% %JAVA_PARAMETERS% -jar %JARFILE% nogui

find "eula=false" eula.txt 1 > NUL 2>&1
if %ERRORLEVEL% EQU 0 (
    echo Make sure to read eula.txt before playing!
    echo ====================
    echo Open eula.txt in five seconds...
    start notepad "eula.txt"
    pause
    goto startserver
)
echo ====================
echo Closed Minecraft Server!!!
pause
