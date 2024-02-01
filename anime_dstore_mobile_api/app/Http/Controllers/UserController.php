<?php

namespace App\Http\Controllers;

use Illuminate\Http\Request;
use Illuminate\Support\Facades\Hash;
use Illuminate\Support\Facades\DB;

class UserController extends Controller
{
    public function changePassword(Request $request)
    {
        // Validation
        $request->validate([
            'user_id' => 'required|integer',
            'new_password' => 'required|string|min:8',
        ]);

        // Check if user exists
        $user = DB::table('user')->where('id', $request->user_id)->first();

        if (!$user) {
            return response()->json(['error' => 'User not found'], 404);
        }

        // Change the password
        DB::table('user')
            ->where('id', $request->user_id)
            ->update(['pasword' => Hash::make($request->new_password)]);

        // Return a JSON response with the success status
        return response()->json(['success' => true]);
    }

    public function clearHistory(Request $request)
    {
        // Validation
        $request->validate([
            'user_id' => 'required|integer',
        ]);

        // Check if user exists
        $user = DB::table('user')->where('id', $request->user_id)->first();

        if (!$user) {
            return response()->json(['error' => 'User not found'], 404);
        }

        // Clear the history
        DB::table('history')->where('user_id', $request->user_id)->delete();

        // Return a JSON response with the success status
        return response()->json(['success' => true]);
    }

    public function getHistory(Request $request)
    {
        // Validation
        $request->validate([
            'user_id' => 'required|integer',
        ]);

        // Check if user exists
        $user = DB::table('user')->where('id', $request->user_id)->first();

        if (!$user) {
            return response()->json(['error' => 'User not found'], 404);
        }

        // Get the history
        $history = DB::table('history')
            ->join('item', 'history.item_id', '=', 'item.id')
            ->where('history.user_id', $request->user_id)
            ->select('history.id', 'item.name', 'item.category', 'item.image', 'item.price', 'history.quantity')
            ->get();

        // Return the history as a JSON response
        return response()->json($history);
    }
}