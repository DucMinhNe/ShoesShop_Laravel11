@extends('backend.layouts.master')

@section('main-content')

<div class="card">
  <h5 class="card-header">Thêm quản trị viên</h5>
  <div class="card-body">
    <form method="post" action="{{ route('users.store') }}" enctype="multipart/form-data">
      {{ csrf_field() }}
      <div class="form-group">
        <label for="inputTitle" class="col-form-label">Tên</label>
        <input id="inputTitle" type="text" name="name" placeholder="Nhập tên" value="{{ old('name') }}" class="form-control">
        @error('name')
        <span class="text-danger">{{ $message }}</span>
        @enderror
      </div>

      <div class="form-group">
        <label for="inputEmail" class="col-form-label">Email</label>
        <input id="inputEmail" type="email" name="email" placeholder="Nhập Email" value="{{ old('email') }}" class="form-control">
        @error('email')
        <span class="text-danger">{{ $message }}</span>
        @enderror
      </div>

      <div class="form-group">
        <label for="inputPassword" class="col-form-label">Mật khẩu</label>
        <input id="inputPassword" type="password" name="password" placeholder="Nhập mật khẩu" value="{{ old('password') }}" class="form-control">
        @error('password')
        <span class="text-danger">{{ $message }}</span>
        @enderror
      </div>

      <div class="form-group">
        <label for="inputPhoto" class="col-form-label">Ảnh</label>
        <input id="inputPhoto" type="file" name="photo" class="form-control" onchange="previewImage(event)">
        <img id="photoPreview" src="#" alt="Ảnh người dùng" class="img-fluid rounded-circle mt-3" style="max-width: 100px; display: none;">
        @error('photo')
        <span class="text-danger">{{ $message }}</span>
        @enderror
      </div>

      @php
      $roles = DB::table('users')->select('role')->get();
      @endphp
      <div class="form-group">
        <label for="role" class="col-form-label">Phân quyền</label>
        <select name="role" class="form-control">
          <!-- <option value="">-----Lựa chọn-----</option> -->
          <!-- @foreach($roles as $role)
          <option value="{{ $role->role }}">{{ $role->role }}</option>
          @endforeach -->
          <option value="admin">admin</option>
        </select>
        @error('role')
        <span class="text-danger">{{ $message }}</span>
        @enderror
      </div>

      <div class="form-group">
        <label for="status" class="col-form-label">Trạng thái</label>
        <select name="status" class="form-control">
          <option value="active">Hoạt Động</option>
          <option value="inactive">Ngưng Hoạt Động</option>
        </select>
        @error('status')
        <span class="text-danger">{{ $message }}</span>
        @enderror
      </div>

      <div class="form-group mb-3">
        <button type="reset" class="btn btn-warning">Làm lại</button>
        <button class="btn btn-success" type="submit">Thêm quản trị viên</button>
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
