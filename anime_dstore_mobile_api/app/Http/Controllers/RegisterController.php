<?php

namespace App\Http\Controllers;

use App\Models\User;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\Hash;

class RegisterController extends Controller
{
    public function storeInformation(Request $request)
    {
        $data = $request->validate([
            'email' => 'required',
            'password' => 'required',
        ]);

        try {
            $user = User::create([
                'email' => $data['email'],
                'password' => $data['password']
            ]);

            $response = [
                'success' => true,
                'message' => 'User created successfully.'
            ];
            
            return response()->json($response, 200); 
        } catch (\Exception $e) {
            $response = [
                'success' => false,
                'error' => $e->getMessage(),
                'message' => 'User creation failed.'
            ];

            return response()->json($response, 400); 
        }
    }
}
