$PSNativeCommandUseErrorActionPreference = $true
$ErrorActionPreference = 'Stop'

# $airSdkLocation = $env:AIR_SDK_HOME

$docs = [Environment]::GetFolderPath("MyDocuments")
$airSdkLocation = Join-Path $docs "AIR_SDKS" "AIRSDK_50.2.4"

$appXml = Join-Path $PSScriptRoot "application.xml"

$adl = Join-Path $airSdkLocation "bin" "adl"
& $adl $appXml
