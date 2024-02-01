<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;

class Item extends Model
{
    protected $fillable = [
        'name',
        'category',
        'description',
        'price',
        'image'
    ];

    public $table = 'item';
    use HasFactory;

}
