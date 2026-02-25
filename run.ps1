param (
    [string]$file
)


function PlayRandomSound($folderPath) {

    $sounds = Get-ChildItem $folderPath -Filter *.wav

    if ($sounds.Count -eq 0) {
        Write-Host "No sounds found in $folderPath"
        return
    }

    $randomSound = Get-Random $sounds

    $player = New-Object System.Media.SoundPlayer $randomSound.FullName
    $player.PlaySync()
}

$extension = [System.IO.Path]::GetExtension($file)

if ($extension -eq ".cpp") {

    Write-Host "Compiling C++..."
    g++ $file -o program.exe

    if ($LASTEXITCODE -ne 0) {
        Write-Host "Compilation failed."
        PlayRandomSound ".\sounds\error"
        exit 1
    }

    Write-Host "Running program..."
    Write-Host "`n"
    .\program.exe
}
elseif ($extension -eq ".py") {

    Write-Host "Running Python..."
    Write-Host "`n"
    python $file
}
else {
    Write-Host "Unsupported file type."
    Write-Host "`n"
    exit 1
}

if ($LASTEXITCODE -ne 0) {
    Write-Host "Execution failed."
    Write-Host "`n"
    PlayRandomSound ".\sounds\error"
}
else {
    Write-Host "`n"
    Write-Host "Execution successful."
    PlayRandomSound ".\sounds\success"
}