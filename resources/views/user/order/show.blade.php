@php
use App\Http\Controllers\OrderController;
@endphp
@extends('user.layouts.master')

@section('title','Chi tiết đơn hàng')

@section('main-content')
<div class="card">
  <h5 class="card-header">Chi tiết đơn hàng 
    <!-- <a href="{{route('order.pdf',$order->id)}}" class=" btn btn-sm btn-primary shadow-sm float-right"><i class="fas fa-download fa-sm text-white-50"></i> Xuất File PDF</a> -->
  </h5>
  <div class="card-body">
    @if($order)
    <table class="table table-striped table-hover">
      <thead>
        <tr>
          <th>STT</th>
          <th>Mã đơn hàng</th>
          <th>Tên</th>
          <th>Email</th>
          <!-- <th>Số lượng</th> -->
          <th>Phí vận chuyển</th>
          <th>Tổng</th>
          <th>Trạng thái</th>
          {{-- <th>Thao tác</th>--}}
        </tr>
      </thead>
      <tbody>
        <tr>
          <td>{{$order->id}}</td>
          <td>{{$order->order_number}}</td>
          <td>{{$order->first_name}} {{$order->last_name}}</td>
          <td>{{$order->email}}</td>
          <!-- <td>{{$order->quantity}}</td> -->
          <td>{{$order->shipping->price}} đ</td>
          <td>{{number_format($order->total_amount,0)}} đ</td>
          <td>
            @if($order->status=='new')
            <span class="badge badge-primary">Chờ Xử Lý</span>
            @elseif($order->status=='process')
            <span class="badge badge-warning">Đang Xử Lý</span>
            @elseif($order->status=='delivered')
            <span class="badge badge-success">Đã Giao</span>
            @else
            <span class="badge badge-danger">Đã Hủy</span>
            @endif

          </td>
          <td>
            {{-- <form method="POST" action="{{route('order.destroy',[$order->id])}}">--}}
            {{-- @csrf--}}
            {{-- @method('delete')--}}
            {{-- <button class="btn btn-danger btn-sm dltBtn" data-id={{$order->id}} style="height:30px; width:30px;border-radius:50%" data-toggle="tooltip" data-placement="bottom" title="Delete"><i class="fas fa-trash-alt"></i></button>--}}
            {{-- </form>--}}
          </td>

        </tr>
      </tbody>
    </table>
    <table class="table table-striped table-hover" width="100%" cellspacing="0">
      <thead>
        <tr>
          <th>STT</th>
          <th>Tiêu đề</th>
          <th>Giá</th>
          <!-- <th>Giảm giá</th> -->
          <!-- <th>Size</th> -->
          <th>Số lượng</th>
          <th>Thương hiệu</th>
          <th>Ảnh</th>
        </tr>
      </thead>
      <tbody>
        @foreach ($products as $product)
          <tr>
            <td>{{ $product->id }}</td>
            <td>{{ $product->title }}</td>
            <td>{{ $product->price }} đ</td>
            <!-- <td>{{ $product->discount }}%</td> -->
            <!-- <td>{{ $product->size }}</td> -->
            <td>
                @php
                    $cartItem = \App\Models\Cart::where('user_id', auth()->user()->id)
                        ->where('product_id', $product->id)
                        ->where('order_id', $order->id)
                        ->first();
                @endphp
                @if ($cartItem)
                    {{ $cartItem->quantity }}
                @else
                    0
                @endif
            </td>
            <td>{{ ucfirst($product->brand->title) }}</td>
            <td>
              @if ($product->photo)
                <img src="{{ asset($product->photo) }}" class="img-fluid zoom" style="max-width:80px" alt="{{ $product->photo }}">
              @else
                <img src="{{ asset('backend/img/thumbnail-default.jpg') }}" class="img-fluid" style="max-width:80px" alt="avatar.png">
              @endif
            </td>
        
          </tr>
        @endforeach
      </tbody>
    </table>
    <section class="confirmation_part section_padding">
      <div class="order_boxes">
        <div class="row">
          <div class="col-lg-6 col-lx-4">
            <div class="order-info">
              <h4 class="text-center pb-4">Thông tin đơn hàng</h4>
              <table class="table">
                <tr class="">
                  <td>Mã đơn hàng</td>
                  <td> : {{$order->order_number}}</td>
                </tr>
                <tr>
                  <td>Ngày đặt hàng</td>
                  <td>: {{ OrderController::formatDateToVietnamese($order->created_at) }}</td>
                  <!-- <td> : {{$order->created_at->format('D d M, Y')}} at {{$order->created_at->format('g : i a')}} </td> -->
                </tr>
                <tr>
                  <td>Số lượng</td>
                  <td> : {{$order->quantity}}</td>
                </tr>
                <tr>
                  <td>Trạng thái đơn hàng</td>
                  <td> : @if($order->status=='new')
                    <span class="badge badge-primary">Chờ Xử Lý</span>
                    @elseif($order->status=='process')
                    <span class="badge badge-warning">Đang Xử Lý</span>
                    @elseif($order->status=='delivered')
                    <span class="badge badge-success">Đã Giao</span>
                    @else
                    <span class="badge badge-danger">Đã Hủy</span>
                    @endif
                  </td>
                </tr>
                <tr>
                  @php
                  $shipping_charge=DB::table('shippings')->where('id',$order->shipping_id)->pluck('price');
                  @endphp
                  <td>Phí vận chuyển</td>
                  <td> : {{number_format($order->shipping->price,0)}} đ</td>
                </tr>
                <tr>
                  <td>Tổng</td>
                  <td> : {{number_format($order->total_amount,0)}} đ</td>
                </tr>
                <tr>
                  <td>Phương thức vận chyển</td>
                  <td> : @if($order->payment_method=='cod') Thanh toán khi nhận hàng @elseif($order->payment_method=='vnpay') Thanh toán qua VnPay 
                  @elseif($order->payment_method=='momo') Thanh toán qua Momo @endif</td>
                </tr>
                <tr>
                  <td>Trạng thái thanh toán</td>
                  <td> : @if($order->payment_status=='paid')
                    <span class="badge badge-primary">Đã thanh toán</span>
                    @else
                    <span class="badge badge-warning">Chưa thanh toán</span>
                    @endif
                  </td>
              </table>
            </div>
          </div>

          <div class="col-lg-6 col-lx-4">
            <div class="shipping-info">
              <h4 class="text-center pb-4">Thông tin giao hàng</h4>
              <table class="table">
                <tr class="">
                  <td>Tên đầy đủ</td>
                  <td> : {{$order->first_name}} {{$order->last_name}}</td>
                </tr>
                <tr>
                  <td>Email</td>
                  <td> : {{$order->email}}</td>
                </tr>
                <tr>
                  <td>Số điện thoại</td>
                  <td> : {{$order->phone}}</td>
                </tr>
                <tr>
                  <td>Địa chỉ</td>
                  <td> : {{$order->address1}}, {{$order->address2}}</td>
                </tr>
                <!-- <tr>
                  <td>Quốc gia</td>
                  <td> : {{$order->country}}</td>
                </tr>
                <tr>
                  <td>Mã bưu điện</td>
                  <td> : {{$order->post_code}}</td>
                </tr> -->
              </table>
            </div>
            @if($order->status == 'new' || $order->status == 'process')
            <form id="cancel-order-form" method="POST" action="{{ route('order.cancel', $order->id) }}">
                @csrf
                <button type="button" id="cancel-order-btn" class="btn btn-danger">Hủy Đơn Hàng</button>
            </form>
            @endif
          </div>
        </div>
      </div>
    </section>
    @endif

  </div>
</div>
@endsection

@push('styles')
<style>
  .order-info,
  .shipping-info {
    background: #ECECEC;
    padding: 20px;
  }

  .order-info h4,
  .shipping-info h4 {
    text-decoration: underline;
  }
</style>
@endpush
@push('scripts')
<script src="https://cdn.jsdelivr.net/npm/sweetalert2@11"></script>
<script>
  document.getElementById('cancel-order-btn').addEventListener('click', function(e) {
    Swal.fire({
      title: 'Bạn có chắc chắn?',
      text: "Bạn có muốn hủy đơn hàng này không?",
      icon: 'warning',
      showCancelButton: true,
      confirmButtonColor: '#3085d6',
      cancelButtonColor: '#d33',
      confirmButtonText: 'Có',
      cancelButtonText: 'Không'
    }).then((result) => {
      if (result.isConfirmed) {
        document.getElementById('cancel-order-form').submit();
      }
    })
  });
</script>
@endpush