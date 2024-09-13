# 作業ディレクトリを指定
$folderPath = "C:\Users\kenji\Work\Midokura\memo\20240904\archive\fruits-360_dataset_100x100\fruits-360\Train"
$changeCount = 0

# フォルダ内のすべてのフォルダを取得
Get-ChildItem -Path $folderPath -Recurse -Directory | ForEach-Object {
    $newName = $_.Name -replace ' ', '_'
    $newPath = Join-Path $_.Parent.FullName $newName
    if ($_.FullName -ne $newPath) {
        Rename-Item -Path $_.FullName -NewName $newName
        $changeCount++
    }
}

# 変更したフォルダの数を出力
Write-Host "number of the folder changed: $changeCount"

# ユーザーからの入力を待機して、ウィンドウを維持
Write-Host "press any key to finish"
$null = $Host.UI.RawUI.ReadKey("NoEcho,IncludeKeyDown")
