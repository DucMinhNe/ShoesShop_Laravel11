@extends('backend.layouts.master')

@section('main-content')
<div class="container d-flex justify-content-center">
  <div class="card w-75">
    <h5 class="card-header">Chỉnh sửa sản phẩm</h5>
    <div class="card-body">
      <form method="post" action="{{route('product.update',$product->id)}}" enctype="multipart/form-data">
        @csrf
        @method('PATCH')
        <div class="form-group">
          <label for="inputTitle" class="col-form-label">Tiêu đề <span class="text-danger">*</span></label>
          <input id="inputTitle" type="text" name="title" placeholder="Nhập tiêu đề" value="{{$product->title}}" class="form-control">
          @error('title')
          <span class="text-danger">{{$message}}</span>
          @enderror
        </div>

        <div class="form-group">
          <label for="summary" class="col-form-label">Tóm tắt <span class="text-danger">*</span></label>
          <textarea class="form-control" id="summary" name="summary">{{$product->summary}}</textarea>
          @error('summary')
          <span class="text-danger">{{$message}}</span>
          @enderror
        </div>

        <div class="form-group">
          <label for="description" class="col-form-label">Mô tả</label>
          <textarea class="form-control" id="description" name="description">{{$product->description}}</textarea>
          @error('description')
          <span class="text-danger">{{$message}}</span>
          @enderror
        </div>
        <div class="form-group">
          <label for="is_featured">Nổi bật</label>
          <input type="checkbox" name='is_featured' id='is_featured' value='{{$product->is_featured}}' {{(($product->is_featured) ? 'checked' : '')}}>
        </div>
        {{-- {{$categories}} --}}
        <div class="row">
          <div class="col">
            <div class="form-group">
              <label for="cat_id">Danh mục sản phẩm <span class="text-danger">*</span></label>
              <select name="cat_id" id="cat_id" class="form-control">
                <option value="">--Lựa chọn danh mục sản phẩm--</option>
                @foreach($categories as $key=>$cat_data)
                <option value='{{$cat_data->id}}' {{(($product->cat_id==$cat_data->id)? 'selected' : '')}}>{{$cat_data->title}}</option>
                @endforeach
              </select>
            </div>
          </div>
          <div class="col">
            <div class="form-group">
              <label for="brand_id">Thương hiệu</label>
              <select name="brand_id" class="form-control">
                <option value="">--Lựa chọn thương hiệu--</option>
                @foreach($brands as $brand)
                <option value="{{$brand->id}}" {{(($product->brand_id==$brand->id)? 'selected':'')}}>{{$brand->title}}</option>
                @endforeach
              </select>
            </div>
          </div>
        </div>


        @php
        $sub_cat_info=DB::table('categories')->select('title')->where('id',$product->child_cat_id)->get();
        // dd($sub_cat_info);

        @endphp
        {{-- {{$product->child_cat_id}} --}}
        <div class="form-group {{(($product->child_cat_id)? '' : 'd-none')}}" id="child_cat_div">
          <label for="child_cat_id">Danh mục con</label>
          <select name="child_cat_id" id="child_cat_id" class="form-control">
            <option value="">--Lựa chọn danh mục con--</option>
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
              <input id="quantity" type="number" name="stock" min="0" placeholder="Enter quantity" value="{{$product->stock}}" class="form-control">
              @error('stock')
              <span class="text-danger">{{$message}}</span>
              @enderror
            </div>
          </div>
        </div>


        <div class="row">
          <div class="col">
            <div class="form-group">
              <label for="price" class="col-form-label">Giá <span class="text-danger">*</span></label>
              <input id="price" type="number" name="price" placeholder="Enter price" value="{{$product->price}}" class="form-control">
              @error('price')
              <span class="text-danger">{{$message}}</span>
              @enderror
            </div>
          </div>
          <div class="col">
            <div class="form-group">
              <label for="discount" class="col-form-label">Giảm giá(%)</label>
              <input id="discount" type="number" name="discount" min="0" max="100" placeholder="Enter discount" value="{{$product->discount}}" class="form-control">
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
                <option value="">--Lựa chọn tình trạng sản phẩm--</option>
                <option value="default" {{(($product->condition=='default')? 'selected':'')}}>Default</option>
                <option value="new" {{(($product->condition=='new')? 'selected':'')}}>New</option>
                <option value="hot" {{(($product->condition=='hot')? 'selected':'')}}>Hot</option>
              </select>
            </div>
          </div>
          <div class="col">
            <div class="form-group">
              <label for="status" class="col-form-label">Trạng thái <span class="text-danger">*</span></label>
              <select name="status" class="form-control">
                <option value="active" {{(($product->status=='active')? 'selected' : '')}}>Hoạt Động</option>
                <option value="inactive" {{(($product->status=='inactive')? 'selected' : '')}}>Ngưng Hoạt Động</option>
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
          @error('photo')
          <span class="text-danger">{{$message}}</span>
          @enderror
        </div>

        @if($product->photo)
        <div class="form-group">
          <img id="currentPhoto" src="{{ asset($product->photo) }}" alt="product Photo" class="img-fluid rounded-circle mt-3" style="max-width: 100px;">
        </div>
        @endif
        <img id="photoPreview" src="#" alt="Ảnh người dùng" class="img-fluid rounded-circle mt-3" style="max-width: 100px; display: none;">
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
    $('#description').summernote({
      placeholder: "Write detail Description.....",
      tabsize: 2,
      height: 150
    });
  });
</script>

<script>
  var child_cat_id = '{{$product->child_cat_id}}';
  // alert(child_cat_id);
  $('#cat_id').change(function() {
    var cat_id = $(this).val();

    if (cat_id != null) {
      // ajax call
      $.ajax({
        url: "/admin/category/" + cat_id + "/child",
        type: "POST",
        data: {
          _token: "{{csrf_token()}}"
        },
        success: function(response) {
          if (typeof(response) != 'object') {
            response = $.parseJSON(response);
          }
          var html_option = "<option value=''>--Select any one--</option>";
          if (response.status) {
            var data = response.data;
            if (response.data) {
              $('#child_cat_div').removeClass('d-none');
              $.each(data, function(id, title) {
                html_option += "<option value='" + id + "' " + (child_cat_id == id ? 'selected ' : '') + ">" + title + "</option>";
              });
            } else {
              console.log('no response data');
            }
          } else {
            $('#child_cat_div').addClass('d-none');
          }
          $('#child_cat_id').html(html_option);

        }
      });
    } else {

    }

  });
  if (child_cat_id != null) {
    $('#cat_id').change();
  }
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