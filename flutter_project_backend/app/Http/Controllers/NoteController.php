<?php

namespace App\Http\Controllers;

use App\Models\Note;
use Illuminate\Http\Request;

class NoteController extends Controller
{
    public function index()
    {
        $note = Note::all();
        return response()->json($note);
    }

    public function store(Request $request)
    {
        $note = Note::create([
            'note' => $request->input('note'),
            'matiere' => $request->input('matiere'),
        ]);
        //$note = new Note();


        return response()->json([
            'message' => 'Note ajoutée avec succès',
            'notes' => $note,
        ], 200);
    }
}