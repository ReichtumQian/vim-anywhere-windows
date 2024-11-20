
$VimPath = "neovide.exe"

# Step 1: Copy selected content to clipboard
# Assuming the content is already in the clipboard
# If not, you might need to use a tool or method to copy it

# Step 2: Write clipboard content to a temporary file
$TempFile = "$env:LOCALAPPDATA\vim-anywhere"
$ClipboardContent = Get-Clipboard

Set-Content -Path $TempFile -Value $ClipboardContent

# Step 3: Find Neovim executable path

if (-not $VimPath) {
    Write-Error "Neovim executable not found."
    exit 1
}

# Step 4: Start Neovim with the temporary file
Start-Process -Wait -FilePath "$VimPath" -ArgumentList "$TempFile"

# Step 5: After Neovim closes, copy edited content back to clipboard
if (Test-Path -Path "$TempFile") {
    $EditedContent = Get-Content "$TempFile" -Raw
    Set-Clipboard -Value $EditedContent
    Remove-Item -Force -Path "$TempFile"
} else {
    Write-Error "Temporary file not found or failed to create."
}
