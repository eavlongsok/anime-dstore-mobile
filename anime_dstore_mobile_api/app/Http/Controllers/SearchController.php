<?php

namespace App\Http\Controllers;

use App\Models\Item;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\DB;

class SearchController extends Controller
{
    public function search(Request $request){
        try{
            // $item = DB::table('item')->get();
            // $results = Item::where('name', 'ilike', '%' . $keyword . '%')->select('id', 'name', 'category', 'image', 'price', 'description')->get();

            // get query string from url
            $q = $request->input('q');
            $result = Item::where('name', 'ilike', '%' . $q . '%')->select('id', 'name', 'category', 'image', 'price', 'description')->get();

            return response()->json([
                "success" => true,
                "message" => "Search successful.",
                "data" => [
                    "items" => $result,
                ]
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
