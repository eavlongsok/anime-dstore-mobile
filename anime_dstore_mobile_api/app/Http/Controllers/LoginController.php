<?php

namespace App\Http\Controllers;

use Illuminate\Http\Request;
use App\Models\User;

class LoginController extends Controller
{
    public function login(Request $request)
    {
        $data = $request->validate([
            'email' => 'required|email',
            'password' => 'required',
        ]);

        $user = User::where('email', $data['email'])->first();

        if ($user && $user->password === $data['password']) {
            return response()->json([
                'success' => true,
                'data' => [
                    'user' => $user,
                ],
                'message' => 'Login successful.',
            ], 200);
        }

        return response()->json([
            'success' => false,
            'message' => 'Invalid credentials.',
        ], 400);
    }
}
