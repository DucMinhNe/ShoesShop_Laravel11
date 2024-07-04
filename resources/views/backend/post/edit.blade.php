@extends('backend.layouts.master')

@section('main-content')

<div class="card">
    <h5 class="card-header">Chỉnh sửa bài viết</h5>
    <div class="card-body">
      <form method="post" action="{{route('post.update',$post->id)}}" enctype="multipart/form-data" >
        @csrf
        @method('PATCH')
        <div class="form-group">
          <label for="inputTitle" class="col-form-label">Tiêu đề <span class="text-danger">*</span></label>
          <input id="inputTitle" type="text" name="title" placeholder="Enter title"  value="{{$post->title}}" class="form-control">
          @error('title')
          <span class="text-danger">{{$message}}</span>
          @enderror
        </div>

        <div class="form-group">
          <label for="quote" class="col-form-label">Trích dẫn</label>
          <textarea class="form-control" id="quote" name="quote">{{$post->quote}}</textarea>
          @error('quote')
          <span class="text-danger">{{$message}}</span>
          @enderror
        </div>

        <div class="form-group">
          <label for="summary" class="col-form-label">Tóm tắt <span class="text-danger">*</span></label>
          <textarea class="form-control" id="summary" name="summary">{{$post->summary}}</textarea>
          @error('summary')
          <span class="text-danger">{{$message}}</span>
          @enderror
        </div>

        <div class="form-group">
          <label for="description" class="col-form-label">Mô tả</label>
          <textarea class="form-control" id="description" name="description">{{$post->description}}</textarea>
          @error('description')
          <span class="text-danger">{{$message}}</span>
          @enderror
        </div>

        <div class="form-group">
          <label for="post_cat_id">Danh mục <span class="text-danger">*</span></label>
          <select name="post_cat_id" class="form-control">
              <option value="">--Lựa chọn danh mục--</option>
              @foreach($categories as $key=>$data)
                  <option value='{{$data->id}}' {{(($data->id==$post->post_cat_id)? 'selected' : '')}}>{{$data->title}}</option>
              @endforeach
          </select>
        </div>
        {{-- {{$post->tags}} --}}
        @php
                $post_tags=explode(',',$post->tags);
                // dd($tags);
              @endphp
        <div class="form-group">
          <label for="tags">Thẻ</label>
          <select name="tags[]" multiple  data-live-search="true" class="form-control selectpicker">
              <option value="">--Lựa chọn thẻ--</option>
              @foreach($tags as $key=>$data)

              <option value="{{$data->title}}"  {{(( in_array( "$data->title",$post_tags ) ) ? 'selected' : '')}}>{{$data->title}}</option>
              @endforeach
          </select>
        </div>
        <div class="form-group">
          <label for="added_by">Tác giả</label>
          <select name="added_by" class="form-control">
              <option value="">--Lựa chọn tác giả--</option>
              @foreach($users as $key=>$data)
                <option value='{{$data->id}}' {{(($post->added_by==$data->id)? 'selected' : '')}}>{{$data->name}}</option>
              @endforeach
          </select>
        </div>
        <div class="form-group">
        <label for="inputPhoto" class="col-form-label">Ảnh</label>
        <input id="inputPhoto" type="file" name="photo" class="form-control" onchange="previewImage(event)">
        @error('photo')
        <span class="text-danger">{{$message}}</span>
        @enderror
      </div>

      @if($post->photo)
      <div class="form-group">
        <img id="currentPhoto" src="{{ asset($post->photo) }}" alt="post Photo" class="img-fluid rounded-circle mt-3" style="max-width: 100px;">
      </div>
      @endif
      <img id="photoPreview" src="#" alt="Ảnh người dùng" class="img-fluid rounded-circle mt-3" style="max-width: 100px; display: none;">



        <div class="form-group">
          <label for="status" class="col-form-label">Trạng thái <span class="text-danger">*</span></label>
          <select name="status" class="form-control">
            <option value="active" {{(($post->status=='active')? 'selected' : '')}}>Hoạt Động</option>
            <option value="inactive" {{(($post->status=='inactive')? 'selected' : '')}}>Ngưng Hoạt Động</option>
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
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/bootstrap-select/1.13.1/css/bootstrap-select.css" />

@endpush
@push('scripts')

<script src="{{asset('backend/summernote/summernote.min.js')}}"></script>
<script src="https://cdnjs.cloudflare.com/ajax/libs/bootstrap-select/1.13.1/js/bootstrap-select.min.js"></script>

<script>
    $('#lfm').filemanager('image');

    $(document).ready(function() {
    $('#summary').summernote({
      placeholder: "Viết một đoạn mô tả ngắn.....",
        tabsize: 2,
        height: 150
    });
    });

    $(document).ready(function() {
      $('#quote').summernote({
        placeholder: "Write short Quote.....",
          tabsize: 2,
          height: 100
      });
    });
    $(document).ready(function() {
      $('#description').summernote({
        placeholder: "Write detail description.....",
          tabsize: 2,
          height: 150
      });
    });
</script>
@endpush
@push('scripts')
<script>
  function previewImage(event) {
    var input = event.target;
    var reader = new FileReader();
    reader.onload = function() {
      var dataURL = reader.result;
      var photoPreview = document.getElementById('photoPreview');
      photoPreview.src = dataURL;
      photoPreview.style.display = 'block';
      // Hide the current photo if a new one is selected
      var currentPhoto = document.getElementById('currentPhoto');
      if (currentPhoto) {
        currentPhoto.style.display = 'none';
      }
    };
    reader.readAsDataURL(input.files[0]);
  }
</script>
<script>
  $(document).ready(function() {
    $('form').submit(function(e) {
      e.preventDefault();
      var formData = new FormData(this);
      $.ajax({
        url: $(this).attr('action'),
        type: 'POST',
        data: formData,
        dataType: 'json',
        cache: false,
        contentType: false,
        processData: false,
        success: function(response) {
          Swal.fire({
            icon: "success",
            title: response.success,
            showConfirmButton: false,
            timer: 1000
          }).then(function() {
            window.location.href = '{{ route("post.index") }}';
          });
        },
        error: function(xhr, status, error) {
          var errorMessage = xhr.status + ': ' + xhr.statusText;
          Swal.fire({
            title: 'Lỗi',
            text: 'Có lỗi xảy ra khi thực hiện thao tác',
            icon: 'error',
            closeOnClickOutside: false,
          });
        }
      });
    });
  });
</script>
@endpush