# 作業ディレクトリを指定
$rootDir = "C:\Users\kenji\Work\Midokura\memo\20240904\archive\fruits-360_dataset_100x100\fruits-360\Train"

# ディレクトリ内のすべてのフォルダを取得
$folders = Get-ChildItem -Path $rootDir -Directory

foreach ($folder in $folders) {
    # フォルダ名をアンダーバーで分割
    $parts = $folder.Name -split '_'
    
    # 最初の部分を果物名として使用17:48 2024/09/03
    $fruitName = $parts[0]
    
    # 新規に作成するフォルダのパス
    $newFolderPath = Join-Path $rootDir $fruitName
    
    # フォルダが存在しない場合は作成
    if (-not (Test-Path -Path $newFolderPath)) {
        New-Item -Path $newFolderPath -ItemType Directory
    }

    # フォルダ内のすべてのファイルを新規フォルダに移動
    $files = Get-ChildItem -Path $folder.FullName -File
    foreach ($file in $files) {
        $destinationPath = Join-Path $newFolderPath $file.Name

        # 移動先に同名ファイルが存在するか確認
        if (Test-Path -Path $destinationPath) {
            # ファイル名と拡張子を分離
            $fileNameWithoutExtension = [System.IO.Path]::GetFileNameWithoutExtension($file.Name)
            $extension = $file.Extension
            
            # 重複を避けるために連番を付ける
            $counter = 1
            do {
                $newFileName = "${fileNameWithoutExtension}_dup${counter}$extension"
                $destinationPath = Join-Path $newFolderPath $newFileName
                $counter++
            } while (Test-Path -Path $destinationPath)
        }

        # ファイルを移動
        Move-Item -Path $file.FullName -Destination $destinationPath
    }

    # 移動元フォルダが空になったら削除
    if (-not (Get-ChildItem -Path $folder.FullName)) {
        Remove-Item -Path $folder.FullName -Force
    }
}
