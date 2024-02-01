<?php

namespace App\Http\Controllers;

use App\Models\User;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\Hash;

class RegisterController extends Controller
{
    public function storeInformation(Request $request){
        $data  = $request->validate([
            'email' => 'required',
            'password' => 'required',
        ]);
        try {
            $user = User::create([
                'email' => $data['email'],
                'password' => Hash::make($data['password'])
            ]);
    
            $response = [
                'success' => true,
                'data' => $user, // You can include additional data if needed
                'message' => 'User created successfully.'
            ];
        }
        catch (\Exception $e) {
            $response = [
                'success' => false,
                'error' => $e->getMessage(),
                'message' => 'User creation failed.'
            ];
        }
    
        return response()->json($response);
    }
}
