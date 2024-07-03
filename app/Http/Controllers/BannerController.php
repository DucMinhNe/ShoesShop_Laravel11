<?php

namespace App\Http\Controllers;

use Illuminate\Http\Request;
use App\Models\Banner;
use Illuminate\Support\Str;
class BannerController extends Controller
{
    /**
     * Display a listing of the resource.
     *
     * @return \Illuminate\Http\Response
     */
    public function index()
    {
        $banner=Banner::all();
        return view('backend.banner.index')->with('banners',$banner);
    }

    /**
     * Show the form for creating a new resource.
     *
     * @return \Illuminate\Http\Response
     */
    public function create()
    {
        return view('backend.banner.create');
    }

    /**
     * Store a newly created resource in storage.
     *
     * @param  \Illuminate\Http\Request  $request
     * @return \Illuminate\Http\Response
     */
    public function store(Request $request)
    {
        // return $request->all();
        $this->validate($request,[
            'title'=>'string|required|max:50',
            'description'=>'string|nullable',
            'photo'=>'image|nullable',
            'status'=>'required|in:active,inactive',
        ]);
        $data=$request->all();
        if ($request->hasFile('photo')) {
            $file = $request->file('photo');
            $filename = $request->name . "_" . time() . '.' . $file->getClientOriginalExtension();
            $file->move(public_path('banner_img'), $filename);
            $data['photo'] = 'banner_img/' . $filename;
        }
        $slug=Str::slug($request->title);
        $count=Banner::where('slug',$slug)->count();
        if($count>0){
            $slug=$slug.'-'.date('ymdis').'-'.rand(0,999);
        }
        $data['slug']=$slug;
        // return $slug;
        $status=Banner::create($data);
        if ($status) {
            return response()->json(['success' => 'Cập nhật Banner thành công']);
        } else {
            return response()->json(['error' => 'Có lỗi xảy ra khi cập nhật Banner'], 500);
        }
        // return redirect()->route('banner.index');
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
        $banner=Banner::findOrFail($id);
        return view('backend.banner.edit')->with('banner',$banner);
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
        $banner=Banner::findOrFail($id);
        $this->validate($request,[
            'title'=>'string|required|max:50',
            'description'=>'string|nullable',
            'photo'=>'image|nullable',
            'status'=>'required|in:active,inactive',
        ]);
        $data=$request->all();
        // $slug=Str::slug($request->title);
        // $count=Banner::where('slug',$slug)->count();
        // if($count>0){
        //     $slug=$slug.'-'.date('ymdis').'-'.rand(0,999);
        // }
        // $data['slug']=$slug;
        // return $slug;
        if ($request->hasFile('photo')) {
            // Delete the old photo if it exists
            if ($banner->photo && file_exists(public_path($banner->photo))) {
                unlink(public_path($banner->photo));
            }
            // Upload new photo
            $file = $request->file('photo');
            $filename = time() . '.' . $file->getClientOriginalExtension();
            $file->move(public_path('banner_img'), $filename);
            $data['photo'] = 'banner_img/' . $filename;
        }
        $status=$banner->fill($data)->save();
        if ($status) {
            return response()->json(['success' => 'Cập nhật bài viết thành công']);
        } else {
            return response()->json(['error' => 'Có lỗi xảy ra khi cập nhật bài viết'], 500);
        }
        // return redirect()->route('banner.index');
    }

    /**
     * Remove the specified resource from storage.
     *
     * @param  int  $id
     * @return \Illuminate\Http\Response
     */
    public function destroy($id)
    {
        $banner=Banner::findOrFail($id);
        $status=$banner->delete();
        if($status){
            request()->session()->flash('success','Xóa Banner thành công');
        }
        else{
            request()->session()->flash('error','Có lỗi xảy ra trong quá trình xóa Banner');
        }
        return redirect()->route('banner.index');
    }
}
