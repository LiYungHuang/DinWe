# DinWe
● 應用Laravel與React之全端作品
● 主題：餐廳訂位網站
● 負責項目：商家會員系統
● 步驟：
  【React】
    1. cd dinwe\React
    2. npm install
    3. npm start
    
  【Laravel + MySQL】
    1. cd dinwe\Laravel
    2. composer install
    3. 複製.env.example
    4. 修改.env copy.example檔名為 .env
    5. php artisan key：generate
    6. 匯入 MySQL
       法一、
       ● cd dinwe\MySQL
       ● 匯入 dinwe.sql 資料庫
       ● php artisan migrate (建立personal_access_tokens)
       ----
       法二、
       ● php artisan migrate
        (詢問是否建立資料庫=>'dinwe' is not exist => yes)
       ● cd dinwe\MySQL
         執行changeImageType.sql，修改Image型態 (Laravel不支援mediumblob，原先預設為blob)
       ● 匯入 dinwe.sql 資料庫
    7. 匯入 MySQL StoredProcedure
       ● cd dinwe\MySQL\StoredProcedure
       ● 點開All.sql檔案，Ctrl+A 全選、Ctrl+C複製程序
       ● 貼上資料庫執行 SQL
    8. php artisan serve
