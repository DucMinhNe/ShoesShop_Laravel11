<?php

namespace App\Http\Controllers;

use Illuminate\Support\Facades\Hash;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\DB;
use App\User;

class UsersController extends Controller
{
    /**
     * Display a listing of the resource.
     *
     * @return \Illuminate\Http\Response
     */
    public function index()
    {
        $users = User::all();
        return view('backend.users.index', compact('users'));
    }

    /**
     * Show the form for creating a new resource.
     *
     * @return \Illuminate\Http\Response
     */
    public function create()
    {
        return view('backend.users.create');
    }

    /**
     * Store a newly created resource in storage.
     *
     * @param  \Illuminate\Http\Request  $request
     * @return \Illuminate\Http\Response
     */
    public function store(Request $request)
    {
        $this->validate(
            $request,
            [
                'name' => 'string|required|max:30',
                'email' => 'string|required|unique:users',
                'password' => 'string|required',
                'role' => 'required|in:admin,user',
                'status' => 'required|in:active,inactive',
                'photo' => 'image',
            ]
        );
        $data = $request->all();
        $data['password'] = Hash::make($request->password);
        if ($request->hasFile('photo')) {
            $file = $request->file('photo');
            $filename = $request->name . "_" . time() . '.' . $file->getClientOriginalExtension();
            $file->move(public_path('user_img'), $filename);
            $data['photo'] = 'user_img/' . $filename;
        }
        $status = User::create($data);
        // dd($status);
        if ($status) {
            // Thông báo thành công bằng SweetAlert và chuyển hướng
            return response()->json(['success' => 'Thêm người dùng thành công']);
        } else {
            // Thông báo lỗi bằng SweetAlert và chuyển hướng
            return response()->json(['error' => 'Có lỗi xảy ra khi thêm người dùng'], 500);
        }
        // return redirect()->route('users.index');
    }

    /**
     * Display the specified resource.
     *
     * @param  int  $id
     * @return \Illuminate\Http\Response
     */
    public function show($id)
    {
        //
    }

    /**
     * Show the form for editing the specified resource.
     *
     * @param  int  $id
     * @return \Illuminate\Http\Response
     */
    public function edit($id)
    {
        $user = User::findOrFail($id);
        return view('backend.users.edit')->with('user', $user);
    }

    /**
     * Update the specified resource in storage.
     *
     * @param  \Illuminate\Http\Request  $request
     * @param  int  $id
     * @return \Illuminate\Http\Response
     */
    public function update(Request $request, $id)
    {
        $user = User::findOrFail($id);
        $this->validate($request, [
            'name' => 'string|required|max:30',
            'email' => 'string|required',
            'role' => 'required|in:admin,user',
            'status' => 'required|in:active,inactive',
            'photo' => 'nullable|image|max:2048',
        ]);

        $data = $request->all();

        // Handle file upload
        if ($request->hasFile('photo')) {
            // Delete the old photo if it exists
            if ($user->photo && file_exists(public_path($user->photo))) {
                unlink(public_path($user->photo));
            }

            // Upload new photo
            $file = $request->file('photo');
            $filename = time() . '.' . $file->getClientOriginalExtension();
            $file->move(public_path('user_img'), $filename);
            $data['photo'] = 'user_img/' . $filename;
        }

        $status = $user->fill($data)->save();
        if ($status) {
            // Thông báo thành công bằng SweetAlert và chuyển hướng
            return response()->json(['success' => 'Cập nhật người dùng thành công']);
        } else {
            // Thông báo lỗi bằng SweetAlert và chuyển hướng
            return response()->json(['error' => 'Có lỗi xảy ra khi cập nhật người dùng'], 500);
        }
        return redirect()->route('users.index');
    }


    /**
     * Remove the specified resource from storage.
     *
     * @param  int  $id
     * @return \Illuminate\Http\Response
     */
    public function destroy($id)
    {
        $delete = User::findorFail($id);
        $status = $delete->delete();
        if ($status) {
            request()->session()->flash('success', 'Xóa người dùng thành công');
        } else {
            request()->session()->flash('error', 'Có lỗi xảy ra khi xóa');
        }
        return redirect()->route('users.index');
    }
}
