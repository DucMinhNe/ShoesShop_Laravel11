@extends('backend.layouts.master')
@section('title','Shopgiay || Brand Create')
@section('main-content')
<div class="container d-flex justify-content-center">
  <div class="card w-75">
    <h5 class="card-header">Thêm thương hiệu</h5>
    <div class="card-body">
      <form method="post" action="{{route('brand.store')}}">
        {{csrf_field()}}
        <div class="form-group">
          <label for="inputTitle" class="col-form-label">Tiêu đề <span class="text-danger">*</span></label>
          <input id="inputTitle" type="text" name="title" placeholder="Nhập Tiêu Đề" value="{{old('title')}}" class="form-control">
          @error('title')
          <span class="text-danger">{{$message}}</span>
          @enderror
        </div>
        <div class="form-group">
          <label for="status" class="col-form-label">Trạng thái <span class="text-danger">*</span></label>
          <select name="status" class="form-control">
            <option value="active">Hoạt Động</option>
            <option value="active">Ngưng Hoạt Động</option>
          </select>
          @error('status')
          <span class="text-danger">{{$message}}</span>
          @enderror
        </div>
        <div class="form-group mb-3">
          <button type="reset" class="btn btn-warning">Làm lại</button>
          <button class="btn btn-success" type="submit">Thêm thương hiệu</button>
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