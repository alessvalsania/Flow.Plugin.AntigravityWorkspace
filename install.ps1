$ErrorActionPreference = "Stop"

# Configuration
$pluginName = "Flow.Plugin.AntigravityWorkspace"
$flowLauncherPluginsDir = "$env:APPDATA\FlowLauncher\Plugins"
$targetDir = Join-Path $flowLauncherPluginsDir $pluginName
$buildOutputDir = "Output\Release\VSCodeWorkspaces"

Write-Host "Building project..."
dotnet build -c Release

if (-not (Test-Path $buildOutputDir)) {
    Write-Error "Build failed or output directory '$buildOutputDir' not found."
}

Write-Host "Installing to $targetDir..."

# Create target directory if it doesn't exist
if (-not (Test-Path $targetDir)) {
    New-Item -ItemType Directory -Force -Path $targetDir
}

# Copy files
Copy-Item "$buildOutputDir\*" -Destination $targetDir -Recurse -Force

Write-Host "Installation complete."
Write-Host "Please restart Flow Launcher to apply changes."
