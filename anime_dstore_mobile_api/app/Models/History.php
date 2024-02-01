<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;

class History extends Model
{
    protected $fillable = [
        'user_id',
        'item_id',
        'quantity'
    ];
    public $timestamps = false;
    public $table = 'history';
    use HasFactory;

    public function items(){
        $this->hasMany(Item::class, 'item_id', 'id');
    }
}
