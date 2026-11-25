<#
.SYNOPSIS
Nilesoft Shell sağ tık menüsüne .zip dosyaları için "Klasöre çıkart" öğesini (2. sıra) ekler.
#>
param(
	[string]$ShellDir,
	[switch]$NoRestart
)

$ErrorActionPreference = 'Stop'
$utf8NoBom = [System.Text.UTF8Encoding]::new($false)

if (-not $ShellDir) {
	$clsidPath = 'Registry::HKEY_CLASSES_ROOT\CLSID\{BAE3934B-8A6A-4BFB-81BD-3FC599A1BAF1}\InprocServer32'
	if (Test-Path $clsidPath) {
		$dll = (Get-ItemProperty $clsidPath).'(default)'
		if ($dll -and (Test-Path $dll)) {
			$ShellDir = Split-Path $dll -Parent
		}
	}
}
if (-not $ShellDir -and (Test-Path "$env:ProgramFiles\Nilesoft Shell\shell.nss")) {
	$ShellDir = "$env:ProgramFiles\Nilesoft Shell"
}
if (-not $ShellDir -or -not (Test-Path (Join-Path $ShellDir 'shell.nss'))) {
	throw 'Nilesoft Shell bulunamadı. Önce Nilesoft Shell kurup register edin veya -ShellDir verin.'
}

$sevenZip = @("$env:ProgramFiles\7-Zip\7zG.exe", "${env:ProgramFiles(x86)}\7-Zip\7zG.exe") |
	Where-Object { Test-Path $_ } |
	Select-Object -First 1
if (-not $sevenZip) {
	throw '7-Zip (7zG.exe) bulunamadı.'
}

$importsDir = Join-Path $ShellDir 'imports'
New-Item -ItemType Directory -Force -Path $importsDir | Out-Null

$targetNss = Join-Path $importsDir 'extract-zip.nss'
$snippet = [System.IO.File]::ReadAllText((Join-Path $PSScriptRoot 'extract-zip.nss'), $utf8NoBom)
$snippet = $snippet.Replace('C:\Program Files\7-Zip\7zG.exe', $sevenZip)
[System.IO.File]::WriteAllText($targetNss, $snippet, $utf8NoBom)

$shellNss = Join-Path $ShellDir 'shell.nss'
$mainNss = [System.IO.File]::ReadAllText($shellNss, $utf8NoBom)
$importLine = "import 'imports/extract-zip.nss'"
if ($mainNss -notmatch [regex]::Escape($importLine)) {
	if ($mainNss -match "import\s+'imports/modify\.nss'") {
		$mainNss = $mainNss -replace "(import\s+'imports/modify\.nss')", "`$1`r`n$importLine"
	} else {
		$mainNss = $mainNss.TrimEnd() + "`r`n`r`n$importLine`r`n"
	}
	[System.IO.File]::WriteAllText($shellNss, $mainNss, $utf8NoBom)
}

if (-not $NoRestart) {
	$shellExe = Join-Path $ShellDir 'shell.exe'
	if (Test-Path $shellExe) {
		& $shellExe -restart
	}
}

Write-Host "Kurulum tamamlandı: $targetNss"
