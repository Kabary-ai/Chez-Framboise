# unembed-images.ps1
# Inverse de embed-images.ps1 : remplace chaque data:image/... base64 dans index.html
# par une référence externe vers images/<nom>. Garde le HTML léger pour git/GitHub.
# Lancer depuis le dossier "Chez Framboise" : .\unembed-images.ps1

$htmlPath  = Join-Path $PSScriptRoot "index.html"
$imagesDir = Join-Path $PSScriptRoot "images"

$html = Get-Content -Path $htmlPath -Raw -Encoding UTF8
$sizeBefore = (Get-Item $htmlPath).Length

$replaced = 0
Get-ChildItem -Path $imagesDir -File | ForEach-Object {
    $name = $_.Name
    $bytes = [System.IO.File]::ReadAllBytes($_.FullName)
    $b64 = [Convert]::ToBase64String($bytes)

    $ext = $_.Extension.ToLower().TrimStart('.')
    $mime = if ($ext -eq 'jpg' -or $ext -eq 'jpeg') { 'image/jpeg' }
            elseif ($ext -eq 'png')  { 'image/png' }
            elseif ($ext -eq 'webp') { 'image/webp' }
            else                     { "image/$ext" }

    $dataUri  = "data:$mime;base64,$b64"
    # On encode uniquement les espaces (laisse le reste tel quel)
    $encoded  = $name.Replace(' ', '%20')
    $fileRef  = "images/$encoded"

    if ($html.Contains($dataUri)) {
        $html = $html.Replace($dataUri, $fileRef)
        $replaced++
        Write-Host "OK    $name -> $fileRef"
    } else {
        Write-Host "SKIP  $name (pas trouve dans le HTML)"
    }
}

[System.IO.File]::WriteAllText($htmlPath, $html, [System.Text.Encoding]::UTF8)
$sizeAfter = (Get-Item $htmlPath).Length

Write-Host ""
Write-Host "$replaced image(s) restaure(es) en reference externe."
Write-Host "Taille avant : $([math]::Round($sizeBefore/1MB, 2)) Mo"
Write-Host "Taille apres : $([math]::Round($sizeAfter/1KB, 0)) Ko"
