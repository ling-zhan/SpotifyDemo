#  Spotify Demo
這是一個使用 `Swift` 語言實作的 `Spotify` 音樂播放器，搭配 `Firebase` 作為後端服務的範例專案。

參考自 `Flutter Guys` 的 `YouTube` 影片，此專案將 `Flutter` 改編為 Swift 程式語言。

為不侵權，專案僅提供 App 語法學習之使用，其相關 Firebase 服務設置與音樂檔案，請自行創建與取得。

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
    - 創建 Songs 兩個資料表
    - Songs 資料表
      - title: String
      - artist: String
      - duration: number
      - releaseDate: timestamp
    - 並自行建立音樂資料，如下圖

      ![avatar](/overviewImage/firestore_database_data.png)
    

### 版本要求
  -  Xcode 16 以上
  -  iOS 16 以上

### 授權
MIT

### 參考來源
> 作者：Flutter Guys
> 參考來源：[YouTube 網址](https://www.youtube.com/watch?v=4TFbXepOjLI)
