[CmdletBinding()]
param()

$ErrorActionPreference = 'Stop'
$root = Split-Path -Parent $PSScriptRoot
$utf8 = [System.Text.UTF8Encoding]::new($false, $true)
$failures = [System.Collections.Generic.List[string]]::new()

function Add-Failure([string]$Message) {
    $script:failures.Add($Message)
}

function Read-Utf8([string]$RelativePath) {
    $path = Join-Path $root $RelativePath
    if (-not (Test-Path -LiteralPath $path)) {
        Add-Failure "Missing file: $RelativePath"
        return ''
    }

    try {
        return [System.IO.File]::ReadAllText($path, $utf8)
    }
    catch {
        Add-Failure "Invalid UTF-8: $RelativePath"
        return ''
    }
}

function Require-Text([string]$Text, [string]$Needle, [string]$Source) {
    if (-not $Text.Contains($Needle)) {
        Add-Failure "Missing required text in ${Source}: $Needle"
    }
}

function Convert-CodePointsToText([int[]]$CodePoints) {
    return -join ($CodePoints | ForEach-Object { [char]$_ })
}

function Test-LocalMarkdownLinks([string]$RelativePath, [string]$Text) {
    $matches = [regex]::Matches($Text, '\[[^\]]+\]\(([^)]+)\)')
    foreach ($match in $matches) {
        $target = $match.Groups[1].Value.Trim('<>')
        if ($target -match '^(https?:|mailto:|#)') {
            continue
        }

        $pathPart = $target.Split('#')[0]
        if ([string]::IsNullOrWhiteSpace($pathPart)) {
            continue
        }

        $baseDirectory = Split-Path -Parent (Join-Path $root $RelativePath)
        $resolved = Join-Path $baseDirectory $pathPart
        if (-not (Test-Path -LiteralPath $resolved)) {
            Add-Failure "Broken local Markdown link in ${RelativePath}: $target"
        }
    }
}

$skill = Read-Utf8 'SKILL.md'
$spec = Read-Utf8 'references/ai-coding-execution-spec-v1.md'
$readme = Read-Utf8 'README.md'
$readmeZh = Read-Utf8 'README.zh-CN.md'
$contracts = Read-Utf8 'evals/behavior-contracts.md'
$editorConfig = Read-Utf8 '.editorconfig'
$agentManifest = Read-Utf8 'agents/openai.yaml'
$workflow = Read-Utf8 '.github/workflows/validate.yml'
$manualEvaluation = Read-Utf8 'evals/manual-evaluation.md'

$summaryLabels = @(
    (Convert-CodePointsToText 0x3010, 0x76EE, 0x6807, 0x3011),
    (Convert-CodePointsToText 0x3010, 0x6539, 0x52A8, 0x6587, 0x4EF6, 0x3011),
    (Convert-CodePointsToText 0x3010, 0x81EA, 0x6D4B, 0x7ED3, 0x679C, 0x3011),
    (Convert-CodePointsToText 0x3010, 0x98CE, 0x9669, 0x3011),
    (Convert-CodePointsToText 0x3010, 0x5FC5, 0x987B, 0x9A8C, 0x6536, 0x3011),
    (Convert-CodePointsToText 0x3010, 0x7ED3, 0x8BBA, 0x3011)
)

Require-Text $skill 'name: ai-coding-collaboration' 'SKILL.md'
Require-Text $skill '## Risk Modifiers' 'SKILL.md'
Require-Text $skill '## Ambiguity Gate' 'SKILL.md'
Require-Text $skill '## Validation Evidence' 'SKILL.md'
Require-Text $skill '## OpenSpec Cooperation' 'SKILL.md'
Require-Text $spec 'normative source' 'references/ai-coding-execution-spec-v1.md'
Require-Text $spec 'Risk and ambiguity modifiers' 'references/ai-coding-execution-spec-v1.md'
Require-Text $readme '$ai-coding-collaboration' 'README.md'
Require-Text $readmeZh '$ai-coding-collaboration' 'README.zh-CN.md'
Require-Text $editorConfig 'charset = utf-8' '.editorconfig'
Require-Text $agentManifest '$ai-coding-collaboration' 'agents/openai.yaml'
Require-Text $agentManifest 'apply risk modifiers' 'agents/openai.yaml'
Require-Text $workflow 'scripts/test-skill.ps1' '.github/workflows/validate.yml'
Require-Text $readme 'pwsh -NoProfile -File scripts/test-skill.ps1' 'README.md'
Require-Text $readmeZh 'pwsh -NoProfile -File scripts/test-skill.ps1' 'README.zh-CN.md'
Require-Text $readme 'manual-evaluation.md' 'README.md'
Require-Text $readmeZh 'manual-evaluation.md' 'README.zh-CN.md'
Require-Text $manualEvaluation 'all eight cases pass' 'evals/manual-evaluation.md'

foreach ($summaryDocument in @(
    'SKILL.md',
    'README.md',
    'README.zh-CN.md',
    'references/ai-coding-execution-spec-v1.md',
    'docs/examples.md',
    'examples/l0-micro-task.md',
    'examples/l1-small-feature.md',
    'examples/l2-module-task.md',
    'examples/review-example.md',
    'prompts/bugfix.md',
    'prompts/coding.md',
    'prompts/release.md',
    'prompts/review.md',
    'agents/openai.yaml'
)) {
    $content = Read-Utf8 $summaryDocument
    foreach ($label in $summaryLabels) {
        Require-Text $content $label $summaryDocument
    }
}

$caseCount = [regex]::Matches($contracts, '(?m)^## Case \d+:').Count
if ($caseCount -ne 8) {
    Add-Failure "Behavior contracts must define exactly 8 cases; found $caseCount"
}

foreach ($contractMarker in @(
    'L0 stays light',
    'L1 includes impact analysis',
    'L2 has a short plan',
    'High-risk small diff is upgraded',
    'Ambiguity is resolved selectively',
    'Contract changes check consumers',
    'P0 evidence gates completion',
    'Review output remains actionable',
    'Do not create a full plan',
    'at least L2',
    'one focused question',
    'do not report merge-ready',
    'maximum three'
)) {
    Require-Text $contracts $contractMarker 'evals/behavior-contracts.md'
}

foreach ($prompt in @('prompts/bugfix.md', 'prompts/coding.md', 'prompts/release.md', 'prompts/review.md')) {
    $content = Read-Utf8 $prompt
    Require-Text $content '$ai-coding-collaboration' $prompt
}

$markdownFiles = Get-ChildItem -Path $root -Recurse -File -Filter '*.md' | Where-Object {
    $_.FullName -notmatch '[\\/]\.git[\\/]'
}
foreach ($file in $markdownFiles) {
    $relative = $file.FullName.Substring($root.Length).TrimStart([char[]]'\\/')
    $content = Read-Utf8 $relative
    Test-LocalMarkdownLinks $relative $content
}

if ($failures.Count -gt 0) {
    $failures | ForEach-Object { Write-Error $_ }
    exit 1
}

Write-Host "Static skill checks passed: UTF-8, rule contracts, naming, links, summary templates, and behavior-contract coverage."
