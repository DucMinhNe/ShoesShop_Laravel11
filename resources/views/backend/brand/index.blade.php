@extends('backend.layouts.master')
@section('title','Shopgiay || Brand Page')
@section('main-content')
 <!-- DataTales Example -->
 <div class="card shadow mb-4">
     <div class="row">
         <div class="col-md-12">
            @include('backend.layouts.notification')
         </div>
     </div>
    <div class="card-header py-3">
      <h6 class="m-0 font-weight-bold text-primary float-left">Danh sách thương hiệu</h6>
      <a href="{{route('brand.create')}}" class="btn btn-primary btn-sm float-right" data-toggle="tooltip" data-placement="bottom" title="Add User"><i class="fas fa-plus"></i> Thêm thương hiệu</a>
    </div>
    <div class="card-body">
      <div class="table-responsive">
        @if(count($brands)>0)
        <table class="table table-bordered" id="banner-dataTable" width="100%" cellspacing="0">
          <thead>
            <tr>
              <th>STT</th>
              <th>Tiêu để</th>
              <th>Slug</th>
              <th>Trạng thái</th>
              <th>Thao tác</th>
            </tr>
          </thead>
          <tfoot>
            <tr>
                <th>STT</th>
                <th>Tiêu để</th>
                <th>Slug</th>
                <th>Trạng thái</th>
                <th>Thao tác</th>
              </tr>
          </tfoot>
          <tbody>
            @foreach($brands as $brand)
                <tr>
                    <td>{{$brand->id}}</td>
                    <td>{{$brand->title}}</td>
                    <td>{{$brand->slug}}</td>
                    <td>
                        @if($brand->status=='active')
                          <span class="badge badge-success">Hoạt Động</span>
                        @else
                          <span class="badge badge-warning">Ngưng Hoạt Động</span>
                        @endif
                    </td>
                    <td>
                        <a href="{{route('brand.edit',$brand->id)}}" class="btn btn-primary btn-sm float-left mr-1" style="height:30px; width:30px;border-radius:50%" data-toggle="tooltip" title="edit" data-placement="bottom"><i class="fas fa-edit"></i></a>
                        <form method="POST" action="{{route('brand.destroy',[$brand->id])}}">
                          @csrf
                          @method('delete')
                              <button class="btn btn-danger btn-sm dltBtn" data-id={{$brand->id}} style="height:30px; width:30px;border-radius:50%" data-toggle="tooltip" data-placement="bottom" title="Delete"><i class="fas fa-trash-alt"></i></button>
                        </form>
                    </td>
                    {{-- Delete Modal --}}
                    {{-- <div class="modal fade" id="delModal{{$user->id}}" tabindex="-1" role="dialog" aria-labelledby="#delModal{{$user->id}}Label" aria-hidden="true">
                        <div class="modal-dialog" role="document">
                          <div class="modal-content">
                            <div class="modal-header">
                              <h5 class="modal-title" id="#delModal{{$user->id}}Label">Delete user</h5>
                              <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                                <span aria-hidden="true">&times;</span>
                              </button>
                            </div>
                            <div class="modal-body">
                              <form method="post" action="{{ route('banners.destroy',$user->id) }}">
                                @csrf
                                @method('delete')
                                <button type="submit" class="btn btn-danger" style="margin:auto; text-align:center">Parmanent delete user</button>
                              </form>
                            </div>
                          </div>
                        </div>
                    </div> --}}
                </tr>
            @endforeach
          </tbody>
        </table>
        @else
          <h6 class="text-center">No brands found!!! Please create brand</h6>
        @endif
      </div>
    </div>
</div>
@endsection

@push('styles')
  <style>
      .zoom {
        transition: transform .2s; /* Animation */
      }

      .zoom:hover {
        transform: scale(3.2);
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
      dom: 'Bfrtip',
      buttons: [{
          extend: 'copy',
          text: 'Sao chép'
        },
        {
          extend: 'excel',
          text: 'Xuất Excel'
        },
        {
          extend: 'pdf',
          text: 'Xuất PDF'
        },
        {
          extend: 'print',
          text: 'In'
        },
        {
          extend: 'colvis',
          text: 'Hiển thị cột'
        },
        {
          extend: 'pageLength',
          text: 'Số bản ghi trên trang'
        }
      ],
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
