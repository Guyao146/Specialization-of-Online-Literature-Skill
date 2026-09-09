$ErrorActionPreference = 'Stop'
$root = Split-Path -Parent $PSScriptRoot

$required = @(
  'README.md', 'SKILL.md', 'CHANGELOG.md', 'LICENSE',
  'prompts/core.md', 'prompts/writing.md', 'prompts/revision.md',
  'prompts/anti-overfitting.md', 'prompts/format.md',
  'templates/project-bible.md', 'templates/character-card.md',
  'templates/chapter-state.md', 'schemas/request.yaml'
)

$missing = @($required | Where-Object { -not (Test-Path (Join-Path $root $_)) })
if ($missing.Count -gt 0) { throw "Missing required files: $($missing -join ', ')" }

$skill = Get-Content (Join-Path $root 'SKILL.md') -Raw
foreach ($path in @('prompts/core.md','prompts/writing.md','prompts/revision.md','prompts/anti-overfitting.md')) {
  if ($skill -notmatch [regex]::Escape($path)) { throw "SKILL.md does not route to $path" }
}

$writing = Get-Content (Join-Path $root 'prompts/writing.md') -Raw
if ($writing -match '红名单|速删表|行为级 AI 腔|行为级AI腔|瞳孔地震') {
  throw 'Writing prompt contains revision-only anti-overfitting material.'
}

Write-Output "Validation passed: $($required.Count) required files and phase boundaries are valid."