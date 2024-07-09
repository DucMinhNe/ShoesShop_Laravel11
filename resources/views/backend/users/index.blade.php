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
    <h6 class="m-0 font-weight-bold text-primary float-left">Danh sách người dùng</h6>
    <a href="{{route('users.create')}}" class="btn btn-primary btn-sm float-right" data-toggle="tooltip" data-placement="bottom" title="Add User"><i class="fas fa-plus"></i> Thêm người dùng</a>
  </div>
  <div class="card-body">
    <div class="table-responsive">
      <table class="table table-bordered" id="data-table" width="100%">
        <thead>
          <tr>
            <th>STT</th>
            <th>Tên</th>
            <th>Email</th>
            <th>Ảnh</th>
            <th>Ngày tham gia</th>
            <th>Phân quyền</th>
            <th>Trạng thái</th>
            <th>Thao tác</th>
          </tr>
        </thead>
        <tfoot>
          <tr>
            <th>STT</th>
            <th>Tên</th>
            <th>Email</th>
            <th>Ảnh</th>
            <th>Ngày tham gia</th>
            <th>Phân quyền</th>
            <th>Trạng thái</th>
            <th>Thao tác</th>
          </tr>
        </tfoot>
        <tbody>
          @foreach($users as $user)
          <tr>
            <td>{{$user->id}}</td>
            <td>{{$user->name}}</td>
            <td>{{$user->email}}</td>
            <td>
              @if($user->photo)
              <img src="{{ asset($user->photo) }}" class="img-fluid rounded-circle" style="max-width:50px" alt="{{$user->photo}}">
              @else
              <img src="{{asset('backend/img/avatar.png')}}" class="img-fluid rounded-circle" style="max-width:50px" alt="avatar.png">
              @endif
            </td>
            <td>{{(($user->created_at)? $user->created_at->diffForHumans() : '')}}</td>
            <td>{{$user->role}}</td>
            <td>
              @if($user->status=='active')
              <span class="badge badge-warning">Hoạt Động</span>
              @else
              <span class="badge badge-warning">Ngưng Hoạt Động</span>
              @endif
            </td>
            <td>
              <a href="{{route('users.edit',$user->id)}}" class="btn btn-primary btn-sm float-left mr-1" style="height:30px; width:30px;border-radius:50%" data-toggle="tooltip" title="edit" data-placement="bottom"><i class="fas fa-edit"></i></a>
              <form method="POST" action="{{route('users.destroy',[$user->id])}}">
                @csrf
                @method('delete')
                <button class="btn btn-danger btn-sm dltBtn" data-id={{$user->id}} style="height:30px; width:30px;border-radius:50%" data-toggle="tooltip" data-placement="bottom" title="Delete"><i class="fas fa-trash-alt"></i></button>
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
                  <form method="post" action="{{ route('users.destroy',$user->id) }}">
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