# get the path to the executable of godot using an environment variable
$godotPath = $env:GODOT
$rootDirectory = "." # the main directory where we start searching for project.godot files

# define the directory where to output the compiled *.pck files 
$scriptDirectory = Split-Path -Parent $MyInvocation.MyCommand.Definition

Get-ChildItem -Path $rootDirectory -Recurse -Filter "project.godot" | ForEach-Object {

    $projectPath = $_.FullName
    $projectDirectory = Split-Path $projectPath
    $folderName = Split-Path $projectDirectory -Leaf
    $exportPath = Join-Path $scriptDirectory "$folderName.pck"

    # first create the .godot folder for each project
    & $godotPath --headless --build-solutions --quit --path "$projectDirectory"
    # then bake the projects into .pck files
    & $godotPath --headless --export-pack "Windows Desktop" "$exportPath" --path "$projectDirectory"
}