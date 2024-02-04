<?php

namespace App\Http\Controllers;

use App\Models\User;
use App\Models\History;
use App\Models\CartItem;
use Illuminate\Http\Request;

class CheckoutController extends Controller
{
    public function checkout(Request $request)
    {
        try {
            // Validate the request data
            // $request->validate([
            //     'user_id' => 'required|exists:users,id',
            //     'cart' => 'required|array',
            //     'cart.*.item_id' => 'required|exists:items,id',
            //     'cart.*.quantity' => 'required|integer|min:1',
            // ]);
            $user_id = $request->input('user_id');
            $carts = $request->input('carts');

            foreach ($carts as $item) {
                History::create([
                    'user_id' => $user_id,
                    'item_id' => $item['item_id'],
                    'quantity' => $item['quantity'],
                ]);
            }

            $response = [
                'user_id' => $user_id,
                'carts' => $carts,
                'message' => 'Checkout successful.',
            ];

            return response()->json($response, 200);
        } catch (\Exception $e) {
            $response = [
                'success' => false,
                'error' => $e->getMessage(),
                'message' => 'Checkout failed.',
            ];

            return response()->json($response, 400);
        }
    }
}
