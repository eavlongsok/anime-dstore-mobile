<?php

namespace App\Http\Controllers;

use App\Models\Item;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\DB;

class SearchController extends Controller
{
    public function search($keyword){
        try{
            $item = DB::table('item')->get();
            $results = Item::where('name', 'ilike', '%' . $keyword . '%')->select('id', 'name', 'category', 'image', 'price', 'description')->get(); 

            return response()->json([
                $item,
                $results
            ], 200);
    } 
    catch (\Exception $e) {
        $response = [
            'success' => false,
            'error' => $e->getMessage(),
            'message' => 'Search failed.'
        ];

        return response()->json($response, 400); 
    }
    }
}
