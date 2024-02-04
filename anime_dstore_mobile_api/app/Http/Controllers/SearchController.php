<?php

namespace App\Http\Controllers;

use App\Models\Item;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\DB;

class SearchController extends Controller
{
    public function search(Request $request)
    {
        try {
            // get query string from url
            $q = $request->input('q');
            $categories = $request->input('categories');

            $result = Item::where('name', 'ilike', '%' . $q . '%')
                // if categories is not empty, filter by categories
                ->when($categories, function ($query, $categories) {
                    return $query->whereIn('category', $categories);
                })
                ->select('id', 'name', 'category', 'image', 'price', 'description')->get();

            return response()->json([
                "success" => true,
                "message" => "Search successful.",
                "data" => [
                    "items" => $result,
                ]
            ], 200);
        } catch (\Exception $e) {
            $response = [
                'success' => false,
                'error' => $e->getMessage(),
                'message' => 'Search failed.'
            ];

            return response()->json($response, 400);
        }
    }
}
