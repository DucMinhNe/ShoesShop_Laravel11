@extends('backend.layouts.master')

@section('main-content')
 <!-- DataTales Example -->
 <div class="card shadow mb-4">
     <div class="row">
         <div class="col-md-12">
            @include('backend.layouts.notification')
         </div>
     </div>
    <div class="card-header py-3">
      <h6 class="m-0 font-weight-bold text-primary float-left">Danh sách bài viết</h6>
      <a href="{{route('post.create')}}" class="btn btn-primary btn-sm float-right" data-toggle="tooltip" data-placement="bottom" title="Add User"><i class="fas fa-plus"></i> Thêm bài viết</a>
    </div>
    <div class="card-body">
      <div class="table-responsive">
        <table class="table table-bordered" id="product-dataTable" width="100%" cellspacing="0">
          <thead>
            <tr>
              <th>STT</th>
              <th>Tiêu đề</th>
              <th>Danh mục</th>
              <th>Thẻ</th>
              <th>Tác giả</th>
              <th>Ảnh</th>
              <th>Trạng thái</th>
              <th>Thao tác</th>
            </tr>
          </thead>
          <tfoot>
            <tr>
                <th>STT</th>
                <th>Tiêu đề</th>
                <th>Danh mục</th>
                <th>Thẻ</th>
                <th>Tác giả</th>
                <th>Ảnh</th>
                <th>Trạng thái</th>
                <th>Thao tác</th>
            </tr>
          </tfoot>
          <tbody>

            @foreach($posts as $post)
              @php
              $author_info=DB::table('users')->select('name')->where('id',$post->added_by)->get();
              // dd($sub_cat_info);
              // dd($author_info);

              @endphp
                <tr>
                    <td>{{$post->id}}</td>
                    <td>{{$post->title}}</td>
                    <td>{{$post->cat_info->title}}</td>
                    <td>{{$post->tags}}</td>

                    <td>
                      @foreach($author_info as $data)
                          {{$data->name}}
                      @endforeach
                    </td>
                    <td>
                          @if ($post->photo)
                
                                            <img src="{{ asset($post->photo) }}" class="img-fluid zoom" style="max-width:80px"
                                                alt="{{ $post->photo }}">
                                        @else
                                            <img src="{{ asset('backend/img/thumbnail-default.jpg') }}" class="img-fluid"
                                                style="max-width:80px" alt="avatar.png">
                                        @endif
                                    </td>
    
                    <td>
                        @if($post->status=='active')
                            <span class="badge badge-success">Hoạt Động</span>
                        @else
                            <span class="badge badge-warning">Ngưng Hoạt Động</span>
                        @endif
                    </td>
                    <td>
                        <a href="{{route('post.edit',$post->id)}}" class="btn btn-primary btn-sm float-left mr-1" style="height:30px; width:30px;border-radius:50%" data-toggle="tooltip" title="edit" data-placement="bottom"><i class="fas fa-edit"></i></a>
                    <form method="POST" action="{{route('post.destroy',[$post->id])}}">
                      @csrf
                      @method('delete')
                          <button class="btn btn-danger btn-sm dltBtn" data-id={{$post->id}} style="height:30px; width:30px;border-radius:50%" data-toggle="tooltip" data-placement="bottom" title="Delete"><i class="fas fa-trash-alt"></i></button>
                        </form>
                    </td>
                </tr>
            @endforeach
          </tbody>
        </table>

      </div>
    </div>
</div>
@endsection

@push('styles')
  <link href="{{asset('backend/vendor/datatables/dataTables.bootstrap4.min.css')}}" rel="stylesheet">
  <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/sweetalert/1.1.3/sweetalert.min.css" />
  <style>
      .zoom {
        transition: transform .2s; /* Animation */
      }

      .zoom:hover {
        transform: scale(5);
      }
  </style>
@endpush

@push('scripts')
<script>
  $(document).ready(function() {
    $.ajaxSetup({
      headers: {
        'X-CSRF-TOKEN': $('meta[name="csrf-token"]').attr('content')
      }
    });
    var table = $('.table').DataTable({
      language: {
        "sEmptyTable": "Không có dữ liệu",
        "sInfo": "Hiển thị _START_ đến _END_ của _TOTAL_ bản ghi",
        "sInfoEmpty": "Hiển thị 0 đến 0 của 0 bản ghi",
        "sInfoFiltered": "(được lọc từ _MAX_ tổng số bản ghi)",
        "sInfoPostFix": "",
        "sInfoThousands": ",",
        "sLengthMenu": "Hiển thị _MENU_ bản ghi",
        "sLoadingRecords": "Đang tải...",
        "sProcessing": "Đang xử lý...",
        "sSearch": "Tìm kiếm:",
        "sZeroRecords": "Không tìm thấy kết quả nào phù hợp",
        "oPaginate": {
          "sFirst": "Đầu",
          "sLast": "Cuối",
          "sNext": "Tiếp",
          "sPrevious": "Trước"
        },
        "oAria": {
          "sSortAscending": ": Sắp xếp tăng dần",
          "sSortDescending": ": Sắp xếp giảm dần"
        }
      },
  
    });
    $('.dltBtn').click(function(e) {
      var form = $(this).closest('form');
      var dataID = $(this).data('id');
      e.preventDefault();
      Swal.fire({
        title: "Bạn có chắc không?",
        text: "Khi xóa sẽ không thể khôi phục dữ liệu!",
        icon: "warning",
        showDenyButton: true,
        confirmButtonText: "Xóa",
        denyButtonText: `Hủy`
      }).then((result) => {
        if (result.isConfirmed) {
          form.submit();
        } else if (result.isDenied) {
          Swal.fire("Dữ liệu an toàn!", "", "info");
        }
      });
    })
  })
</script>
@endpush