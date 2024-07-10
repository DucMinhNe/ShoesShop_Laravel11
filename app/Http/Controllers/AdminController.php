<?php

namespace App\Http\Controllers;

use Illuminate\Http\Request;
use App\Models\Settings;
use App\User;
use App\Rules\MatchOldPassword;
use Hash;
use Carbon\Carbon;
use Spatie\Activitylog\Models\Activity;
class AdminController extends Controller
{
    public function index(){
        $data = User::select(\DB::raw("COUNT(*) as count"), \DB::raw("DAYNAME(created_at) as day_name"), \DB::raw("DAY(created_at) as day"))
        ->where('created_at', '>', Carbon::today()->subDay(6))
        ->groupBy('day_name','day')
        ->orderBy('day')
        ->get();
     $array[] = ['Name', 'Number'];
     foreach($data as $key => $value)
     {
       $array[++$key] = [$value->day_name, $value->count];
     }
    //  return $data;
     return view('backend.index')->with('users', json_encode($array));
    }

    public function profile(){
        $profile=Auth()->user();
        // return $profile;
        return view('backend.users.profile')->with('profile',$profile);
    }

    public function profileUpdate(Request $request,$id){
        // return $request->all();
        $user=User::findOrFail($id);
        $data=$request->all();
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
        $status=$user->fill($data)->save();
        if ($status) {
            // Thông báo thành công bằng SweetAlert và chuyển hướng
            return response()->json(['success' => 'Cập nhật thành công thông tin cá nhân']);
        } else {
            // Thông báo lỗi bằng SweetAlert và chuyển hướng
            return response()->json(['error' => 'Có lỗi xảy ra khi cập nhật người dùng'], 500);
        }
            // return redirect()->back();
    }

    public function settings(){
        $data=Settings::first();
        return view('backend.setting')->with('data',$data);
    }

    public function settingsUpdate(Request $request){
        // return $request->all();
        $this->validate($request,[
            'short_des'=>'required|string',
            'description'=>'required|string',
            'photo'=>'image|nullable',
            'logo'=>'image|nullable',
            'address'=>'required|string',
            'email'=>'required|email',
            'phone'=>'required|string',
        ]);
        $data=$request->all();
        // return $data;
        $settings=Settings::first();
        if ($request->hasFile('photo')) {
            // Delete the old photo if it exists
            if ($settings->photo && file_exists(public_path($settings->photo))) {
                unlink(public_path($settings->photo));
            }
            // Upload new photo
            $file = $request->file('photo');
            $filename = time() . '.' . $file->getClientOriginalExtension();
            $file->move(public_path('setting_img'), $filename);
            $data['photo'] = 'setting_img/' . $filename;
        }
        if ($request->hasFile('logo')) {
            // Delete the old photo if it exists
            if ($settings->logo && file_exists(public_path($settings->logo))) {
                unlink(public_path($settings->logo));
            }
            // Upload new photo
            $file = $request->file('logo');
            $filename = time() . '.' . $file->getClientOriginalExtension();
            $file->move(public_path('logo_img'), $filename);
            $data['logo'] = 'logo_img/' . $filename;
        }
        // return $settings;
        $status=$settings->fill($data)->save();
        if ($status) {
            // Thông báo thành công bằng SweetAlert và chuyển hướng
            return response()->json(['success' => 'Cập nhật sản phẩm thành công']);
        } else {
            // Thông báo lỗi bằng SweetAlert và chuyển hướng
            return response()->json(['error' => 'Có lỗi xảy ra khi cập nhật sản phẩm'], 500);
        }
        // return redirect()->route('admin');
    }

    public function changePassword(){
        return view('backend.layouts.changePassword');
    }
    public function changPasswordStore(Request $request)
    {
        $request->validate([
            'current_password' => ['required', new MatchOldPassword],
            'new_password' => ['required'],
            'new_confirm_password' => ['same:new_password'],
        ]);

        User::find(auth()->user()->id)->update(['password'=> Hash::make($request->new_password)]);

        return redirect()->route('admin')->with('success','thay đổi mật khẩu thành công');
    }

    // Pie chart
    public function userPieChart(Request $request){
        // dd($request->all());
        $data = User::select(\DB::raw("COUNT(*) as count"), \DB::raw("DAYNAME(created_at) as day_name"), \DB::raw("DAY(created_at) as day"))
        ->where('created_at', '>', Carbon::today()->subDay(6))
        ->groupBy('day_name','day')
        ->orderBy('day')
        ->get();
     $array[] = ['Name', 'Number'];
     foreach($data as $key => $value)
     {
       $array[++$key] = [$value->day_name, $value->count];
     }
    //  return $data;
     return view('backend.index')->with('course', json_encode($array));
    }

    // public function activity(){
    //     return Activity::all();
    //     $activity= Activity::all();
    //     return view('backend.layouts.activity')->with('activities',$activity);
    // }
}
