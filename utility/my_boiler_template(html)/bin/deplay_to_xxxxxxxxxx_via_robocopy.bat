set PROJECT_NAME=BOILER_TEMPLATE
set SRC_NETWORK_NAME=xxxxxxxxxx
set DST_NETWORK_NAME=yyyyyyyyyy

rem local directory
set SRC_DIRECTORY=\\%SRC_NETWORK_NAME%\path\to\%PROJECT_NAME%

rem remote directory
set DST_DIRECTORY1=\\%DST_NETWORK_NAME%\path\to\%PROJECT_NAME%

@echo
robocopy "%SRC_DIRECTORY%" "%DST_DIRECTORY1%" /MIR /LEV:10 /R:3 /W:3 ^
    /XF "web.config" ^
    /XF "Thumbs.db" ^
    /XF ".gitkeep" ^
    /XF ".gitignore" ^
    /XD "%SRC_DIRECTORY%\.idea" ^
    /XD "%SRC_DIRECTORY%\.git" ^
    /XD "%SRC_DIRECTORY%\bin"
