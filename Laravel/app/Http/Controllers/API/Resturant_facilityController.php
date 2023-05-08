<?php

namespace App\Http\Controllers\api;

use App\Http\Controllers\Controller;
use App\Models\Resturant_facility;
use Illuminate\Http\Request;

class Resturant_facilityController extends Controller
{
    //
    // public function show($id)
    // {
    //     $result = Resturant_facility::where('resturant_id', $id)->first()->get();

    //     $array = is_object($result[0]);
    //     $array = json_decode($result, true);
    //     $array = $array[0];
    //     // $array = array_keys($array,1); //轉值為1的轉換成字串陣列
    //     // is_array($array[0]);

    //     global $info;
    //     $info = array( "現金支付", "Visa", "信用卡", "街口支付", "悠遊付", "LINE Pay", "Apple Pay", "Google Pay", "台灣 Pay", "供應酒精飲料", "免費無線網路", "座充插座", "禁菸餐廳", "兒童座椅", "兒童餐具", "哺乳室", "尿布台", "免費嬰兒車租借", "國民旅遊卡", "專車接送", "汽車專區", "機車專區", "停車場折抵優惠", "場地租借", "無障礙設施", "玩具區", "溜滑梯", "球池", "沙坑", "農場", "草地", "動物", "魚池", "生態池", "戲水池", "家家酒", "電玩設施", "兒童書區", "課程體驗", "滿月活動", "收涎活動", "抓週活動", "性別派對", "慶生派對", "素食", "純素食", "清真菜", "無麩質");
    //     // $result = [];
    //     $result2 = [];
    //     $i = 0;

    //     foreach ($array as $facility => $value) {
    //         // 檢查值是否為 1，若是則將設施名稱存儲到陣列中
    //         if ($value == 1) {
    //             // $result[$i] = $facility;
    //             $result2[$facility] = $i;
    //         }
    //         $i++;
    //     };

    //     $result3 = [];

    //     global $pay;
    //     global $facility;
    //     global $child;
    //     global $food;
    //     $pay = [];
    //     $facility = [];
    //     $child = [];
    //     $food = [];
    //     foreach ($result2 as $item => $value) {
    //         if ($value <= 8) {
    //             if($value === "resturant_id"){ continue;}
    //             if($value === "id"){ continue;}
    //             array_push($pay,$info[$value]);
    //         } elseif ($value <= 24) {
    //             array_push($facility,$info[$value]);
    //         } elseif ($value <= 43) {
    //             array_push($child,$info[$value]);
    //         } else {
    //             array_push($food,$info[$value]);
    //         }
    //     };
    //     $result3['pay'] = $pay;
    //     $result3['facility'] = $facility;
    //     $result3['child'] = $child;
    //     $result3['food'] = $food;


    //     // return json_encode($result3);

    //     return response()->json([
    //         'status'    => true,
    //         'message'   => 'success',
    //         'data'      => $result3,
    //         'result2'   => $result2
    //     ], 200);
    // }

    public function show($id){

        $response = [];
    // foreach ($resturants as $resturant) 
    // {
      $resturantFacility = Resturant_facility::where('resturant_id', $id)->first();
      $child = [];
      $facility = [];
      $food = [];
      $pay = [];
      $childNames = [
      'toy' => '玩具區',
      'slide' => '溜滑梯',
      'ballpit' => '球池',
      'sandpit' => '沙坑',
      'farm' => '農場',
      'lawn' => '草地',
      'animal' => '動物',
      'fishpond' => '魚池',
      'ecopond' => '生態池',
      'paddingpool' => '戲水池',
      'home' => '家家酒',
      'videogame' => '電玩設施',
      'childrenbook' => '兒童書區',
      'course' => '課程體驗',
      'fullmoon' => '滿月活動',
      'saliva' => '收涎活動',
      'oneyear' => '抓周活動',
      'sexparty' => '性別派對',
      'birthday' => '慶生派對'
      ];
      $facilityNames = [
      'alcohol' => '供應酒精飲品',
      'wifi' => '免費無線網路',
      'socket' => '座充插座',
      'smoking' => '禁菸餐廳',
      'childseat' => '兒童座椅',
      'childware' => '兒童餐具',
      'nursingroom' => '哺乳室',
      'diaper' => '尿布台',
      'stroller' => '免費嬰兒車租借',
      'touristcard' => '國民旅遊卡',
      'shuttle' => '專車接送',
      'car' => '汽車專區',
      'scotter' => '機車專區',
      'parkdiscount' => '停車場折抵優惠',
      'venuerental' => '場地租借',
      'barrierfree' => '無障礙設施'
      ];
      $payNames = [
      'cash' => '現金支付',
      'visa' => 'Visa',
      'creditcard' => '信用卡',
      'streetpay' => '街口支付',
      'easycard' => '悠遊卡',
      'linepay' => 'LINE Pay',
      'applepay' => 'Apple Pay',
      'googlepay' => 'Google Pay',
      'taiwanpay' => '台灣 Pay'
      ];
      $foodNames = [
      'vegetarian' => '素食',
      'vegan' => '純素食',
      'muslin' => '清真菜',
      'glutenfree' => '無麩質',
      ];

    //   if (!$resturantFacility) {
    //     continue;
    //   }
      
      foreach ($childNames as $key => $value) {
        if ($resturantFacility->$key == 1) {
          $child[] = $value;
        }
      }
      foreach ($facilityNames as $key => $value) {
        if ($resturantFacility->$key == 1) {
          $facility[] = $value;
        }
      }
      foreach ($payNames as $key => $value) {
        if ($resturantFacility->$key == 1) {
          $pay[] = $value;
        }
      }
      foreach ($foodNames as $key => $value) {
        if ($resturantFacility->$key == 1) {
          $food[] = $value;
        }
      }



      $response[] = [
        'child' => $child,
        'facility' => $facility,
        'food' => $food,
        'pay' => $pay,
      
      ];
    // }
      return response()->json($response);
    }


}
