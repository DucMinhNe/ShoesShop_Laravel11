@extends('backend.layouts.master')

@section('main-content')

<div class="card">
  <h5 class="card-header">Sửa danh mục sản phẩm</h5>
  <div class="card-body">
    <form method="post" action="{{route('category.update',$category->id)}}" enctype="multipart/form-data">
      @csrf
      @method('PATCH')
      <div class="form-group">
        <label for="inputTitle" class="col-form-label">Tiêu Đề <span class="text-danger">*</span></label>
        <input id="inputTitle" type="text" name="title" placeholder="Nhập tiêu đề" value="{{$category->title}}" class="form-control">
        @error('title')
        <span class="text-danger">{{$message}}</span>
        @enderror
      </div>
      <div class="form-group">
        <label for="inputSlug" class="col-form-label">Slug <span class="text-danger">*</span></label>
        <input id="inputSlug" type="text" name="slug" placeholder="Enter title" value="{{$category->slug}}" class="form-control">
        @error('title')
        <span class="text-danger">{{$message}}</span>
        @enderror
      </div>
      <div class="form-group">
        <label for="summary" class="col-form-label">Summary</label>
        <textarea class="form-control" id="summary" name="summary">{{$category->summary}}</textarea>
        @error('summary')
        <span class="text-danger">{{$message}}</span>
        @enderror
      </div>

      <div class="form-group">
        <label for="is_parent">Danh mục cha</label>
        <input type="checkbox" name='is_parent' id='is_parent' value='{{$category->is_parent}}' {{(($category->is_parent==1)? 'checked' : '')}}>
      </div>
      {{-- {{$parent_cats}} --}}
      {{-- {{$category}} --}}

      <div class="form-group {{(($category->is_parent==1) ? 'd-none' : '')}}" id='parent_cat_div'>
        <label for="parent_id">Danh mục cha</label>
        <select name="parent_id" class="form-control">
          <option value="">--Lựa chọn danh mục cha--</option>
          @foreach($parent_cats as $key=>$parent_cat)

          <option value='{{$parent_cat->id}}' {{(($parent_cat->id==$category->parent_id) ? 'selected' : '')}}>{{$parent_cat->title}}</option>
          @endforeach
        </select>
      </div>

      <div class="form-group">
        <label for="inputPhoto" class="col-form-label">Ảnh</label>
        <input id="inputPhoto" type="file" name="photo" class="form-control">
        @error('photo')
        <span class="text-danger">{{$message}}</span>
        @enderror
      </div>

      <div class="form-group">
        <label for="status" class="col-form-label">Status <span class="text-danger">*</span></label>
        <select name="status" class="form-control">
          <option value="active" {{(($category->status=='active')? 'selected' : '')}}>Hoạt Động</option>
          <option value="inactive" {{(($category->status=='inactive')? 'selected' : '')}}>Ngưng Hoạt Động</option>
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

@endsection

@push('styles')
<link rel="stylesheet" href="{{asset('backend/summernote/summernote.min.css')}}">
@endpush
@push('scripts')

<script src="{{asset('backend/summernote/summernote.min.js')}}"></script>
<script>
  $(document).ready(function() {
    $('#summary').summernote({
      placeholder: "Viết một đoạn mô tả ngắn.....",
      tabsize: 2,
      height: 150
    });
  });
</script>
<script>
  $('#is_parent').change(function() {
    var is_checked = $('#is_parent').prop('checked');
    // alert(is_checked);
    if (is_checked) {
      $('#parent_cat_div').addClass('d-none');
      $('#parent_cat_div').val('');
    } else {
      $('#parent_cat_div').removeClass('d-none');
    }
  })
</script>
@endpush