<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;

class NoteModel extends Model
{
    use HasFactory;
    protected $table = 'note';
    protected $fillable = [
        'matiere',
        'note'
    ];
    public $timestamps = false;
}
