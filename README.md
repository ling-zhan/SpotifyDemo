#  Spotify Demo
這是一個使用 `Swift` 語言實作的 `Spotify` 音樂播放器，搭配 `Firebase` 作為後端服務的範例專案。

參考自 `Flutter Guys` 的 `YouTube` 影片，此專案將 `Flutter` 改編為 Swift 程式語言。

為不侵權，專案僅提供 App 語法學習之使用，其相關 Firebase 服務設置與音樂檔案，請自行創建與取得。

!! 在專案執行前，須將覆蓋專案內的 `GoogleService-Info.plist` 檔案。

![avatar](/overviewImage/overview.png)

### 實作功能與頁面
  -  導覽
  -  選擇 Dark / Light Mode
  -  註冊 / 登入
  -  首頁
  -  播放音樂
  -  將歌曲加入最愛
  
### Firebase 說明
專案將 Firebase 做為後端服務，使用 Firebase Authentication、Firebase Storage 及 Firestore Database 相關服務。因此，需要先在 Firebase 上建立專案，並且設置相關服務，重點設置如下述所示。
  - 須自行創建一個服務，並覆蓋專案內的 `GoogleService-Info.plist` 檔案
  - Storage 設置
    - 創建 covers 及 songs 資料夾，並分別上傳音樂封面及音樂檔案
  
      ![avatar](/overviewImage/firestore_storage_settings.png)


    - 音樂圖片命名格式 [歌手-歌曲.jpg]，如下圖所示

      ![avatar](/overviewImage/firestore_storage_song_image_format.png)

    - 音樂命名格式 [歌手-歌曲.mp3]，如下圖所示

      ![avatar](/overviewImage/firestore_storage_song_format.png)

    - 將檔案設置可讀，規則設置如下
  
      ```
        service firebase.storage {
          match /b/{bucket}/o {
            match /{allPaths=**} {
              allow read: if true;
              allow write: if false;
            }   
          }
        }
      ```
  - Firestore Database 設置
    - 創建 Songs 資料表
    - Songs 資料表
      - title: String(歌曲)
      - artist: String(歌手)
      - duration: number(歌曲長度)
      - releaseDate: timestamp(發布日期)
    - 並自行建立音樂資料，如下圖

      ![avatar](/overviewImage/firestore_database_data.png)
    
### 變更程式碼內容(對應至 Firebase Storage 歌曲圖片及歌曲檔案的取得網址)

  - 請變更 Common/Shared/AppURL.swift 檔案裡面的 coverFirestorage 與 songFirestorage 變數。對應 firebase storage 圖片及歌曲的連結網址。
    ```
    // firebase 歌曲圖片路徑
    let coverFirestorage: String = "https://firebasestorage.googleapis.com/v0/b/fir-storage-684d1.appspot.com/o/covers%2F"
        
     // firebase 歌曲路徑
    let songFirestorage: String = "https://firebasestorage.googleapis.com/v0/b/fir-storage-684d1.appspot.com/o/songs%2F"
    ```
  - 若要更改 firebase storage 圖片及歌曲的命名格式，請至 Common/Models/SongModel.Swift 修改 getArtistUrl() 及 getSongUrl() 這兩個方法，對應 firebase storage 圖片及歌曲的命名格式
    ```
    /// 組合圖片網址(預設網址連結請參考AppURL.swlft)
    func getArtistUrl() -> URL? {
        let appURL = AppURL.shared
        let urlString = "\(appURL.coverFirestorage)\(artist ?? "")-\(title ?? "").jpg?\(appURL.mediaAlt)"
        return URL(string: urlString)
    }
    
    /// 組合歌曲網址(預設網址連結請參考AppURL.swlft)
    func getSongUrl() -> URL? {
        let appURL = AppURL.shared
        let urlString = "\(appURL.songFirestorage)\(artist ?? "")-\(title ?? "").mp3?\(appURL.mediaAlt)"
        return URL(string: urlString)
    }
    ```

### 版本要求
  -  Xcode 16 以上
  -  iOS 16 以上

### 授權
MIT

### 參考來源
> 作者：Flutter Guys
> 參考來源：[YouTube 網址](https://www.youtube.com/watch?v=4TFbXepOjLI)
