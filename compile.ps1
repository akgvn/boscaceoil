$PSNativeCommandUseErrorActionPreference = $true
$ErrorActionPreference = 'Stop'

# $airSdkLocation = $env:AIR_SDK_HOME

$docs = [Environment]::GetFolderPath("MyDocuments")
$airSdkLocation = Join-Path $docs "AIR_SDKS" "AIRSDK_50.2.4"

# Check if AIR_SDK_HOME environment variable exists
if ([string]::IsNullOrWhiteSpace($airSdkLocation)) {
    Write-Output "AIR_SDK_HOME environment variable doesn't exist."
    Write-Output "Please create it before running this script."
    Read-Host "Press Enter to continue..."
    return
}

$amxmlc = Join-Path $airSdkLocation "bin" "amxmlc.bat"
$appXmlPath = Join-Path $PSScriptRoot "application.xml"

# Check if application.xml exists
if (Test-Path -Path $appXmlPath) {
    Write-Output "The file application.xml exists!"
} else {
    Write-Output "The file application.xml doesn't exist."
    Write-Output "Please make sure this file is available and try again."
    Read-Host "Press Enter to continue..."
    return 1
}

# $xmlFile = Join-Path "$PSScriptRoot" "application.xml"
# This doesn't work for some reason:
# $content = Select-Xml -Path $xmlFile -XPath "//content" | ForEach-Object { $_.Node.'#text'.Trim() }

$fileName = $null
if ([string]::IsNullOrWhiteSpace($content)) {
    Write-Output "No file name found in application.xml. Using BoscaCeoil.swf..."
    $fileName = "BoscaCeoil.swf"
} else {
    Write-Output "Found $content in application.xml. Using $content..."
    $fileName = $content
}

Write-Output "$fileName doesn't exist. Compiling the application..."

$sionPath = Join-Path $PSScriptRoot "lib/sion065.swc"
$srcPath = Join-Path $PSScriptRoot "src"
$filePath = Join-Path $PSScriptRoot $fileName

# Compile the application
Start-Process -filepath $amxmlc -argumentList @("-swf-version", 28, "-default-frame-rate", 30, "-default-size", 768, 560, "-library-path+=$sionPath", "-source-path+=$srcPath", "-default-background-color", 0x000000, "-warnings", "-strict", "$srcPath/Main.as", "-o", "$filePath", "-define+=CONFIG::desktop,true", "-define+=CONFIG::web,false") -NoNewWindow -Wait
Write-Output "Compilation finished."
Write-Output "If no error was thrown by the Java Runtime, $fileName should now exist."
