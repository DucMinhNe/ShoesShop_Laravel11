@php
    use App\Http\Controllers\OrderController;
@endphp
@extends('backend.layouts.master')

@section('title','Order Detail')

@section('main-content')
<div class="card">
  <h5 class="card-header">Đơn hàng</h5>
  <div class="card-body">
    @if($order)
    <table class="table table-striped table-hover">
      <thead>
        <tr>
          <th>STT</th>
          <th>Số hóa đơn</th>
          <th>Tên khách hàng</th>
          <th>Email</th>
          <th>Số lượng</th>
          <th>Phí vận chuyển</th>
          <th>Tổng</th>
          <th>Trạng thái</th>
          <th>Thao tác</th>
        </tr>
      </thead>
      <tbody>
        <tr>
          <td>{{$order->id}}</td>
          <td>{{$order->order_number}}</td>
          <td>{{$order->first_name}} {{$order->last_name}}</td>
          <td>{{$order->email}}</td>
          <td>{{$order->quantity}}</td>
          <td>{{$order->shipping->price}} đ</td>
          <td>{{number_format($order->total_amount,0)}}đ</td>
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
            <a href="{{route('order.edit',$order->id)}}" class="btn btn-primary btn-sm float-left mr-1" style="height:30px; width:30px;border-radius:50%" data-toggle="tooltip" title="edit" data-placement="bottom"><i class="fas fa-edit"></i></a>
          </td>
        </tr>
      </tbody>
    </table>
    <h4>Sản phẩm</h4>
    <table class="table table-striped table-hover" width="100%" cellspacing="0">
      <thead>
        <tr>
          <th>STT</th>
          <th>Tiêu đề</th>
          <th>Danh mục</th>
          <!-- <th>Nổi bật ?</th> -->
          <th>Giá</th>
          <!-- <th>Giảm giá</th> -->
          <th>Size</th>
          <th>Số lượng</th>
          <!-- <th>Tình trạng</th> -->
          <th>Thương hiệu</th>
          <!-- <th>Kho</th> -->
          <th>Ảnh</th>
          <th>Trạng thái</th>
          <!-- <th>Thao tác</th> -->
        </tr>
      </thead>
      <tbody>
        @foreach ($products as $product)
          <tr>
            <td>{{ $product->id }}</td>
            <td>{{ $product->title }}</td>
            <td>{{ $product->cat_info['title'] }}
              <sub>/{{ $product->sub_cat_info->title ?? '' }}</sub>
            </td>
            <!--    <td>{{ $product->is_featured == 1 ? 'Nổi Bật' : 'Không' }}</td> -->
            <td>
                @php
                  $cartItem = \App\Models\Cart::where('product_id', $product->id)
                        ->where('order_id', $order->id)
                        ->first();
                @endphp
                @if ($cartItem)
                    {{ $cartItem->price }} đ
                @else
                    0
                @endif
            </td>
            <!-- <td>{{ $product->price }} đ</td> -->
            <!-- <td>{{ $product->discount }}%</td> -->
            <!-- <td>{{ $product->size }}</td> -->
            <td>
                @php
                  $cartItem = \App\Models\Cart::where('product_id', $product->id)
                        ->where('order_id', $order->id)
                        ->first();
                @endphp
                @if ($cartItem)
                    {{ $cartItem->size }}
                @else
                    0
                @endif
            </td>
            <td>
                @php
                    $cartItem = \App\Models\Cart::where('product_id', $product->id)
                        ->where('order_id', $order->id)
                        ->first();
                @endphp
                @if ($cartItem)
                    {{ $cartItem->quantity }}
                @else
                    0
                @endif
            </td>
            <!-- <td>{{ $product->condition }}</td> -->
            <td>{{ ucfirst($product->brand->title) }}</td>
            <!-- <td>
              @if ($product->stock > 0)
                <span class="badge badge-primary">{{ $product->stock }}</span>
              @else
                <span class="badge badge-danger">{{ $product->stock }}</span>
              @endif
            </td> -->
            <td>
              @if ($product->photo)
                <img src="{{ asset($product->photo) }}" class="img-fluid zoom" style="max-width:80px" alt="{{ $product->photo }}">
              @else
                <img src="{{ asset('backend/img/thumbnail-default.jpg') }}" class="img-fluid" style="max-width:80px" alt="avatar.png">
              @endif
            </td>
            <td>
              @if ($product->status == 'active')
                <span class="badge badge-success">Hoạt Động</span>
              @else
                <span class="badge badge-warning">Ngưng Hoạt Động</span>
              @endif
            </td>
            <!-- <td>
              <a href="{{ route('product.edit', $product->id) }}" class="btn btn-primary btn-sm float-left mr-1" style="height:30px; width:30px;border-radius:50%" data-toggle="tooltip" title="edit" data-placement="bottom"><i class="fas fa-edit"></i></a>
               <form method="POST" action="{{ route('product.destroy', [$product->id]) }}">
                @csrf
                @method('delete')
                <button class="btn btn-danger btn-sm dltBtn" data-id={{ $product->id }} style="height:30px; width:30px;border-radius:50%" data-toggle="tooltip" data-placement="bottom" title="Delete"><i class="fas fa-trash-alt"></i></button>
              </form> 
            </td> -->
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
                  <td>Số hóa đơn</td>
                  <td> : {{$order->order_number}}</td>
                </tr>
                <tr>
                  <td>Ngày đặt hàng</td>
                  <td>: {{ OrderController::formatDateToVietnamese($order->created_at) }}</td>
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
                  <td>Phí vận chuyển</td>
                  <td> : {{number_format($order->shipping->price,0)}}đ</td>
                </tr>
                <tr>
                  <td>Mã giảm giá</td>
                  <td> : {{number_format($order->coupon,0)}}đ</td>
                </tr>
                <tr>
                  <td>Tổng tiền</td>
                  <td> : {{number_format($order->total_amount,0)}}đ</td>
                </tr>
                <tr>
                  <td>Phương thức thanh toán</td>
                  <td> : @if($order->payment_method=='cod') Thanh toán bằng tiền mặt @elseif($order->payment_method=='vnpay') Thanh toán qua VnPay 
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
                </tr>
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
                  <td>Quốc Gia</td>
                  <td> : {{$order->country}}</td>
                </tr>
                <tr>
                  <td>Mã bưu điện</td>
                  <td> : {{$order->post_code}}</td>
                </tr> -->
              </table>
            </div>
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