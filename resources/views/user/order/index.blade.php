@extends('user.layouts.master')

@section('main-content')
<!-- DataTales Example -->
<div class="card shadow mb-4">
  <div class="row">
    <div class="col-md-12">
      @include('user.layouts.notification')
    </div>
  </div>
  <div class="card-header py-3">
    <h6 class="m-0 font-weight-bold text-primary float-left">Danh sách đơn hàng</h6>
  </div>
  <div class="card-body">
    <div class="table-responsive">
      @if(count($orders)>0)
      <table class="table table-bordered" id="order-dataTable" width="100%" cellspacing="0">
        <thead>
          <tr>
            <th>STT</th>
            <th>Mã đơn hàng</th>
            <th>Tên</th>
            <th>Email</th>
            <th>Số lượng</th>
            <th>Phí vận chuyển</th>
            <th>Tổng</th>
            <th>Trạng thái</th>
            <th>Thao tác</th>
          </tr>
        </thead>
        <tfoot>
          <tr>
            <th>STT</th>
            <th>Mã đơn hàng</th>
            <th>Tên</th>
            <th>Email</th>
            <th>Số lượng</th>
            <th>Phí vận chuyển</th>
            <th>Tổng</th>
            <th>Trạng thái</th>
            <th>Thao tác</th>
          </tr>
        </tfoot>
        <tbody>
          @foreach($orders as $order)
          <tr>
            <td>{{$order->id}}</td>
            <td>{{$order->order_number}}</td>
            <td>{{$order->first_name}} {{$order->last_name}}</td>
            <td>{{$order->email}}</td>
            <td>{{$order->quantity}}</td>
            <td>{{$order->shipping->price}}đ</td>
            <td>{{number_format($order->total_amount,0)}}đ</td>
            <td>
              @if($order->status=='new')
              <span class="badge badge-primary">Mới</span>
              @elseif($order->status=='process')
              <span class="badge badge-warning">Đang xử lý</span>
              @elseif($order->status=='delivered')
              <span class="badge badge-success">Đã giao</span>
              @else
              <span class="badge badge-danger">Hủy</span>
              @endif
            </td>
            <td>
              <a href="{{route('user.order.show',$order->id)}}" class="btn btn-warning btn-sm float-left mr-1" style="height:30px; width:30px;border-radius:50%" data-toggle="tooltip" title="view" data-placement="bottom"><i class="fas fa-eye"></i></a>
              {{-- <form method="POST" action="{{route('user.order.delete',[$order->id])}}">--}}
              {{-- @csrf--}}
              {{-- @method('delete')--}}
              {{-- <button class="btn btn-danger btn-sm dltBtn" data-id={{$order->id}} style="height:30px; width:30px;border-radius:50%" data-toggle="tooltip" data-placement="bottom" title="Delete"><i class="fas fa-trash-alt"></i></button>--}}
              {{-- </form>--}}
            </td>
          </tr>
          @endforeach
        </tbody>
      </table>
      @else
      <h6 class="text-center">Không có đơn hàng nào!!!</h6>
      @endif
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