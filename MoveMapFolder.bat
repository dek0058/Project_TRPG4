@echo off
setlocal

set MAP_PATH="Engine.w3x"
set FOLDER_PATH="C:\Users\dek00\Documents\Warcraft III\Maps\Test"

xcopy %MAP_PATH% %FOLDER_PATH% /d /y