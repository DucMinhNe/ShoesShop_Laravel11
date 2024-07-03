@extends('backend.layouts.master')

@section('main-content')

<div class="card">
    <h5 class="card-header">Cài đặt chung</h5>
    <div class="card-body">
    <form method="post" action="{{route('settings.update')}}" enctype="multipart/form-data">
        @csrf
        {{-- @method('PATCH') --}}
        {{-- {{dd($data)}} --}}
        <div class="form-group">
          <label for="short_des" class="col-form-label">Mô tả vắn tắt<span class="text-danger">*</span></label>
          <textarea class="form-control" id="quote" name="short_des">{{$data->short_des}}</textarea>
          @error('short_des')
          <span class="text-danger">{{$message}}</span>
          @enderror
        </div>
        <div class="form-group">
          <label for="description" class="col-form-label">Mô tả đầy đủ <span class="text-danger">*</span></label>
          <textarea class="form-control" id="description" name="description">{{$data->description}}</textarea>
          @error('description')
          <span class="text-danger">{{$message}}</span>
          @enderror
        </div>


        <div class="form-group">
        <label for="inputPhoto" class="col-form-label">Logo</label>
        <input id="inputPhoto" type="file" name="logo" class="form-control" onchange="previewImage(event)">
        @error('photo')
        <span class="text-danger">{{$message}}</span>
        @enderror
      </div>

      @if($data->logo)
      <div class="form-group">
        <img id="currentPhoto" src="{{ asset($data->logo) }}" alt="User Photo" class="img-fluid rounded-circle mt-3" style="max-width: 100px;">
      </div>
      @endif
      <img id="photoPreview" src="#" alt="Ảnh người dùng" class="img-fluid rounded-circle mt-3" style="max-width: 100px; display: none;">


      <div class="form-group">
        <label for="inputPhoto" class="col-form-label">Ảnh đại diện Shop</label>
        <input id="inputPhoto" type="file" name="photo" class="form-control" onchange="previewImage(event)">
        @error('photo')
        <span class="text-danger">{{$message}}</span>
        @enderror
      </div>

      @if($data->photo)
      <div class="form-group">
        <img id="currentPhoto" src="{{ asset($data->logo) }}" alt="User Photo" class="img-fluid rounded-circle mt-3" style="max-width: 100px;">
      </div>
      @endif
      <img id="photoPreview" src="#" alt="Ảnh người dùng" class="img-fluid rounded-circle mt-3" style="max-width: 100px; display: none;">

        <div class="form-group">
          <label for="address" class="col-form-label">Địa chỉ <span class="text-danger">*</span></label>
          <input type="text" class="form-control" name="address" required value="{{$data->address}}">
          @error('address')
          <span class="text-danger">{{$message}}</span>
          @enderror
        </div>
        <div class="form-group">
          <label for="email" class="col-form-label">Email <span class="text-danger">*</span></label>
          <input type="email" class="form-control" name="email" required value="{{$data->email}}">
          @error('email')
          <span class="text-danger">{{$message}}</span>
          @enderror
        </div>
        <div class="form-group">
          <label for="phone" class="col-form-label">Số điện thoại <span class="text-danger">*</span></label>
          <input type="text" class="form-control" name="phone" required value="{{$data->phone}}">
          @error('phone')
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
            window.location.href = '{{ route("users.index") }}';
          });
        },
        error: function(xhr, status, error) {
          var errorMessage = xhr.status + ': ' + xhr.statusText;
          swal({
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