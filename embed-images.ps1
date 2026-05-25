# embed-images.ps1
# Lit index.html, remplace chaque src="images/..." par un data URI base64, écrit index.html
# Lancer depuis le dossier "Chez Framboise" : .\embed-images.ps1

$htmlPath  = Join-Path $PSScriptRoot "index.html"
$imagesDir = Join-Path $PSScriptRoot "images"

$html = Get-Content -Path $htmlPath -Raw -Encoding UTF8

# Trouve toutes les valeurs src qui pointent vers images/ (avec ou sans %20)
$pattern = 'src="(images/[^"]+)"'
$matches_ = [regex]::Matches($html, $pattern)

$replaced = 0
foreach ($m in $matches_) {
    $srcAttr    = $m.Groups[1].Value                      # ex: images/chambre%201.jpg
    $decoded    = [Uri]::UnescapeDataString($srcAttr)     # ex: images/chambre 1.jpg
    $filePath   = Join-Path $PSScriptRoot $decoded

    if (Test-Path $filePath) {
        $ext      = [System.IO.Path]::GetExtension($filePath).ToLower().TrimStart('.')
        $mime     = if ($ext -eq 'jpg' -or $ext -eq 'jpeg') { 'image/jpeg' }
                    elseif ($ext -eq 'png')  { 'image/png'  }
                    elseif ($ext -eq 'webp') { 'image/webp' }
                    else                     { "image/$ext"  }

        $bytes    = [System.IO.File]::ReadAllBytes($filePath)
        $b64      = [Convert]::ToBase64String($bytes)
        $dataUri  = "data:$mime;base64,$b64"

        $html     = $html.Replace("`"$srcAttr`"", "`"$dataUri`"")
        $replaced++
        Write-Host "OK  $srcAttr ($([math]::Round($bytes.Length/1KB)) Ko)"
    } else {
        Write-Host "INTROUVABLE  $filePath"
    }
}

[System.IO.File]::WriteAllText($htmlPath, $html, [System.Text.Encoding]::UTF8)
Write-Host ""
Write-Host "$replaced image(s) embarquée(s). Fichier mis à jour : $htmlPath"
