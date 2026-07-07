param(
    [Parameter(Mandatory = $true)]
    [ValidatePattern('^\d+\.\d+\.\d+$')]
    [string]$Version,

    [Parameter(Mandatory = $true)]
    [string[]]$ChangelogLines,

    [switch]$Publish
)

$ErrorActionPreference = 'Stop'

$repoRoot = Split-Path -Parent $PSScriptRoot
$tocPath = Join-Path $repoRoot 'PACT.toc'
$changelogPath = Join-Path $repoRoot 'CHANGELOG.md'

$toc = Get-Content -LiteralPath $tocPath
$toc = $toc | ForEach-Object {
    if ($_ -match '^## Version:') {
        "## Version: $Version"
    } else {
        $_
    }
}
$utf8NoBom = [System.Text.UTF8Encoding]::new($false)
[System.IO.File]::WriteAllLines($tocPath, $toc, $utf8NoBom)

$changelog = @("## $Version", "")
foreach ($line in $ChangelogLines) {
    $trimmed = $line.Trim()
    if ($trimmed.Length -gt 0) {
        $changelog += "- $trimmed"
    }
}
[System.IO.File]::WriteAllLines($changelogPath, $changelog, $utf8NoBom)

git -C $repoRoot diff --check

if ($Publish) {
    git -C $repoRoot add PACT.toc CHANGELOG.md
    git -C $repoRoot commit -m "Release $Version"
    git -C $repoRoot tag "v$Version"
    git -C $repoRoot push origin main
    git -C $repoRoot push origin "v$Version"
}
