<?php

namespace App\Http\Controllers\Api;

use App\Http\Controllers\Controller;
use App\Models\Resturant_operating_time;
use Illuminate\Http\Request;

class Resturant_operating_timeController extends Controller
{
    /**
     * Display a listing of the resource.
     */
    public function index()
    {
        //
    }

    /**
     * Show the form for creating a new resource.
     */
    public function create()
    {
        //
    }

    /**
     * Store a newly created resource in storage.
     */
    public function store(Request $request)
    {
        //
    }

    /**
     * Display the specified resource.
     */
    public function show($id)
    {
        //
        $opentimes = Resturant_operating_time::where('resturant_id', $id)->get();
        if ($opentimes) {
            return response()->json([
                'status'    => true,
                'message'   => "取得成功",
                'data'      => $opentimes,
            ], 200);
        } else {
            return response()->json([
                'status'    => false,
                'message'   => "更新失敗",
                'data'      => $opentimes,
            ], 200);
            // 找不到 ID 為 1 的 Member 資料
        }
    }

    /**
     * Show the form for editing the specified resource.
     */
    public function edit(Resturant_operating_time $resturant_operating_time)
    {
        //
    }

    /**
     * Update the specified resource in storage.
     */
    public function update(Request $request, Resturant_operating_time $resturant_operating_time)
    {
        //
    }

    /**
     * Remove the specified resource from storage.
     */
    public function destroy(Resturant_operating_time $resturant_operating_time)
    {
        //
    }
}
