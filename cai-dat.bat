@echo off
chcp 65001 >nul
title Cai dat Ung dung Quan ly cong viec
powershell -NoProfile -ExecutionPolicy Bypass -File "%~dp0cai-dat.ps1"
echo.
pause
