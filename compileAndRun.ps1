$PSNativeCommandUseErrorActionPreference = $true
$ErrorActionPreference = 'Stop'

$compile = Join-Path $PSScriptRoot "compile.ps1"
$run = Join-Path $PSScriptRoot "run.ps1"

& $compile
& $run
