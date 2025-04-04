@extends('backend.layouts.master')

@section('main-content')
<div class="container d-flex justify-content-center">
  <div class="card w-75">
    <h5 class="card-header">Thêm sản phẩm</h5>
    <div class="card-body">
      <form method="post" action="{{ route('product.store')}}" enctype="multipart/form-data">
        {{csrf_field() }}
        <div class="form-group">
          <label for="inputTitle" class="col-form-label">Tiêu đề <span class="text-danger">*</span></label>
          <input id="inputTitle" type="text" name="title" placeholder="Nhập tiêu đề" value="{{old('title')}}" class="form-control">
          @error('title')
          <span class="text-danger">{{$message}}</span>
          @enderror
        </div>

        <div class="form-group">
          <label for="summary" class="col-form-label">Tóm tắt <span class="text-danger">*</span></label>
          <textarea class="form-control" id="summary" name="summary">{{old('summary')}}</textarea>
          @error('summary')
          <span class="text-danger">{{$message}}</span>
          @enderror
        </div>

        <div class="form-group">
          <label for="description" class="col-form-label">Mô tả</label>
          <textarea class="form-control" id="description" name="description">{{old('description')}}</textarea>
          @error('description')
          <span class="text-danger">{{$message}}</span>
          @enderror
        </div>

        <div class="form-group">
          <label for="is_featured">Nổi bật</label>
          <input type="checkbox" name='is_featured' id='is_featured' value='1' checked>
        </div>
        {{-- {{$categories}} --}}
        <div class="row">
          <div class="col">
            <div class="form-group">
              <label for="cat_id">Danh mục sản phẩm <span class="text-danger">*</span></label>
              <select name="cat_id" id="cat_id" class="form-control">
                <option value="">--Lựa chọn danh mục sản phẩm--</option>
                @foreach($categories as $key=>$cat_data)
                <option value='{{$cat_data->id}}'>{{$cat_data->title}}</option>
                @endforeach
              </select>
            </div>
          </div>
          <div class="col">
            <div class="form-group">
              <label for="brand_id">Thương hiệu</label>
              {{-- {{$brands}} --}}
              <select name="brand_id" class="form-control">
                <option value="">--Lựa chọn thương hiệu--</option>
                @foreach($brands as $brand)
                <option value="{{$brand->id}}">{{$brand->title}}</option>
                @endforeach
              </select>
            </div>
          </div>
        </div>

        <div class="form-group d-none" id="child_cat_div">
          <label for="child_cat_id">Danh mục con</label>
          <select name="child_cat_id" id="child_cat_id" class="form-control">
            <option value="">--Lựa chọn danh mục con--</option>
            {{-- @foreach($parent_cats as $key=>$parent_cat)
                  <option value='{{$parent_cat->id}}'>{{$parent_cat->title}}</option>
            @endforeach --}}
          </select>
        </div>

        <div class="row">
          <div class="col">
            <div class="form-group">
              <label for="size">Size</label>
              <select name="size[]" class="form-control selectpicker" multiple data-live-search="true">
                <option value="">--Lựa chọn size--</option>
                <option value="38">38</option>
                <option value="39">39</option>
                <option value="40">40</option>
                <option value="41">41</option>
                <option value="42">42</option>
                <option value="43">43</option>
              </select>
            </div>
          </div>
          <div class="col">
            <div class="form-group">
              <label for="stock">Số lượng <span class="text-danger">*</span></label>
              <input id="quantity" type="number" name="stock" min="0" placeholder="Nhập số lượng" value="{{old('stock')}}" class="form-control">
              @error('stock')
              <span class="text-danger">{{$message}}</span>
              @enderror
            </div>
          </div>
        </div>




        <div class="row">
          <div class="col">
            <div class="form-group">
              <label for="price" class="col-form-label">Đơn giá <span class="text-danger">*</span></label>
              <input id="price" type="number" name="price" placeholder="Nhập giá" value="{{old('price')}}" class="form-control">
              @error('price')
              <span class="text-danger">{{$message}}</span>
              @enderror
            </div>
          </div>
          <div class="col">
            <div class="form-group">
              <label for="discount" class="col-form-label">Giảm giá(%)</label>
              <input id="discount" type="number" name="discount" min="0" max="100" placeholder="Nhập phần trăm giảm giá" value="{{old('discount')}}" class="form-control">
              @error('discount')
              <span class="text-danger">{{$message}}</span>
              @enderror
            </div>
          </div>
        </div>
        <div class="row">
          <div class="col">
            <div class="form-group">
              <label for="condition">Tình trạng</label>
              <select name="condition" class="form-control">
                <option value="">--Lựa chọn tình trạng--</option>
                <option value="default">Default</option>
                <option value="new">New</option>
                <option value="hot">Hot</option>
              </select>
            </div>
          </div>
          <div class="col">
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
          </div>
        </div>
        <div class="form-group">
          <label for="inputPhoto" class="col-form-label">Ảnh</label>
          <input id="inputPhoto" type="file" name="photo" class="form-control" onchange="previewImage(event)">
          <img id="photoPreview" src="#" alt="Ảnh người dùng" class="img-fluid rounded-circle mt-3" style="max-width: 100px; display: none;">
          @error('photo')
          <span class="text-danger">{{ $message }}</span>
          @enderror
        </div>
        <div class="form-group mb-3">
          <button type="reset" class="btn btn-warning">Làm lại</button>
          <button class="btn btn-success" type="submit">Thêm sản phẩm</button>
        </div>
      </form>
    </div>
  </div>
</div>
@endsection

@push('styles')
<link rel="stylesheet" href="{{asset('backend/summernote/summernote.min.css')}}">
<!-- <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/bootstrap-select/1.13.1/css/bootstrap-select.css" /> -->
<link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-select@1.13.14/dist/css/bootstrap-select.min.css">
@endpush
@push('scripts')
<script src="{{asset('backend/summernote/summernote.min.js')}}"></script>
<!-- <script src="https://cdnjs.cloudflare.com/ajax/libs/bootstrap-select/1.13.1/js/bootstrap-select.min.js"></script> -->
<script src="https://cdn.jsdelivr.net/npm/bootstrap-select@1.13.14/dist/js/bootstrap-select.min.js"></script>
<script>
  $(document).ready(function() {
    $('#summary').summernote({
      placeholder: "Viết một đoạn mô tả ngắn.....",
      tabsize: 2,
      height: 100
    });
  });

  $(document).ready(function() {
    $('#description').summernote({
      placeholder: "Viết mô tả chi tiết.....",
      tabsize: 2,
      height: 150
    });
  });
  $(document).ready(function() {
    $('select').selectpicker();
  });
</script>

<script>
  $('#cat_id').change(function() {
    var cat_id = $(this).val();
    // alert(cat_id);
    if (cat_id != null) {
      // Ajax call
      $.ajax({
        url: "/admin/category/" + cat_id + "/child",
        data: {
          _token: "{{csrf_token()}}",
          id: cat_id
        },
        type: "POST",
        success: function(response) {
          if (typeof(response) != 'object') {
            response = $.parseJSON(response)
          }
          // console.log(response);
          var html_option = "<option value=''>----Select sub category----</option>"
          if (response.status) {
            var data = response.data;
            // alert(data);
            if (response.data) {
              $('#child_cat_div').removeClass('d-none');
              $.each(data, function(id, title) {
                html_option += "<option value='" + id + "'>" + title + "</option>"
              });
            } else {}
          } else {
            $('#child_cat_div').addClass('d-none');
          }
          $('#child_cat_id').html(html_option);
        }
      });
    } else {}
  })
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
            window.location.href = '{{ route("product.index") }}';
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