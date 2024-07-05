@extends('backend.layouts.master')
@section('title','Shopgiay || Brand Edit')
@section('main-content')

<div class="container d-flex justify-content-center">
  <div class="card w-75">
    <h5 class="card-header">Chỉnh sửa thương hiệu</h5>
    <div class="card-body">
      <form method="post" action="{{route('brand.update',$brand->id)}}">
        @csrf
        @method('PATCH')
        <div class="row">
          <div class="col">
            <div class="form-group">
              <label for="inputTitle" class="col-form-label">Tiêu đề <span class="text-danger">*</span></label>
              <input id="inputTitle" type="text" name="title" placeholder="Enter title" value="{{$brand->title}}" class="form-control">
              @error('title')
              <span class="text-danger">{{$message}}</span>
              @enderror
            </div>
          </div>
          <div class="col">
            <div class="form-group">
              <label for="inputSlug" class="col-form-label">Slug <span class="text-danger">*</span></label>
              <input id="inputSlug" type="text" name="slug" placeholder="Enter title" value="{{$brand->slug}}" class="form-control">
              @error('title')
              <span class="text-danger">{{$message}}</span>
              @enderror
            </div>
          </div>
        </div>


        <div class="form-group">
          <label for="status" class="col-form-label">Trạng thái <span class="text-danger">*</span></label>
          <select name="status" class="form-control">
            <option value="active" {{(($brand->status=='active') ? 'selected' : '')}}>Hoạt Động</option>
            <option value="inactive" {{(($brand->status=='inactive') ? 'selected' : '')}}>Ngưng Hoạt Động</option>
          </select>
          @error('status')
          <span class="text-danger">{{$message}}</span>
          @enderror
        </div>
        <div class="form-group mb-3">
          <button class="btn btn-success" type="submit">Cập nhật</button>
        </div>
      </form>
    </div>
  </div>
</div>
@endsection

@push('styles')
<link rel="stylesheet" href="{{asset('backend/summernote/summernote.min.css')}}">
@endpush
@push('scripts')

<script src="{{asset('backend/summernote/summernote.min.js')}}"></script>
<script>

  $(document).ready(function() {
    $('#description').summernote({
      placeholder: "Write short description.....",
      tabsize: 2,
      height: 150
    });
  });
</script>
@endpush