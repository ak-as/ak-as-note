# listbin.bat

## 概要

バッチファイルを配置しているbinディレクトリ内の実行ファイルやバッチファイル等の一覧表示する。

## コード

    @echo off
    echo.
    dir "%~dp0" | findstr /b /r "[0-9][0-9][0-9][0-9]/[0-9][0-9]/[0-9][0-9]  [0-9][0-9]:[0-9][0-9]" | findstr /e /l /v "%~nx0" | findstr /e /l /v .
    exit /b
