$ErrorActionPreference = 'Stop'
$root = Split-Path -Parent $PSScriptRoot

$required = @(
  'README.md', 'SKILL.md', 'CHANGELOG.md', 'LICENSE',
  'prompts/core.md', 'prompts/writing.md', 'prompts/revision.md',
  'prompts/anti-overfitting.md', 'prompts/format.md',
  'templates/project-bible.md', 'templates/character-card.md',
  'templates/chapter-state.md', 'templates/style-reference.md',
  'schemas/request.yaml'
)

$missing = @($required | Where-Object { -not (Test-Path (Join-Path $root $_)) })
if ($missing.Count -gt 0) { throw "Missing required files: $($missing -join ', ')" }

$skill = Get-Content (Join-Path $root 'SKILL.md') -Raw
foreach ($path in @('prompts/core.md','prompts/writing.md','prompts/revision.md','prompts/anti-overfitting.md')) {
  if ($skill -notmatch [regex]::Escape($path)) { throw "SKILL.md does not route to $path" }
}

$writing = Get-Content (Join-Path $root 'prompts/writing.md') -Raw
$revisionOnlyMarkers = @('### 1.1', '### 2.7', 'dshV4')
if ($revisionOnlyMarkers | Where-Object { $writing.Contains($_) }) {
  throw 'Writing prompt contains revision-only anti-overfitting material.'
}

$antiOverfitting = Get-Content (Join-Path $root 'prompts/anti-overfitting.md') -Raw
$antiOverfittingMarkers = @('v4', '### 1.1', '### 2.7', '### 3.4', 'dshV4')
foreach ($marker in $antiOverfittingMarkers) {
  if ($antiOverfitting -notmatch [regex]::Escape($marker)) {
    throw "Anti-overfitting protocol is missing required marker: $marker"
  }
}

$core = Get-Content (Join-Path $root 'prompts/core.md') -Raw
if (-not $core.Contains('v6.4')) { throw 'Core prompt version is not v6.4.' }

Write-Output "Validation passed: $($required.Count) required files and phase boundaries are valid."