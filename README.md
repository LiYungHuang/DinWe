### DinWe
應用Laravel與React之全端作品
- 主題：餐廳訂位網站
- 負責項目：商家會員系統

步驟：  
【React】
1. cd dinwe\React
2. 下載 npm
    ```
    npm install
    npm start
    ```  
  
【Laravel + MySQL】
1. cd dinwe\Laravel
2. 安裝 composer
    ```
    composer install
    ```
3. 複製.env.example，修改.env copy.example檔名為 .env
4. 產生金鑰
    ```
    php artisan key:generate
    ```
5. 匯入 MySQL  
   
    **法一、**  
    
    (1) cd dinwe\MySQL  
    (2) 匯入 dinwe.sql 資料庫  
    (3) 建立personal_access_tokens  
        ```
        php artisan migrate
        ``` 
    
    **法二、**  
    
    (1) 匯入資料庫  
        (詢問是否建立資料庫=>'dinwe' is not exist => yes)  
        ```
        php artisan migrate
        ```  
    (2) cd dinwe\MySQL  
    (3) 執行changeImageType.sql，修改Image型態 (Laravel不支援mediumblob，原先預設為blob)  
    (4) 匯入dinwe.sql 資料庫  
    
6. 匯入 MySQL StoredProcedure  
    (1) cd dinwe\MySQL\StoredProcedure  
    (2) 點開All.sql檔案，Ctrl+A 全選、Ctrl+C複製程序  
    (3) 貼上資料庫執行 SQL  
    
7. 執行Laravel 
    ```
    php artisan serve
    ```

