$ErrorActionPreference = 'Stop'
$root = Split-Path -Parent $PSScriptRoot

$required = @(
  'README.md', 'SKILL.md', 'CHANGELOG.md', 'LICENSE',
  'prompts/core.md', 'prompts/writing.md', 'prompts/revision.md',
  'prompts/anti-overfitting.md', 'prompts/format.md',
  'templates/project-bible.md', 'templates/character-card.md',
  'templates/chapter-state.md', 'templates/style-reference.md',
  'schemas/request.yaml',
  'profiles/classic-western-fantasy/PROFILE.md',
  'profiles/classic-western-fantasy/prompts/core.md',
  'profiles/classic-western-fantasy/prompts/writing.md',
  'profiles/classic-western-fantasy/prompts/revision.md',
  'profiles/classic-western-fantasy/prompts/anti-overfitting.md',
  'profiles/classic-western-fantasy/prompts/lexicon.md',
  'profiles/classic-western-fantasy/prompts/format.md'
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

$westernRoot = Join-Path $root 'profiles/classic-western-fantasy'
$westernProfile = Get-Content (Join-Path $westernRoot 'PROFILE.md') -Raw
foreach ($path in @('prompts/core.md','prompts/writing.md','prompts/revision.md','prompts/anti-overfitting.md','prompts/lexicon.md','prompts/format.md')) {
  if ($westernProfile -notmatch [regex]::Escape($path)) {
    throw "Western fantasy profile does not route to $path"
  }
}

$westernWriting = Get-Content (Join-Path $westernRoot 'prompts/writing.md') -Raw
if (-not $westernWriting.Contains('v1')) { throw 'Western fantasy writing prompt version is not v1.' }
if ($westernWriting.Contains('Kimi > Gemini > dshV4') -or $westernWriting.Contains('### 1.1')) {
  throw 'Western fantasy writing prompt contains revision-only material.'
}

$westernAntiOverfitting = Get-Content (Join-Path $westernRoot 'prompts/anti-overfitting.md') -Raw
foreach ($marker in @('v1','1.1','2.10','4.4','7.5')) {
  if (-not $westernAntiOverfitting.Contains($marker)) {
    throw "Western fantasy anti-overfitting protocol is missing marker: $marker"
  }
}

$westernLexicon = Get-Content (Join-Path $westernRoot 'prompts/lexicon.md') -Raw
foreach ($marker in @('v1','1.1','2.3','4.1','5.1','## ')) {
  if (-not $westernLexicon.Contains($marker)) {
    throw "Western fantasy lexicon is missing marker: $marker"
  }
}

if (-not $skill.Contains('profiles/classic-western-fantasy/PROFILE.md')) {
  throw 'SKILL.md does not route to the western fantasy profile.'
}

Write-Output "Validation passed: $($required.Count) required files and phase boundaries are valid."