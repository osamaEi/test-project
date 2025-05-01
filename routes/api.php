<?php

use Illuminate\Http\Request;
use Illuminate\Support\Facades\Route;
use App\Http\Controllers\Api\AuthController;
use App\Http\Controllers\Api\VendorController;
use App\Http\Controllers\Api\CategoryController;






Route::post('/register', [AuthController::class, 'register']);
Route::post('/login', [AuthController::class, 'login']);
Route::post('/forgot-password', [AuthController::class, 'forgotPassword'])->name('password.email');
Route::post('/reset-password', [AuthController::class, 'resetPassword'])->name('password.reset');

Route::middleware('auth:sanctum')->group(function () {
    Route::post('/logout', [AuthController::class, 'logout']);
});


Route::prefix('categories')->group(function () {
    Route::get('/', [CategoryController::class, 'index']);
});


Route::prefix('vendors')->group(function () {
    Route::get('/', [VendorController::class, 'index']);
    Route::get('/{id}/category', [VendorController::class, 'index']);
    Route::get('/{id}/show', [VendorController::class, 'show']);
    Route::get('/search', [VendorController::class, 'search']);
    Route::get('/getFilter', [VendorController::class, 'getFilter']);

});




