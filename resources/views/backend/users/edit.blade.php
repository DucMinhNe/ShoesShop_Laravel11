@extends('backend.layouts.master')

@section('main-content')

<div class="card">
  <h5 class="card-header">Chỉnh sửa thông tin người dùng</h5>
  <div class="card-body">
    <form method="post" action="{{route('users.update', $user->id)}}" enctype="multipart/form-data">
      @csrf
      @method('PATCH')
      <div class="form-group">
        <label for="inputTitle" class="col-form-label">Tên</label>
        <input id="inputTitle" type="text" name="name" placeholder="Enter name" value="{{$user->name}}" class="form-control">
        @error('name')
        <span class="text-danger">{{$message}}</span>
        @enderror
      </div>

      <div class="form-group">
        <label for="inputEmail" class="col-form-label">Email</label>
        <input id="inputEmail" type="email" name="email" placeholder="Enter email" value="{{$user->email}}" class="form-control" disabled>
        @error('email')
        <span class="text-danger">{{$message}}</span>
        @enderror
      </div>

      <!-- <div class="form-group">
        <label for="inputPhoto" class="col-form-label">Ảnh</label>
        <input id="inputPhoto" type="file" name="photo" class="form-control" onchange="previewImage(event)">
        @error('photo')
        <span class="text-danger">{{$message}}</span>
        @enderror
      </div> -->

      @if($user->photo)
      <div class="form-group">
        <img id="currentPhoto" src="{{ asset($user->photo) }}" alt="User Photo" class="img-fluid rounded-circle mt-3" style="max-width: 100px;">
      </div>
      @endif
      <img id="photoPreview" src="#" alt="Ảnh người dùng" class="img-fluid rounded-circle mt-3" style="max-width: 100px; display: none;">

      @php
      $roles = DB::table('users')->select('role')->get();
      @endphp
      <div class="form-group">
        <label for="role" class="col-form-label">Phân quyền</label>
        <select name="role" class="form-control">
          <option value="">-----Lựa chọn-----</option>
          <option value="admin" {{ $user->role == 'admin' ? 'selected' : '' }}>Admin</option>
          <option value="user" {{ $user->role == 'user' ? 'selected' : '' }}>User</option>
        </select>
        @error('role')
        <span class="text-danger">{{$message}}</span>
        @enderror
      </div>

      <div class="form-group">
        <label for="status" class="col-form-label">Trạng thái</label>
        <select name="status" class="form-control">
          <option value="active" {{ $user->status == 'active' ? 'selected' : '' }}>Hoạt Động</option>
          <option value="inactive" {{ $user->status == 'inactive' ? 'selected' : '' }}>Ngưng Hoạt Động</option>
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