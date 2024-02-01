<?php

namespace App\Http\Controllers;

use Exception;
use App\Models\Item;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\Hash;
use Illuminate\Support\Facades\Redis;

class CheckOutController extends Controller
{
    public function checkOut(Request $request){
            $data = $request->validate([
            'address' => 'required',
            'phone' => 'required',
            ]);
        try {
            $user = Item::create([
                'address' => $data['address'],
                'phone' => Hash::make($data['phone'])
            ]);

            $response = [
                'success' => true,
                'message' => 'Checkout successfully.'
            ];
        }
        catch (\Exception $e) {
            $response = [
                'success' => false,
                'error' => $e->getMessage(),
                'message' => 'Checkout failed.'
            ];
        }
        return response()->json($response);
    }
}