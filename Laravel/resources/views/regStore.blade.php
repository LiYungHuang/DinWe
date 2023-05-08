<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <meta http-equiv="X-UA-Compatible" content="ie=edge">
    <title>審核成功</title>
</head>
<body>
    <h1 style="text-align: center">審核通過</h1>
    <h2 style="text-align: center">歡迎加入 DinWe!!</h2>
    <p style="text-align: center">店家: {{ $mailData['resturant_name'] }}</p>
    <p style="text-align: center"><a href={{ $mailData['url'] }}>開通網址: {{ $mailData['url'] }}</p>
</body>
</html>