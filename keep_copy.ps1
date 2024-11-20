$VimPath = "neovide.exe"
$TempFile = "$env:LOCALAPPDATA\vim-anywhere"
$ClipboardContent = Get-Clipboard

function Get-ContentWithoutTrailingNewline {
    param (
        [string]$Path
    )
    $content = Get-Content -Path $Path -Raw
    $trimmedContent = $content.TrimEnd("`r", "`n")
    return $trimmedContent
}


Set-Content -Path $TempFile -Value $ClipboardContent

# Step 1: Find Neovim executable path

if (-not $VimPath) {
  Write-Error "Neovim executable not found."
  exit 1
}

# Step 2: Start Neovim with the temporary file
# Start-Process -Wait -FilePath "$VimPath" -ArgumentList "$TempFile"
$process = Start-Process -FilePath "$VimPath" -ArgumentList "$TempFile" -PassThru

$lastWriteTime = (Get-Item -Path $TempFile).LastWriteTime
while (-not $process.HasExited) {
    Start-Sleep -Seconds 1
    $currentWriteTime = (Get-Item -Path $TempFile).LastWriteTime
    if ($currentWriteTime -ne $lastWriteTime) {
        if (Test-Path -Path $TempFile) {
            $EditedContent = Get-ContentWithoutTrailingNewline -Path $TempFile -Raw
            Set-Clipboard -Value $EditedContent
            Write-Host "Clipboard updated with modified content."
            $lastWriteTime = $currentWriteTime
        }
    }
}

# Step 3: After Neovim closes, copy edited content back to clipboard
if (Test-Path -Path "$TempFile") {
    $EditedContent = Get-ContentWithoutTrailingNewline -Path "$TempFile" -Raw
    Set-Clipboard -Value $EditedContent
    Remove-Item -Force -Path "$TempFile"
} else {
    Write-Error "Temporary file not found or failed to create."
}
