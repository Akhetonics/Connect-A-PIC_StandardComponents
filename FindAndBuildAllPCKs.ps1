# Verwenden der Umgebungsvariablen für den Pfad zum Godot-Executable
$godotExecutable = $env:GODOT
$rootDirectory = "." # Stammverzeichnis für die Suche

# Pfad zum Verzeichnis des PowerShell-Skripts
$scriptDirectory = Split-Path -Parent $MyInvocation.MyCommand.Definition

Get-ChildItem -Path $rootDirectory -Recurse -Filter "project.godot" | ForEach-Object {

    # create the .godot folder
    $godotArgs = "--headless", "--build-solutions", "--quit || exit 0"
    $godotProcess = Start-Process -FilePath $godotPath -ArgumentList $godotArgs -PassThru
    $godotProcess.WaitForExit()

    $projectPath = $_.FullName
    $projectDirectory = Split-Path $projectPath
    $folderName = Split-Path $projectDirectory -Leaf
    $exportPath = Join-Path $scriptDirectory "$folderName.pck"

    & $godotExecutable --headless --export-pack "Windows Desktop" "$exportPath" --path "$projectDirectory"
}