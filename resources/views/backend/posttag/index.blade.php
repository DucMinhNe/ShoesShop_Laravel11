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
      <h6 class="m-0 font-weight-bold text-primary float-left">Danh sách thẻ bài viết</h6>
      <a href="{{route('post-tag.create')}}" class="btn btn-primary btn-sm float-right" data-toggle="tooltip" data-placement="bottom" title="Add User"><i class="fas fa-plus"></i>Thêm thẻ bài viết</a>
    </div>
    <div class="card-body">
      <div class="table-responsive">
        <table class="table table-bordered" id="post-category-dataTable" width="100%" cellspacing="0">
          <thead>
            <tr>
              <th>STT</th>
              <th>Tiêu đề</th>
              <th>Slug</th>
              <th>Trạng thái</th>
              <th>Thao tác</th>
            </tr>
          </thead>
          <tfoot>
            <tr>
                <th>STT</th>
                <th>Tiêu đề</th>
                <th>Slug</th>
                <th>Trạng thái</th>
                <th>Thao tác</th>
              </tr>
          </tfoot>
          <tbody>
            @foreach($postTags as $data)
                <tr>
                    <td>{{$data->id}}</td>
                    <td>{{$data->title}}</td>
                    <td>{{$data->slug}}</td>
                    <td>
                        @if($data->status=='active')
                            <span class="badge badge-success">Hoạt Động</span>
                        @else
                            <span class="badge badge-warning">Ngưng Hoạt Động</span>
                        @endif
                    </td>
                    <td>
                        <a href="{{route('post-tag.edit',$data->id)}}" class="btn btn-primary btn-sm float-left mr-1" style="height:30px; width:30px;border-radius:50%" data-toggle="tooltip" title="edit" data-placement="bottom"><i class="fas fa-edit"></i></a>
                    <form method="POST" action="{{route('post-tag.destroy',[$data->id])}}">
                      @csrf
                      @method('delete')
                          <button class="btn btn-danger btn-sm dltBtn" data-id={{$data->id}} style="height:30px; width:30px;border-radius:50%" data-toggle="tooltip" data-placement="bottom" title="Delete"><i class="fas fa-trash-alt"></i></button>
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
