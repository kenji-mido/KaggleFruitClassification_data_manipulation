# 親ディレクトリを指定
$rootDir = "C:\Users\kenji\Work\Midokura\memo\20240904\archive\fruits-360_dataset_100x100\fruits-360\Train"

# 親ディレクトリ内のすべての子フォルダを取得
$folders = Get-ChildItem -Path $rootDir -Directory

foreach ($folder in $folders) {
    Write-Host "Processing folder: $($folder.FullName)"
    
    # 子フォルダ内のすべてのファイルを取得
    $files = Get-ChildItem -Path $folder.FullName -File

    Write-Host "Found $($files.Count) files in $($folder.Name)"

    # ファイルが50個以上ある場合
    if ($files.Count -gt 50) {
        # 50ファイルを無作為に選択
        $selectedFiles = $files | Get-Random -Count 50

        Write-Host "Selected files:"
        foreach ($selectedFile in $selectedFiles) {
            Write-Host "  $($selectedFile.FullName)"
        }

        Write-Host "Selected 50 files, deleting the rest..."

        # 無作為に選択されなかったファイルを削除
        foreach ($file in $files) {
            if ($selectedFiles -notcontains $file) {
                Write-Host "Deleting file: $($file.FullName)"
                Remove-Item -Path $file.FullName -Force
            }
        }
    } else {
        Write-Host "Folder $($folder.Name) has 50 or fewer files, skipping deletion."
    }
}
