<?php

namespace App\Http\Controllers;

use Illuminate\Http\Request;

class CheckoutController extends Controller
{
    public function checkout(Request $request)
    {

        try{
            $user_id = $request->input('user_id');
            $cart = $request->input('cart'); 
            $response = [
                'user_id' => $user_id,
                'cart' => $cart,
                'message' => 'Checkout successful.',
            ];
            return response()->json($response, 200);
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
