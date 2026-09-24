# Sets up content\.obsidian from obsidian-defaults\ once. Safe to re-run: files that already
# exist are never overwritten, so your own settings stay; missing plugins get added and enabled.
$ErrorActionPreference = "Stop"
$source = Join-Path $PSScriptRoot "obsidian-defaults"
$target = Join-Path $PSScriptRoot "content\.obsidian"

Get-ChildItem $source -Recurse -File | ForEach-Object {
    $relative = $_.FullName.Substring($source.Length + 1)
    $destination = Join-Path $target $relative
    if (-not (Test-Path $destination)) {
        New-Item -ItemType Directory -Force (Split-Path $destination) | Out-Null
        Copy-Item $_.FullName $destination
        Write-Host "added   $relative"
    }
}

# An existing community-plugins.json isn't overwritten above, so enable any default plugin missing from it.
$enabledFile = Join-Path $target "community-plugins.json"
# Windows PowerShell's ConvertFrom-Json returns a JSON array as one object; the parentheses
# force it to be enumerated into its items.
$enabled = @((Get-Content $enabledFile -Raw | ConvertFrom-Json) | ForEach-Object { $_ })
$defaults = @((Get-Content (Join-Path $source "community-plugins.json") -Raw | ConvertFrom-Json) | ForEach-Object { $_ })
$missing = $defaults | Where-Object { $enabled -notcontains $_ }
if ($missing) {
    $json = ConvertTo-Json -InputObject @($enabled + $missing)
    # Windows PowerShell's "utf8" writes a byte-order mark; write plain UTF-8 instead.
    [IO.File]::WriteAllText($enabledFile, $json, (New-Object Text.UTF8Encoding $false))
    Write-Host "enabled $($missing -join ', ')"
}
Write-Host "Done. Open the 'content' folder as a vault in Obsidian."
