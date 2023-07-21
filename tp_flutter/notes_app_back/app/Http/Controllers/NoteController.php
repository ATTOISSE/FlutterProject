<?php

namespace App\Http\Controllers;

use App\Models\NoteModel;
use Illuminate\Http\Request;

class NoteController extends Controller
{
    //
    public function index()
    {
        return NoteModel::all();
    }
    public function addNote(Request $request)
    {
        $note = new NoteModel();
        $note->matiere = $request->matiere;
        $note->note = $request->note;
        return $note->save();
    }
}
