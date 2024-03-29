<?php

use Illuminate\Http\Request;
use Illuminate\Support\Facades\Route;
use App\Http\Controllers\UserController;
use App\Http\Controllers\SearchController;
use App\Http\Controllers\CheckOutController;
use App\Http\Controllers\LoginController;
use App\Http\Controllers\RegisterController;
/*
|--------------------------------------------------------------------------
| API Routes
|--------------------------------------------------------------------------
|
| Here is where you can register API routes for your application. These
| routes are loaded by the RouteServiceProvider and all of them will
| be assigned to the "api" middleware group. Make something great!
|
*/

Route::middleware('auth:sanctum')->get('/user', function (Request $request) {
    return $request->user();
});

Route::post('/user/changePassword', [UserController::class, 'changePassword']);
Route::post('/user/clearPurchaseHistory', [UserController::class, 'clearHistory']);
Route::get('/user/purchaseHistory', [UserController::class, 'getHistory']);

Route::any('/register', [RegisterController::class, 'storeInformation']);
Route::any('/login', [LoginController::class, 'login']);
Route::get('/items', [SearchController::class, 'search']);
Route::post('/checkout', [CheckOutController::class, 'checkOut']);
